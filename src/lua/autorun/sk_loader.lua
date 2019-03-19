--[[---------------------------------------------------------
	Addon:  Serial Killer
  Author: LiamD. Aka Flop
-----------------------------------------------------------]]

SK.Version = "V 1.0.0"


MsgC( Color( 255, 155, 0 ), "---------------------------------------\n" );
MsgC( Color( 255, 155, 0 ), "Starting up Serial Killer Addon version " .. SK.Version .. "\n\n" );

if (SERVER) then
  include( "sk_config.lua" );
  include( "server/sk_util.lua" );
  include( "sk_jobcreation.lua" );
  AddCSLuaFile( "sk_config.lua" );
  AddCSLuaFile( "client/sk_util.lua");
end

if (CLIENT) then
  include( "sk_config.lua" );
  include( "client/sk_util.lua" );
end
MsgC( Color( 255, 155, 0 ), "Finished loading Serial Killer Addon. \n\n" );
MsgC( Color( 255, 155, 0 ), "---------------------------------------\n" );
