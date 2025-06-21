local events = require "samp.events"
local state = false
local Dama = {}
local dmgCount = {}
local Del = 599

function main()
    while not isSampAvailable() do wait(0) end
    sampRegisterChatCommand('dmg', function(args)
        if state then
            state = false
            Dama = {}
            dmgCount = {}
            sampAddChatMessage("Dmg Off", -1)
        else
            Dama = {}
            for id in string.gmatch(args, "%d+") do
                id = tonumber(id)
                if id and id >= 0 and id <= 1000 then
                    table.insert(Dama, id)
                    dmgCount[id] = 0
                end
            end
            if #Dama > 0 then
                state = true
                local targets = table.concat(Dama, ", ")
                sampAddChatMessage("Dmg ID: " .. targets, -1)
            else
                sampAddChatMessage("Invalid ID", -1)
            end
        end
    end)
    sampRegisterChatCommand('dmgd', function(newDel)
        local oldDel = Del
        newDel = tonumber(newDel)
        if newDel and newDel > -1 then
            Del = newDel
            sampAddChatMessage(string.format("Delay changed old = %d, new = %d", oldDel, Del), -1)
        else
            sampAddChatMessage("Invalid delay.", -1)
        end
    end)
    while true do
        wait(0)
        if state and #Dama > 0 then
            for _, id in ipairs(Dama) do
                dmgCount[id] = (dmgCount[id] or 0) + 1
                sampForceOnfootSync()
                sampSendTakeDamage(id, 0, 38, 3)
                sampSendDeathByPlayer(65535, 49)
                sampSendSpawn()
                printStringNow(string.format("ID %d - Death Count %d", id, dmgCount[id]), 500)
                wait(Del)
            end
        end
    end
end
function onReceiveRpc(id)
    if state and (id == 12 or id == 156) then
        return false
    end
end
function events.onServerMessage(color, text)
    if text:match('^Вы заняли койку №%d+%. В зависимости от состояния здоровья лечение может занять время$') then
        return false
    end

    if text:find('^Чтобы выписаться подойдите к врачу или выйдите за пределы больницы$') then
        return false
    end
end