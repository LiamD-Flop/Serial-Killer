--[[---------------------------------------------------------
	Addon:  Serial Killer
  Author: LiamD. Aka Flop
-----------------------------------------------------------]]
SK = {}
SK.Config = {}
SK.Active = false
--[[-------------------------------------------------------------------------
Want me to create the job ?? Default true, false if you use your own Job "darkrp_customthings/jobs.lua".
Make sure the TeamK and the TEAM_ your set int he jobs.lua are the same (Only if you put SK.Config.CJob to "false")
---------------------------------------------------------------------------]]
SK.Config.CJob = true
SK.Config.JobK = { --This will be the job name change it however you want (If SK.Config.CJob = false, change this to the job name you set)
  name = "Serial Killer",                       --This is the name of the serial killer (If you use your own job please put the name here for it to work)
  category = "Citizens",                        --This is the category the serial killer will be put in
  color = Color(204, 23, 23, 255),              --This is the job color
  description = [[You kill people, Because you like it I guess]],  --This is the job description
  models = {"models/player/gman_high.mdl"},     --These are the models the player can choose from
  weapons = {"m9k_knife"}                       --These are the weapons the serial killer can use
}

--Rewards
--Killer Rewards
SK.Config.KStart = 0								  --This is the start amount (Keep this default if you want the killer's reward to start at 0)
SK.Config.KReward = 5000							--This is the amount of money that the killer gets after he kills someone
--Government Rewards
SK.Config.GStart = 30000							--This is the reward that the police will get after killing the SK (Only if he killed someone first)
SK.Config.GPenalty = 5000							--This is the amount of money that police will lose every time a killer kills someone
SK.Config.GMin = 5000								  --The minimum amount of money (After the Penalty reached this the money won't drop). Change to 0 if you want to minimum
SK.Config.BodyReward = 1000           --The amount of money a police officer gets for finding a body.

--Government Ranks
SK.Config.Government = { "Chief", "Civil Protection" }
