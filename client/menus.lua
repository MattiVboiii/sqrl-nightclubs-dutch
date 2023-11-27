QBCore = exports['qb-core']:GetCoreObject()

local function checkDisabled(Employee, type, job, fire)
    if fire then
        if tonumber(Employee[type]) == 0 then
            return true
        else
            return false
        end
    else
        if tonumber(Employee[type]) < #job then
            return false
        else
            return true
        end
    end
end

local function checkdata(ClubData, dataType, category, name)
    if ClubData.Metadata[dataType] == nil then
        return false
    end
    if ClubData.Metadata[dataType] == Config.Price['Upgrades'][category][name].name then
        return true
    else
        return false
    end
end

local function buyObject(ClubData, dataType, category, name)
    TriggerServerEvent('nightclubs:server:buyObj', ClubData, dataType, category, name)
end

RegisterNetEvent('nightclubs:client:enteranceMenu', function(args)
    lib.registerContext({
        id = 'enterance_menu',
        title = 'Enterance Menu',
        options = {
            {
                title = 'Een club kopen, betreden of bezoeken',
            },
            {
                title = 'Koop',
                description = 'Een nachtclub kopen',
                icon = 'coins',
                disabled = args.owned,
                onSelect = function()
                    TriggerServerEvent('nightclubs:server:buy')
                end,
            },
            {
                title = 'Ga naar de nachtclub',
                description = 'Ga uw nachtclub binnen',
                icon = 'arrow-right',
                disabled = not args.owned,
                onSelect = function()
                    TriggerServerEvent('nightclubs:server:create')
                end,

            },
            {
                title = 'Bezoek',
                description = 'Bezoek de club van iemand',
                icon = 'handshake',
                disavbled = false,
                onSelect = function()
                    TriggerEvent('nightclubs:client:visitClub')
                end,
            },
        }
    })

    lib.showContext('enterance_menu')
end)

RegisterNetEvent('nightclubs:client:leavemenu', function()
    lib.registerContext({
        id = 'leave_menu',
        title = 'Menu verlaten',
        options = {
            {
                title = 'Verlaat de club',
            },
            {
                title = 'Verlaat',
                description = 'Ga weg en ga terug naar buiten',
                icon = 'person-walking-arrow-right',
                onSelect = function()
                    TriggerEvent('nightclubs:client:removeipl')
                    TriggerServerEvent('nightclubs:server:returnEnterance')
                end,
            },
        }
    })

    lib.showContext('leave_menu')
end)

