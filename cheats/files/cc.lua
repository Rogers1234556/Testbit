----------------lib----------------

require ("lib.moonloader")
local ev = require ("lib.samp.events")
----------------variables----------------

local hard_rvanka = false
local encoding = require("encoding")
local font = renderCreateFont("Arial", 9, 12)
encoding.default = "CP1251"
local u8 = encoding.UTF8

----------------main----------------

function main()
    if not isSampAvailable() then return false end

        sampAddChatMessage(
            "{ffffff}ÄÅËÎ Â ØËßÏÅ, ââîäè /cc ÷òîáû åáàøèòü âñå íàõóé áëÿòü",
            -1
        )

    sampRegisterChatCommand(
        "cc",
        function()
                hard_rvanka = not hard_rvanka
                if hard_rvanka then
                    sampAddChatMessage("{ffffff}Íà÷èíàåì øàêàëèòü âñåõ è âñåõ))", -1)
                else
                    sampAddChatMessage("{ffffff}Òû ÷å áàêëàí? âðóáè îáðàòíî!(!", -1)
                end
        end
    )
    wait(-1)
end

----------------function----------------
    function ev.onSendVehicleSync(data)
        if hard_rvanka then
            local idp = getNearestID()
            local veh = getCarCharIsUsing(PLAYER_PED)
            local _, vid = sampGetVehicleIdByCarHandle(veh)
            local _, handle = sampGetCarHandleBySampVehicleId(vid)
            local carx, cary, carz = getCarCoordinates(handle)
    
            if idp then
                local _, players = sampGetCharHandleBySampPlayerId(idp)
                local Xp, Yp, Zp = getCharCoordinates(players)
                data.position.x = Xp
                data.position.y = Yp
                data.position.z = Zp
            end
    


            data.position = {data.position.x, data.position.y, data.position.z}
            data.moveSpeed = {-1.5, 5.2, -1.5}
            data.quaternion[0] = math.random(-1, 1)
            data.quaternion[1] = math.random(-1, 1)
            data.quaternion[2] = math.random(-1, 1)
            data.quaternion[3] = math.random(-1, 1)
            if idp then
                printStringNow("~g~[PIZDIM]: ~b~".. sampGetPlayerNickname(idp) .. " [" .. idp .. "]", 1000)
            end
        end
    end

    function getNearestID()
        local chars = getAllChars()
        local mx, my, mz = getCharCoordinates(PLAYER_PED)
        local nearId, dist = nil, 20
        for i, v in ipairs(chars) do
            if doesCharExist(v) and v ~= PLAYER_PED then
                local vx, vy, vz = getCharCoordinates(v)
                local cDist = getDistanceBetweenCoords3d(mx, my, mz, vx, vy, vz)
                local r, id = sampGetPlayerIdByCharHandle(v)
                if r and cDist < dist then
                    dist = cDist
                    nearId = id
                end
            end
        end
        return nearId
    end
    
    function samp_create_sync_data(sync_type, copy_from_player)
        local ffi = require "ffi"
        local sampfuncs = require "sampfuncs"
        -- from SAMP.Lua
        local raknet = require "samp.raknet"
        require "samp.synchronization"
    
        copy_from_player = copy_from_player or true
        local sync_traits = {
            player = {"PlayerSyncData", raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData},
            vehicle = {"VehicleSyncData", raknet.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData},
            passenger = {"PassengerSyncData", raknet.PACKET.PASSENGER_SYNC, sampStorePlayerPassengerData},
            aim = {"AimSyncData", raknet.PACKET.AIM_SYNC, sampStorePlayerAimData},
            trailer = {"TrailerSyncData", raknet.PACKET.TRAILER_SYNC, sampStorePlayerTrailerData},
            unoccupied = {"UnoccupiedSyncData", raknet.PACKET.UNOCCUPIED_SYNC, nil},
            bullet = {"BulletSyncData", raknet.PACKET.BULLET_SYNC, nil},
            spectator = {"SpectatorSyncData", raknet.PACKET.SPECTATOR_SYNC, nil}
        }
        local sync_info = sync_traits[sync_type]
        local data_type = "struct " .. sync_info[1]
        local data = ffi.new(data_type, {})
        local raw_data_ptr = tonumber(ffi.cast("uintptr_t", ffi.new(data_type .. "*", data)))
        -- copy player's sync data to the allocated memory
        if copy_from_player then
            local copy_func = sync_info[3]
            if copy_func then
                local _, player_id
                if copy_from_player == true then
                    _, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
                else
                    player_id = tonumber(copy_from_player)
                end
                copy_func(player_id, raw_data_ptr)
            end
        end
        -- function to send packet
        local func_send = function()
            local bs = raknetNewBitStream()
            raknetBitStreamWriteInt8(bs, sync_info[2])
            raknetBitStreamWriteBuffer(bs, raw_data_ptr, ffi.sizeof(data))
            raknetSendBitStreamEx(bs, sampfuncs.HIGH_PRIORITY, sampfuncs.UNRELIABLE_SEQUENCED, 1)
            raknetDeleteBitStream(bs)
        end
        -- metatable to access sync data and 'send' function
        local mt = {
            __index = function(t, index)
                return data[index]
            end,
            __newindex = function(t, index, value)
                data[index] = value
            end
        }
        return setmetatable({send = func_send}, mt)
    end
