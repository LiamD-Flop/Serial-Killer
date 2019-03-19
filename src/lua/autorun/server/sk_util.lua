--[[---------------------------------------------------------
	Addon:  Serial Killer
  Author: LiamD. Aka Flop
-----------------------------------------------------------]]
util.AddNetworkString("SerialStart")
util.AddNetworkString("SKChatMsg")

local BodyEntities = {}
local SK_SUICIDE, SK_KILLED = 0, 1

net.Receive("SerialStart",function(len, ply)
	SKStartingFrags = ply:Frags()
	SerialKillerPly = ply
	ply:SetFrags(0)
end)

function SerialKillerDied( sk, gov, cause )
	if (cause == SK_SUICIDE) then
		SKChat(sk, "You commited suicide, you wont get any of your money.", "SKGeneral", "0", false)
	elseif (cause == SK_KILLED) then
		SKEndFrags = sk:Frags()
		SKMoney = SK.Config.KStart + (SK.Config.KReward * SKEndFrags)
		GovMoney = SK.Config.GStart - (SK.Config.GPenalty * SKEndFrags)
		GovMoney = GovMoney <= SK.Config.GMin and SK.Config.GMin or GovMoney
		TotalFrags = SKEndFrags+SKStartingFrags
		gov:addMoney(GovMoney)
		sk:addMoney(SKMoney)
		sk:AddFrags(TotalFrags)
		SKChat(sk, " for killing "..tostring(SKEndFrags).." people.", "SKAmount", SKMoney, false)
		SKChat(gov, " for killing the SerialKiller.", "SKAmount", GovMoney, false)
		SKChat(sk, "The Serial Killer has been killed by "..gov:Nick(), "SKGeneral", "0", true)
	end
	clearEntities()
end

function clearEntities()
	for k, v in pairs(BodyEntities) do
		for _,q in pairs(ents.GetAll()) do
			if v == q:EntIndex() then
				q:Remove()
			end
		end
	end
	BodyEntities = {}
end

function BodyCreate( victim )
	local ragdoll = ents.Create("prop_ragdoll")
	ragdoll:SetPos(victim:GetPos())
	ragdoll:SetModel(victim:GetModel())
	ragdoll:Spawn()
	ragdoll:Activate()
	ragdoll:SetVelocity(victim:GetVelocity())
	ragdoll.Owner = victim
	ragdoll.Useable = true
	ragdoll.DeathTime = os.time()
	table.insert(BodyEntities, ragdoll:EntIndex())
end


function SerialKillerCl( victim, inflictor, attacker )
	if ( team.GetName( victim:Team() ) == SK.Config.JobK.name or team.GetName( attacker:Team() ) == SK.Config.JobK.name ) then

		if ( victim == attacker or attacker:IsWorld()) then
			SerialKillerDied( victim, attacker, SK_SUICIDE )
		elseif ( team.GetName( attacker:Team() ) == SK.Config.JobK.name ) then
			BodyCreate( victim )
		elseif ( table.HasValue( SK.Config.Government, team.GetName(attacker:Team())) ) then
			if victim:Frags() > 0 then
				SerialKillerDied( victim, attacker, SK_KILLED )
			else
				SKChat(victim, "You didn't have any kills yet.", "SKGeneral", "0", false)
				SKChat(attacker, "The Serial Killer didn't get any kills yet.", "SKGeneral", "0", false)
			end
		else
			print('FML')
		end

	end
end

hook.Add("PlayerDeath","CheckSerialK",SerialKillerCl)

function PlayerUseRagdoll(ply, key)
	if key == IN_USE and IsValid(ply) then
		if table.HasValue(SK.Config.Government, team.GetName(ply:Team())) then
			local tr = util.TraceLine({
			start  = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 84,
			filter = ply,
			mask   = MASK_SHOT
			})
			local ent = tr.Entity
			if tr.Hit and IsValid(ent) and ent:GetClass() == "prop_ragdoll" and ent.Useable then
				ent.Useable = false
				SerialKillerPly:wanted(ply,"Murder Found")
				Time = os.difftime(os.time(), ent.DeathTime)
				Ts = Time
				Time = math.Round((Time/60),0)
				ply:addMoney(SK.Config.BodyReward)
				SKChat(ply, "You found someone who has been killed by the SerialKiller. Time of Death: "..tostring(Time).."m ago.", "SKGeneral", "0", false)
				ent:Remove()
			end
		end
	end
end
hook.Add("KeyRelease", "KeyReleasedHook", PlayerUseRagdoll)

function SKChat(ply, str, type, amount, global)
	if global == true then
		net.Start("SKChatMsg")
			net.WriteString(type)
			net.WriteString(str)
			net.WriteString(amount)
		net.Broadcast()
	else
		net.Start("SKChatMsg")
			net.WriteString(type)
			net.WriteString(str)
			net.WriteString(amount)
		net.Send(ply)
	end
end

hook.Add("OnPlayerChangedTeam","TeamChange",function(ply,ot,nt)
	if SK.Config.JobK == team.GetName( ot ) then
		for k, v in pairs(BodyEntities) do
			for _,q in pairs(ents.GetAll()) do
				if v == q:EntIndex() then
					q:Remove()
				end
			end
		end
	end
end)