RegisterNetEvent('nightclubs:client:bossMenu', function(ClubData, Employee)
    lib.registerContext({
        id = 'boss_menu',
        title = 'Boss Menu',
        options = {
            {
                title = 'Club bewerken of upgraden',
            },
            {
                title = 'Upgrades kopen',
                description = 'Koop upgrades voor de club',
                icon = 'coins',
                menu = 'buy_upgrades_menu'
            },
            {
                title = 'Reputatie krijgen of missies doen',
                description = 'Koop upgrades voor de club of win reputatie',
                icon = 'money-check-dollar',
                menu = 'reputation_menu'
            },
            {
                title = 'Werknemers',
                description = 'Werknemers aannemen of ontslaan',
                icon = 'person-circle-check',
                menu = 'employee_menu'
            },
        }
    })

    lib.showContext('boss_menu')

    lib.registerContext({
        id = 'buy_upgrades_menu',
        title = 'Upgrades kopen',
        options = {
            {
                title = 'Club bewerken of upgraden',
            },
            {
                title = 'Naam wijzigen',
                description = 'Koop upgrades voor de club',
                icon = 'signature',
                menu = 'buy_name_upgrades',
            },
            {
                title = 'Stijl veranderen',
                description = 'Koop upgrades voor de club',
                icon = 'paint-roller',
                menu = 'buy_style_upgrades'
            },
            {
                title = 'Podium veranderen',
                description = 'Koop upgrades voor de club',
                icon = 'chair',
                menu = 'buy_podium_upgrades'
            },
            {
                title = 'Luidsprekers wijzigen',
                description = 'Koop upgrades voor de club',
                icon = 'headphones',
                menu = 'buy_speakers_upgrades'
            },
            {
                title = 'Verander de beveiliging',
                description = 'Koop upgrades voor de club',
                icon = 'lock',
                menu = 'buy_security_upgrades'
            },
            {
                title = 'Verander van draaitafel',
                description = 'Koop upgrades voor de club',
                icon = 'music',
                menu = 'buy_turntables_upgrade'
            },
            {
                title = 'Verander druppels',
                description = 'Koop upgrades voor de club',
                icon = 'lightbulb',
                menu = 'buy_droplets_upgrades'
            },
            {
                title = 'Neon veranderen',
                description = 'Koop upgrades voor de club',
                icon = 'lightbulb',
                menu = 'buy_neons_upgrade'
            },
            {
                title = 'Banden wisselen',
                description = 'Koop upgrades voor de club',
                icon = 'lightbulb',
                menu = 'buy_bands_upgrades'
            },
            {
                title = 'Lasers wisselen',
                description = 'Koop upgrades voor de club',
                icon = 'lightbulb',
                menu = 'buy_lasers_upgrades'
            },
            {
                title = 'Verander drank',
                description = 'Koop upgrades voor de club',
                icon = 'beer-mug-empty',
                menu = 'buy_booze_upgrades'
            },
        }
    })

    lib.registerContext({
        id = 'buy_name_upgrades',
        title = 'Upgrades kopen',
        options = {
            {
                title = 'Bewerk de naam',
            },
            {
                title = Config.Price['Upgrades']['Name']['Galaxy'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Name']['Galaxy'].price),
                disabled = checkdata(ClubData, 'name', 'Name', 'Galaxy'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'name', 'Name', 'Galaxy')
                end,
            },
            {
                title = Config.Price['Upgrades']['Name']['Studio'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Name']['Studio'].price),
                disabled = checkdata(ClubData, 'name', 'Name', 'Studio'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'name', 'Name', 'Studio')
                end,
            },
            {
                title = Config.Price['Upgrades']['Name']['Omega'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Name']['Omega'].price),
                disabled = checkdata(ClubData, 'name', 'Name', 'Omega'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'name', 'Name', 'Omega')
                end,
            },
            {
                title = Config.Price['Upgrades']['Name']['Technologie'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Name']['Technologie'].price),
                disabled = checkdata(ClubData, 'name', 'Name', 'Technologie'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'name', 'Name', 'Technologie')
                end,
            },
            {
                title = Config.Price['Upgrades']['Name']['Gefangnis'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Name']['Gefangnis'].price),
                disabled = checkdata(ClubData, 'name', 'Name', 'Gefangnis'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'name', 'Name', 'Gefangnis')
                end,
            },
            {
                title = Config.Price['Upgrades']['Name']['Misonette'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Name']['Misonette'].price),
                disabled = checkdata(ClubData, 'name', 'Name', 'Misonette'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'name', 'Name', 'Misonette')
                end,
            },
            {
                title = Config.Price['Upgrades']['Name']['Tony'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Name']['Tony'].price),
                disabled = checkdata(ClubData, 'name', 'Name', 'Tony'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'name', 'Name', 'Tony')
                end,
            },
            {
                title = Config.Price['Upgrades']['Name']['Place'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Name']['Place'].price),
                disabled = checkdata(ClubData, 'name', 'Name', 'Place'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'name', 'Name', 'Place')
                end,
            },
            {
                title = Config.Price['Upgrades']['Name']['Paradise'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Name']['Paradise'].price),
                disabled = checkdata(ClubData, 'name', 'Name', 'Paradise'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'name', 'Name', 'Paradise')
                end,
            },
        }
    })

    lib.registerContext({
        id = 'buy_style_upgrades',
        title = 'Upgrades kopen',
        options = {
            {
                title = 'De stijl bewerken',
            },
            {
                title = Config.Price['Upgrades']['Style']['Traditional'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Style']['Traditional'].price),
                disabled = checkdata(ClubData, 'style', 'Style', 'Traditional'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'style', 'Style', 'Traditional')
                end,
            },
            {
                title = Config.Price['Upgrades']['Style']['Edgy'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Style']['Edgy'].price),
                disabled = checkdata(ClubData, 'style', 'Style', 'Edgy'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'style', 'Style', 'Edgy')
                end,
            },
            {
                title = Config.Price['Upgrades']['Style']['Glamerous'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Style']['Glamerous'].price),
                disabled = checkdata(ClubData, 'style', 'Style', 'Glamerous'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'style', 'Style', 'Glamerous')
                end,
            },
        }
    })

    lib.registerContext({
        id = 'buy_podium_upgrades',
        title = 'Upgrades kopen',
        options = {
            {
                title = 'Het podium bewerken',
            },
            {
                title = Config.Price['Upgrades']['Podium']['Traditional'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Podium']['Traditional'].price),
                disabled = checkdata(ClubData, 'podium', 'Podium', 'Traditional'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'podium', 'Podium', 'Traditional')
                end,
            },
            {
                title = Config.Price['Upgrades']['Podium']['Edgy'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Podium']['Edgy'].price),
                disabled = checkdata(ClubData, 'podium', 'Podium', 'Edgy'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'podium', 'Podium', 'Edgy')
                end,
            },
            {
                title = Config.Price['Upgrades']['Podium']['Glamerous'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Podium']['Glamerous'].price),
                disabled = checkdata(ClubData, 'podium', 'Podium', 'Glamerous'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'podium', 'Podium', 'Glamerous')
                end,
            },
        }
    })

    lib.registerContext({
        id = 'buy_speakers_upgrades',
        title = 'Upgrades kopen',
        options = {
            {
                title = 'De luidsprekers bewerken',
            },
            {
                title = Config.Price['Upgrades']['Speakers']['Basic'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Speakers']['Basic'].price),
                disabled = checkdata(ClubData, 'speakers', 'Speakers', 'Basic'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'speakers', 'Speakers', 'Basic')
                end,
            },
            {
                title = Config.Price['Upgrades']['Speakers']['Ultimate'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Speakers']['Ultimate'].price),
                disabled = checkdata(ClubData, 'speakers', 'Speakers', 'Ultimate'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'speakers', 'Speakers', 'Ultimate')
                end,
            },
        }
    })

    lib.registerContext({
        id = 'buy_security_upgrades',
        title = 'Upgrades kopen',
        options = {
            {
                title = 'Bewerk de beveiliging',
            },
            {
                title = Config.Price['Upgrades']['Security']['Basic'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Security']['Basic'].price),
                disabled = checkdata(ClubData, 'security', 'Security', 'Basic'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'security', 'Security', 'Basic')
                end,
            },
        }
    })

    lib.registerContext({
        id = 'buy_turntables_upgrade',
        title = "Upgrades kopen",
        options = {
            {
                title = 'De draaitafels bewerken',
            },
            {
                title = Config.Price['Upgrades']['Turntables']['Basic'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Turntables']['Basic'].price),
                disabled = checkdata(ClubData, 'turntables', 'Turntables', 'Basic'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'turntables', 'Turntables', 'Basic')
                end,
            },
            {
                title = Config.Price['Upgrades']['Turntables']['Upgraded'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Turntables']['Upgraded'].price),
                disabled = checkdata(ClubData, 'turntables', 'Turntables', 'Upgraded'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'turntables', 'Turntables', 'Upgraded')
                end,
            },
            {
                title = Config.Price['Upgrades']['Turntables']['Mega'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Turntables']['Mega'].price),
                disabled = checkdata(ClubData, 'turntables', 'Turntables', 'Mega'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'turntables', 'Turntables', 'Mega')
                end,
            },
            {
                title = Config.Price['Upgrades']['Turntables']['Ultimate'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Turntables']['Ultimate'].price),
                disabled = checkdata(ClubData, 'turntables', 'Turntables', 'Ultimate'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'turntables', 'Turntables', 'Ultimate')
                end,
            },
        }
    })

    lib.registerContext({
        id = 'buy_droplets_upgrades',
        title = "Upgrades kopen",
        options = {
            {
                title = 'De druppellichten bewerken',
            },
            {
                title = Config.Price['Upgrades']['Droplets']['Yellow'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Droplets']['Yellow'].price),
                disabled = checkdata(ClubData, 'droplets', 'Droplets', 'Yellow'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'droplets', 'Droplets', 'Yellow')
                end,
            },
            {
                title = Config.Price['Upgrades']['Droplets']['White'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Droplets']['White'].price),
                disabled = checkdata(ClubData, 'droplets', 'Droplets', 'White'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'droplets', 'Droplets', 'White')
                end,
            },
            {
                title = Config.Price['Upgrades']['Droplets']['Purple'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Droplets']['Purple'].price),
                disabled = checkdata(ClubData, 'droplets', 'Droplets', 'Purple'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'droplets', 'Droplets', 'Purple')
                end,
            },
            {
                title = Config.Price['Upgrades']['Droplets']['Cayn'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Droplets']['Cayn'].price),
                disabled = checkdata(ClubData, 'droplets', 'Droplets', 'Cayn'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'droplets', 'Droplets', 'Cayn')
                end,
            },
        }
    })

    lib.registerContext({
        id = 'buy_neons_upgrade',
        title = "Upgrades kopen",
        options = {
            {
                title = 'De neonlichten bewerken',
            },
            {
                title = Config.Price['Upgrades']['Neons']['Yellow'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Neons']['Yellow'].price),
                disabled = checkdata(ClubData, 'neons', 'Neons', 'Yellow'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'neons', 'Neons', 'Yellow')
                end,
            },
            {
                title = Config.Price['Upgrades']['Neons']['White'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Neons']['White'].price),
                disabled = checkdata(ClubData, 'neons', 'Neons', 'White'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'neons', 'Neons', 'White')
                end,
            },
            {
                title = Config.Price['Upgrades']['Neons']['Purple'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Neons']['Purple'].price),
                disabled = checkdata(ClubData, 'neons', 'Neons', 'Purple'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'neons', 'Neons', 'Purple')
                end,
            },
            {
                title = Config.Price['Upgrades']['Neons']['Cayn'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Neons']['Cayn'].price),
                disabled = checkdata(ClubData, 'neons', 'Neons', 'Cayn'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'neons', 'Neons', 'Cayn')
                end,
            },
        }
    })

    lib.registerContext({
        id = 'buy_bands_upgrades',
        title = "Upgrades kopen",
        options = {
            {
                title = 'De bandlampjes bewerken',
            },
            {
                title = Config.Price['Upgrades']['Bands']['Yellow'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Bands']['Yellow'].price),
                disabled = checkdata(ClubData, 'bands', 'Bands', 'Yellow'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'bands', 'Bands', 'Yellow')
                end,
            },
            {
                title = Config.Price['Upgrades']['Bands']['Green'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Bands']['Green'].price),
                disabled = checkdata(ClubData, 'bands', 'Bands', 'Green'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'bands', 'Bands', 'Green')
                end,
            },
            {
                title = Config.Price['Upgrades']['Bands']['White'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Bands']['White'].price),
                disabled = checkdata(ClubData, 'bands', 'Bands', 'White'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'bands', 'Bands', 'White')
                end,
            },
            {
                title = Config.Price['Upgrades']['Bands']['Cayn'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Bands']['Cayn'].price),
                disabled = checkdata(ClubData, 'bands', 'Bands', 'Cayn'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'bands', 'Bands', 'Cayn')
                end,
            },
        }
    })

    lib.registerContext({
        id = 'buy_lasers_upgrades',
        title = "Upgrades kopen",
        options = {
            {
                title = 'De laserlichten bewerken',
            },
            {
                title = Config.Price['Upgrades']['Lasers']['Yellow'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Lasers']['Yellow'].price),
                disabled = checkdata(ClubData, 'lasers', 'Lasers', 'Yellow'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'lasers', 'Lasers', 'Yellow')
                end,
            },
            {
                title = Config.Price['Upgrades']['Lasers']['Green'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Lasers']['Green'].price),
                disabled = checkdata(ClubData, 'lasers', 'Lasers', 'Green'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'lasers', 'Lasers', 'Green')
                end,
            },
            {
                title = Config.Price['Upgrades']['Lasers']['White'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Lasers']['White'].price),
                disabled = checkdata(ClubData, 'lasers', 'Lasers', 'White'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'lasers', 'Lasers', 'White')
                end,
            },
            {
                title = Config.Price['Upgrades']['Lasers']['Purple'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Lasers']['Purple'].price),
                disabled = checkdata(ClubData, 'lasers', 'Lasers', 'Purple'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'lasers', 'Lasers', 'Purple')
                end,
            },
        }
    })

    lib.registerContext({
        id = 'buy_booze_upgrades',
        title = "Upgrades kopen",
        options = {
            {
                title = 'De drank bewerken',
            },
            {
                title = Config.Price['Upgrades']['Booze']['1'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Booze']['1'].price),
                disabled = checkdata(ClubData, 'booze', 'Booze', '1'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'booze', 'Booze', '1')
                end,
            },
            {
                title = Config.Price['Upgrades']['Booze']['2'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Booze']['2'].price),
                disabled = checkdata(ClubData, 'booze', 'Booze', '2'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'booze', 'Booze', '2')
                end,
            },
            {
                title = Config.Price['Upgrades']['Booze']['3'].description,
                description = 'De prijs is ' .. tostring(Config.Price['Upgrades']['Booze']['3'].price),
                disabled = checkdata(ClubData, 'booze', 'Booze', '3'),
                icon = 'coins',
                onSelect = function()
                    buyObject(ClubData, 'booze', 'Booze', '3')
                end,
            },
        }
    })

    -- Reputation
    lib.registerContext({
        id = 'reputation_menu',
        title = 'Reputatie krijgen',
        options = {
            {
                title = 'Populariteit binnen de club vergroten',
            },
            {
                title = 'Posters ophangen',
                description = 'Plak posters rond de stad om aandacht te trekken',
                icon = 'clipboard-user',
                onSelect = function()
                    TriggerServerEvent('nightclubs:server:posterGetMissionData')
                end,
            },
            {
                title = 'Uitrusting stelen',
                description = 'Steel lampen, luidsprekers en draaitafels uit de stad',
                icon = 'radio',
                onSelect = function()
                    TriggerServerEvent('nightclubs:server:equiptmentGetMissionData')
                end,
            },
            {
                title = 'Voedsel verzamelen',
                description = 'Voedsel verzamelen voor klanten om te kopen, beïnvloedt de populariteit',
                icon = 'utensils',
                onSelect = function()
                    TriggerServerEvent('nightclubs:server:foodGetData')
                end,
            },
        }
    })

    -- Employee
    lib.registerContext({
        id = 'employee_menu',
        title = 'Medewerkers inhuren voor je club',
        options = {
            {
                title = 'Werknemers aannemen of ontslaan',
            },
            {
                title = 'DJ',
                description = 'Huur een dj in om muziek te draaien, hiervoor heb je speakers en een draaitafel nodig',
                icon = 'music',
                menu = 'emoloyee_dj_menu',
                metadata = {
                    { label = 'Betaling', value = Config.Employee.dj.price },
                },
            },
            {
                title = 'Dansers',
                description = 'Huur dansers in om populariteit te vergroten',
                menu = 'emoloyee_dancer_menu',
                icon = 'person-dress',
                metadata = {
                    { label = 'Betaling', value = Config.Employee.dancers.price },
                },
            },
            {
                title = 'Barmedewerkers',
                description = 'Huur barkeepers in en ontgrendel de mogelijkheid om eten en drinken te verkopen',
                icon = 'martini-glass-empty',
                menu = 'emoloyee_tender_menu',
                metadata = {
                    { label = 'Betaling', value = Config.Employee.tenders.price },
                },
            },
        }
    })

    lib.registerContext({
        id = 'emoloyee_dj_menu',
        title = 'De DJ inhuren',
        options = {
            {
                title = 'Klik om aan te nemen of te ontslaan ' .. Employee['dj'] .. '/' .. #Config.Employee.dj.locations,
            },
            {
                title = 'Huur',
                description = 'Huur een DJ in om muziek te draaien, hiervoor heb je speakers en een draaitafel nodig',
                icon = 'check',
                onSelect = function()
                    if ClubData.Metadata['speakers'] ~= tostring(nil) and ClubData.Metadata['turntables'] ~= tostring(nil) then
                        TriggerServerEvent('nightclubs:server:employeesFunction', 'dj', true)
                        QBCore.Functions.Notify('Succesvol DJ ingehuurd', "success")
                    else
                        QBCore.Functions.Notify('Kon niet huren, ontbrekende draaitafels of luidsprekers', "error")
                    end
                    
                end,
                disabled = checkDisabled(Employee, 'dj', Config.Employee.dj.locations, false)
            },
            {
                title = 'Ontslaan',
                description = 'Ontsla de DJ',
                icon = 'circle-xmark',
                onSelect = function()
                    TriggerServerEvent('nightclubs:server:employeesFunction', 'dj', false)
                    QBCore.Functions.Notify('DJ succesvol ontslagen', "success")
                end,
                disabled = checkDisabled(Employee, 'dj', Config.Employee.dj.locations, true)
            },
        }
    })

    lib.registerContext({
        id = 'emoloyee_dancer_menu',
        title = 'De dansers inhuren',
        options = {
            {
                title = 'Klik om aan te nemen of te ontslaan '  .. Employee['dancers'] .. '/' .. #Config.Employee.dancers.locations,
            },
            {
                title = 'Huur',
                description = 'Huur de dansers in, heb podia nodig',
                icon = 'check',
                onSelect = function()
                    if ClubData.Metadata['podium'] ~= tostring(nil) then
                        TriggerServerEvent('nightclubs:server:employeesFunction', 'dancers', true)
                        QBCore.Functions.Notify('Succesvol een danser ingehuurd', "success")
                    else
                        QBCore.Functions.Notify('Kon niet huren, ontbrekende podia', "error")
                    end
                    
                end,
                disabled = checkDisabled(Employee, 'dancers', Config.Employee.dancers.locations, false)
            },
            {
                title = 'Ontslaan',
                description = 'Een danser ontslaan',
                icon = 'circle-xmark',
                onSelect = function()
                    TriggerServerEvent('nightclubs:server:employeesFunction', 'dancers', false)
                    QBCore.Functions.Notify('Danser succesvol ontslagen', "success")
                end,
                disabled = checkDisabled(Employee, 'dancers', Config.Employee.dancers.locations, true)
            },
        }
    })

    lib.registerContext({
        id = 'emoloyee_tender_menu',
        title = 'Huur de barbedienden in',
        options = {
            {
                title = 'Klik om aan te nemen of te ontslaan '  .. Employee['tenders'] .. '/' .. #Config.Employee.tenders.locations,
            },
            {
                title = 'Hire',
                description = 'Barbedienden inhuren',
                icon = 'check',
                onSelect = function()
                        TriggerServerEvent('nightclubs:server:employeesFunction', 'tenders', true)
                        QBCore.Functions.Notify('Succesvol een barkeeper aangenomen', "success")         
                end,
                disabled = checkDisabled(Employee, 'tenders', Config.Employee.tenders.locations, false)
            },
            {
                title = 'Ontslaan',
                description = 'Een barkeeper ontslaan',
                icon = 'circle-xmark',
                onSelect = function()
                    TriggerServerEvent('nightclubs:server:employeesFunction', 'tenders', false)
                    QBCore.Functions.Notify('Barkeeper succesvol ontslagen', "success")
                end,
                disabled = checkDisabled(Employee, 'tenders', Config.Employee.tenders.locations, true)
            },
        }
    })
end)