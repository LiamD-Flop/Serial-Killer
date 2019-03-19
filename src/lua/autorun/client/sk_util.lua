--[[---------------------------------------------------------
	Addon:  Serial Killer
  Author: LiamD. Aka Flop
-----------------------------------------------------------]]
function SerialKillerStartingFrags( SerialK, ST, NT )
	if team.GetName(NT) == SK.Config.JobK.name then
		net.Start("SerialStart")
		net.SendToServer()
	end
end

hook.Add("OnPlayerChangedTeam","SerialKillerF",SerialKillerStartingFrags)

net.Receive("SKChatMsg",function()
	local MsgType = net.ReadString()
	local SKMsg = net.ReadString()
	local SKAmount = net.ReadString()
	if MsgType == "SKGeneral" then
		chat.AddText(Color(220,20,60), "[SerialKiller]: ", Color(255,255,255), SKMsg)
	elseif MsgType == "SKAmount" then
		chat.AddText(Color(220,20,60), "[SerialKiller]: ", Color(255,255,255), "You received ", Color(20,220,60), "$"..SKAmount, Color(255,255,255), SKMsg)
	end
end)
