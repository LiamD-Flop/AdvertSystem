Version = "V 1.0.0"

MsgC( Color( 255, 155, 0 ), "---------------------------------------\n" );
MsgC( Color( 255, 155, 0 ), "Starting up Custom Advert version " .. Version .. "\n\n" );

if (SERVER) then
  include( "advert_conf.lua" );
  include( "server/advert.lua");
  AddCSLuaFile( "advert_conf.lua" );
  AddCSLuaFile( "client/advert.lua" );
end

if (CLIENT) then
  include( "advert_conf.lua" );
  include( "client/advert.lua");
end
MsgC( Color( 255, 155, 0 ), "Finished loading Custom Advert. \n\n" );
MsgC( Color( 255, 155, 0 ), "---------------------------------------\n" );
