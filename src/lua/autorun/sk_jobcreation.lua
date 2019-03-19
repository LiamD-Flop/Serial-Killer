--[[---------------------------------------------------------
	Addon:  Serial Killer
  Author: LiamD. Aka Flop
-----------------------------------------------------------]]

if SK.Config.CJob == true then
	timer.Simple(1, function()
		TEAM_FLOPSKILLER = DarkRP.createJob(SK.Config.JobK.name, {
	    color = SK.Config.JobK.color,
	    model = SK.Config.JobK.models,
	    description = SK.Config.JobK.description,
	    weapons = SK.Config.JobK.weapons,
	    command = "serialkiller",
	    max = 1,
	    salary = 150,
	    admin = 0,
	    vote = false,
	    hasLicense = false,
	    candemote = false,
	    category = SK.Config.JobK.category,
	    PlayerDeath = function(ply, weapon, killer)
	        ply:teamBan()
	        ply:changeTeam(GAMEMODE.DefaultTeam, true)
	        DarkRP.notifyAll(0, 4, "The Serial Killer died")
	    end
		})
	end)
end
