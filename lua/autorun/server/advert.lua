util.AddNetworkString('SendAdvert')
util.AddNetworkString('SendAnonymousAdvert')
util.AddNetworkString('SendPoliceAdvert')
util.AddNetworkString('SendTweet')


hook.Add( "PlayerSay", "PlayerSayExample", function( ply, text, team )
	if ( string.sub( string.lower( text ), 1, 7 ) == "/"..CUSTOMADVERT.Config.chatCommand ) then
        AdvertSend(string.sub(text, 8), ply:Team(), ply)
        return ""
    elseif ( string.sub(string.lower(text), 1, 6) == "/tweet" and CUSTOMADVERT.Config.TwitterEnabled) then
        TweetSend(string.sub(text, 7), ply)
        return ""
    end
end)

function AdvertSend(msg, tm, plyr)
    players = player.GetAll()
    if (table.HasValue(CUSTOMADVERT.Config.IdentifiedTeams, team.GetName( tm )) and CUSTOMADVERT.Config.AnonymousMode ) then    --Right here <---
        for count=1, table.getn(players) do
            ply = players[count]
            if (table.HasValue(CUSTOMADVERT.Config.AdminRoles,ply) ~= false) then
                net.Start('SendPoliceAdvert')
                    net.WriteString(msg)
                net.Send(ply)
            else
                net.Start('SendAdvert')
                    net.WriteString(msg)
					net.WriteEntity(plyr)
                net.Send(ply)
            end
        end
    elseif (CUSTOMADVERT.Config.AnonymousMode) then
        ply = players[count]
        for count=1, table.getn(players) do
            ply = players[count]
            if (table.HasValue(CUSTOMADVERT.Config.AdminRoles,ply) ~= false) then
                net.Start('SendAnonymousAdvert')
                    net.WriteString(msg)
                net.Send(ply)
            else
                net.Start('SendAdvert')
                    net.WriteString(msg)
					net.WriteEntity(plyr)
                net.Send(ply)
            end
        end
    else
        net.Start('SendAdvert')
            net.WriteString(msg)
        net.Broadcast()
    end
end

function TweetSend(msg, ply)
    net.Start('SendTweet')
        net.WriteString(msg)
        net.WriteEntity(ply)
    net.Broadcast()
end
