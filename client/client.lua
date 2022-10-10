RegisterNetEvent('esx_vehicles:parts', function(data)
   
    if data.type == 'doors' then
        local v = GetVehicleDoorAngleRatio(cache.vehicle, data.id)
        if v > 0 then SetVehicleDoorShut(cache.vehicle, data.id, false) else SetVehicleDoorOpen(cache.vehicle, data.id, false) end
    elseif data.type == 'engine' then
        local status = GetIsVehicleEngineRunning(cache.vehicle)
        status = not status
        SetVehicleEngineOn(cache.vehicle, not status, false, not status)
        SetVehicleUndriveable(cache.vehicle, not status)
    elseif data.type == 'windows' then
        local v = IsVehicleWindowIntact(cache.vehicle, data.id)
        if v then
            RollDownWindow(cache.vehicle, data.id)
        else
            RollUpWindow(cache.vehicle, data.id)
        end
    elseif data.type == 'place' then
        SetPedIntoVehicle(cache.ped, cache.vehicle, data.id)
    end

    lib.showContext(data.menu)
end)

RegisterNetEvent('esx_vehicles:limit', function(data)
    local input = lib.inputDialog(_U('speed_limit'), {_U('limit')})
    if input then
        local lockerNumber = tonumber(input[1]*1000/3600)
        SetVehicleMaxSpeed(cache.vehicle, lockerNumber)
    end
end)

RegisterNetEvent('esx_vehicles:resetlimit', function(data)
    SetVehicleMaxSpeed(cache.vehicle, 0.0)
end)

lib.registerContext({
    id = 'menu',
    title = _U('menu_title'),
    onExit = function()
    end,
    options = {
        {
            title = _U('engine'),
            arrow = true,
            event = 'esx_vehicles:parts',
            args = {value1 = 'engine', type = 'engine', menu = 'menu'}
        },
        {
            title = _U('open_trunk'),
            arrow = true,
            event = 'esx_vehicles:parts',
            args = {value1 = 'trunk', id = 5, type = 'doors', menu = 'menu'}
        },
        {
            title = _U('open_hood'),
            arrow = true,
            event = 'esx_vehicles:parts',
            args = {value1 = 'hood', id = 4, type = 'doors', menu = 'menu'}
        },
        {
            title = _U('doors'),
            menu = 'doors_menu'
        },
        {
            title = _U('seats'),
            menu = 'place_menu'
        },
        {
            title = _U('windows'),
            menu = 'windows_menu'
        },
        {
            title = _U('activate_limiter'),
            arrow = true,
            event = 'esx_vehicles:limit'
        },
        {
            title = _U('disable_limiter'),
            arrow = true,
            event = 'esx_vehicles:resetlimit'
        }
    },
    {
        id = 'doors_menu',
        title = _U('menu_title'),
        menu = 'menu',
        options = {
            {
                title = _U('open_leftfrontdoor'),
                arrow = true,
                event = 'esx_vehicles:parts',
                args = {value1 = 'leftfront', id = 0, type = 'doors', menu = 'doors_menu'}
            },
            {
                title = _U('open_rightfrontdoor'),
                arrow = true,
                event = 'esx_vehicles:parts',
                args = {value1 = 'rightfront', id = 1, type = 'doors', menu = 'doors_menu'}
            },
            {
                title = _U('open_leftreardoor'),
                arrow = true,
                event = 'esx_vehicles:parts',
                args = {value1 = 'leftrear', id = 2, type = 'doors', menu = 'doors_menu'}
            },
            {
                title = _U('open_rightreardoor'),
                arrow = true,
                event = 'esx_vehicles:parts',
                args = {value1 = 'rightrear', id = 3, type = 'doors', menu = 'doors_menu'}
            },
        }
    },
    {
        id = 'place_menu',
        title = _U('menu_title'),
        menu = 'menu',
        options = {
            {
                title = _U('driver'),
                arrow = true,
                event = 'esx_vehicles:parts',
                args = {value1 = 'leftfront', id = -1, type = 'place', menu = 'place_menu'}
            },
            {
                title = _U('passenger'),
                arrow = true,
                event = 'esx_vehicles:parts',
                args = {value1 = 'rightfront', id = 0, type = 'place', menu = 'place_menu'}
            },
            {
                title = _U('backdriver'),
                arrow = true,
                event = 'esx_vehicles:parts',
                args = {value1 = 'leftrear', id = 1, type = 'place', menu = 'place_menu'}
            },
            {
                title = _U('backpassenger'),
                arrow = true,
                event = 'esx_vehicles:parts',
                args = {value1 = 'rightrear', id = 2, type = 'place', menu = 'place_menu'}
            },
        }
    },
    {
        id = 'windows_menu',
        title = 'Other Context Menu',
        menu = 'menu',
        options = {
            {
                title = _U('open_leftfrontwindow'),
                arrow = true,
                event = 'esx_vehicles:parts',
                args = {value1 = 'leftfrontw', id = 0, type = 'windows', menu = 'windows_menu'}
            },
            {
                title = _U('open_rightfrontwindow'),
                arrow = true,
                event = 'esx_vehicles:parts',
                args = {value1 = 'rightfrontw', id = 1, type = 'windows', menu = 'windows_menu'}
            },
            {
                title = _U('open_leftrearwindow'),
                arrow = true,
                event = 'esx_vehicles:parts',
                args = {value1 = 'leftrearw', id = 2, type = 'windows', menu = 'windows_menu'}
            },
            {
                title = _U('open_rightrearwindow'),
                arrow = true,
                event = 'esx_vehicles:parts',
                args = {value1 = 'rightrearw', id = 3, type = 'windows', menu = 'windows_menu'}
            },
        }
    }
})

RegisterKeyMapping("veh", "esx_vehicles", "keyboard", "F6")

RegisterCommand("veh", function ()
    if cache.vehicle and cache.seat == -1 then
        lib.showContext('menu')
    else
        lib.notify({
			description = _U('not_inside_veh'),
			style = {
				backgroundColor = '#000000',
				color = '#ffffff'
			},
			icon = 'fa-x',
			type = 'error'
		})
    end
end, false)