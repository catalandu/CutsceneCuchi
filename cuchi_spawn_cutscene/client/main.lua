local cam,cam2,cam3,cam4,cam5,cam6,cam7,cam8,cam9 = nil
local isOnEndScreen, started, inProgress = false
local FadeInTitle = 0
local FadeInSubTitle = 0
local mustFadeOut = false

Citizen.CreateThread(function() 
    while true do
        Wait(0)
        if not started then
            if NetworkIsSessionStarted() then
                ShutdownLoadingScreen()
                ShutdownLoadingScreenNui()
                started = true
                inProgress = true
                DoScreenFadeOut(2000)
                while IsScreenFadingOut() do
                    Wait(50)
                end
                DoScreenFadeIn(2000)

                if Config.Music.enabled then
                    PlayMusic(true)
                end

                if Config.Type == "long" then
                    cLong()
                elseif Config.Type == "fast" then
                    cFast()
                elseif Config.Type == "short" then
                    cShort()
                elseif Config.Type == "normal" then
                    cNormal()
                elseif Config.Type == "fromtop" then
                    cFromTop()
                else
                    cNormal()
                end
                isOnEndScreen = true
            end
        end
        break
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if isOnEndScreen then
            Text(Config.Message.msg, 0.5, 0.9, 0.9, Config.Message.font)
            if IsDisabledControlJustPressed(1, 22) then
                if Config.Music.enabled then
                    PlayMusic(false)
                end

                if Config.SpacebarSound.enabled then
                    PlaySoundFrontend(-1,Config.SpacebarSound.data[1],Config.SpacebarSound.data[2])
                end

                if Config.Type == "long" then
                    cLongEnd()
                elseif Config.Type == "fast" then
                    cFastEnd()
                elseif Config.Type == "short" then
                    cShortEnd()
                elseif Config.Type == "normal" then
                    cNormalEnd()
                elseif Config.Type == "fromtop" then
                    cFromTopEnd()
                else
                    cNormalEnd()
                end
                break
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if inProgress then
            DisableAllControlActions(0) -- Disable all controls
            HideHudAndRadarThisFrame() -- Hide map

            if not IsScreenFadingOut() and not mustFadeOut then
                if Config.Title.enabled then
                    if FadeInTitle >= 255 or Config.Title.fadeInAndOut == false  then
                        Text(Config.Title.data, 0.5, 0.1, 1.5, Config.Title.font)
                    else
                        TextFade(Config.Title.data, 0.5, 0.1, 1.5, Config.Title.font, "title", "in")
                    end
                end

                if Config.Subtitle.enabled then
                    if FadeInSubTitle >= 255 or Config.Subtitle.fadeInAndOut == false then
                        Text(Config.Subtitle.data, 0.5, 0.17, 0.6, Config.Subtitle.font)
                    else
                        TextFade(Config.Subtitle.data, 0.5, 0.17, 0.6, Config.Subtitle.font, "subtitle", "in")
                    end
                end
            end

            if Config.SetInvincible then
                SetEntityInvincible(GetPlayerPed(-1), true)
            end

            if Config.DisablePlayerCollision then
                SetEntityCollision(GetPlayerPed(-1), false, true)
                FreezeEntityPosition(GetPlayerPed(-1), true)
            end

            if Config.SetInvisible then
                SetEntityVisible(GetPlayerPed(-1), false, false)
            end

            if Config.Music.canUserPause then
                if IsDisabledControlJustPressed(1, 22) then
                    PlayMusic(false)
                end
            end
        elseif not isOnEndScreen and not inProgress and started then
            if Config.SetInvincible then
                SetEntityInvincible(GetPlayerPed(-1), false)
            end

            if Config.DisablePlayerCollision then
                SetEntityCollision(GetPlayerPed(-1), true, true)
                FreezeEntityPosition(GetPlayerPed(-1), false)
            end

            if Config.SetInvisible then
                SetEntityVisible(GetPlayerPed(-1), true, false)
            end

            EnableAllControlActions(0) -- Enable controls
            ClearDrawOrigin() -- Reset draw origin
            break
        end
    end
end)

function TextFade(txt, x, y, scale, font, type, fadeType)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextProportional(true)
    SetTextCentre(true)
    SetTextOutline()
    if type == "title" then
        SetTextColour(255, 255, 255, FadeInTitle)
    elseif type == "subtitle" then
        SetTextColour(255, 255, 255, FadeInSubTitle)
    end
    SetTextEntry("STRING")
    AddTextComponentString(txt)
    DrawText(x,y)
    if fadeType == "in" then
        if type == "title" then
            FadeInTitle = FadeInTitle + Config.Title.FadeIn
        elseif type == "subtitle" then
            FadeInSubTitle = FadeInSubTitle + Config.Subtitle.FadeIn
        end
    elseif fadeType == "out" then
        if type == "title" then
            FadeInTitle = FadeInTitle - Config.Title.FadeOut
        elseif type == "subtitle" then
            FadeInSubTitle = FadeInSubTitle - Config.Subtitle.FadeOut
        end
    end
end

function Text(txt, x, y, scale, font)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextProportional(true)
    SetTextCentre(true)
    SetTextOutline()
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString(txt)
    DrawText(x,y)
end

function cNormal() 
    cam  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 736.340698242190, 1235.57617187500, 369.35360717773, 0.00, 0.000, -200.0, 45.0, true, 2)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 47.3004035949710, -728.26885986328, 48.759845733643, 15.0, 15.00, -200.0, 45.0, true, 2)
    cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -85.621643066406, -1085.0269775391, 98.253501892090, 10.0, 25.00, -200.0, 45.0, true, 2)
    cam4 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -855.60296630859, -1558.6015625000, 121.15438079834, 0.00, 35.00, -275.0, 45.0, true, 2)
    cam5 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1638.6025390625, -998.18847656250, 28.000000000000, 0.00, -15.0, -275.0, 45.0, true, 2)
    cam6 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1838.6956787109, -1228.4759521484, 15.473817825317, 0.00, 0.000, -250.0, 45.0, true, 2)
    RenderScriptCams(1, 1, 0, 0, 0)
    Wait(0) -- Needed to load map
    SetFocusPosAndVel(GetCamCoord(cam), 0.0, 0.0, 0.0)
    SetCamActiveWithInterp(cam2, cam, 9500, 1, 1)
    SetFocusPosAndVel(GetCamCoord(cam2), 0.0, 0.0, 0.0)
    Wait(5500)
    SetCamActiveWithInterp(cam3, cam2, 9500, 1, 1)
    SetFocusPosAndVel(GetCamCoord(cam3), 0.0, 0.0, 0.0)
    Wait(5500)
    SetCamActiveWithInterp(cam4, cam3, 9500, 1, 1)
    SetFocusPosAndVel(GetCamCoord(cam4), 0.0, 0.0, 0.0)
    Wait(5700)
    SetCamActiveWithInterp(cam5, cam4, 9500, 1, 1)
    SetFocusPosAndVel(GetCamCoord(cam5), 0.0, 0.0, 0.0)
    Wait(5500)
    SetCamActiveWithInterp(cam6, cam5, 9500, 1, 1)
    SetFocusPosAndVel(GetCamCoord(cam6), 0.0, 0.0, 0.0)
    Wait(9000)
end

function cNormalEnd()
    c = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1838.6956787109, -1228.4759521484,4000.0, -90.0, 0.0, -250.0, 45.0, true, 2)
    SetCamActiveWithInterp(c, cam6, 2000, 1, 1)
    FinalEnd()
end

function cFast() 
    cam  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1581.0552978516,5194.1284179688,3.9842195510864, 0.00, 0.0, -335.0, 45.0, true, 2)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1609.7137451172,5256.6650390625,3.9741082191467, 10.0, 0.0, -335.0, 45.0, true, 2)
    RenderScriptCams(1, 1, 0, 0, 0)
    Wait(0) -- Needed to load map
    SetFocusPosAndVel(GetCamCoord(cam), 0.0, 0.0, 0.0)
    SetCamActiveWithInterp(cam2, cam, 5000, 1, 1)
    Wait(0)
    SetFocusPosAndVel(GetCamCoord(cam2), 0.0, 0.0, 0.0)
    Wait(5000)
end

function cFastEnd()
    c = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1609.7137451172,5256.6650390625,4000.0, -90.0, 0.0, -335.0, 45.0, true, 2)
    SetCamActiveWithInterp(c, cam2, 2000, 1, 1)
    FinalEnd()
end

function cShort() 
    cam  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 455.79855346680,5544.1254882812,792.41552734375, 0.00, 0.0, -180.0, 45.0, true, 2)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -9.806697845459,73.888931274414,350.01487731934, -12.0, 0.0, -180.0, 45.0, true, 2)
    RenderScriptCams(1, 1, 0, 0, 0)
    Wait(0) -- Needed to load map
    SetFocusPosAndVel(GetCamCoord(cam), 0.0, 0.0, 0.0)
    SetCamActiveWithInterp(cam2, cam, 10500, 1, 1)
    Wait(0)
    SetFocusPosAndVel(GetCamCoord(cam2), 0.0, 0.0, 0.0)
    Wait(9250)
end

function cShortEnd()
    c = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -9.806697845459,73.888931274414,4000.0, -90.0, 0.0, -180.0, 45.0, true, 2)
    SetCamActiveWithInterp(c, cam2, 2000, 1, 1)
    FinalEnd()
end

function cLong() 
    cam  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -390.77429199219,1250.173461914100,356.907135009770, 0.0, 0.000, -200.0, 45.0, true, 2)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -352.59802246094,1107.518554687500,337.838806152340, 5.0, 15.00, -200.0, 45.0, true, 2)
    cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -964.69714355469,197.4802093505900,119.232826232910, 2.0, -15.0, -150.0, 45.0, true, 2)
    cam4 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -787.62103271484,-76.0218048095700,72.0243225097660, 0.0, 5.000, -150.0, 45.0, true, 2)
    cam5 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -598.77209472656,-404.109039306640,94.5894775390620, 0.0, -10.0, -150.0, 45.0, true, 2)
    cam6 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -138.74597167969,-702.474121093750,106.636779785160, 0.0, -5.00, -140.0, 45.0, true, 2)
    cam7 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 168.452651977540,-842.265625000000,105.218811035160, 0.0, 25.00, -145.0, 45.0, true, 2)
    cam8 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 188.547317504880,-1059.30297851560,92.7524414062500, 0.0, 5.000, -168.0, 45.0, true, 2)
    cam9 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 284.216979980470,-1569.76647949220,33.7645454406740, 4.0, 0.000, -168.0, 45.0, true, 2)
    Wait(0) -- Needed to load map
    RenderScriptCams(1, 1, 0, 0, 0)
    SetFocusPosAndVel(GetCamCoord(cam), 0.0, 0.0, 0.0)
    SetCamActiveWithInterp(cam2, cam, 12000, 1, 1)
    SetFocusPosAndVel(GetCamCoord(cam2), 0.0, 0.0, 0.0)
    Wait(8000)
    SetCamActiveWithInterp(cam3, cam2, 12000, 1, 1)
    SetFocusPosAndVel(GetCamCoord(cam3), 0.0, 0.0, 0.0)
    Wait(6000)
    SetCamActiveWithInterp(cam4, cam3, 12000, 1, 1)
    SetFocusPosAndVel(GetCamCoord(cam4), 0.0, 0.0, 0.0)
    Wait(6200)
    SetCamActiveWithInterp(cam5, cam4, 12000, 1, 1)
    SetFocusPosAndVel(GetCamCoord(cam5), 0.0, 0.0, 0.0)
    Wait(6000)
    SetCamActiveWithInterp(cam6, cam5, 12000, 1, 1)
    SetFocusPosAndVel(GetCamCoord(cam6), 0.0, 0.0, 0.0)
    Wait(6000)
    SetCamActiveWithInterp(cam7, cam6, 12000, 1, 1)
    SetFocusPosAndVel(GetCamCoord(cam7), 0.0, 0.0, 0.0)
    Wait(6200)
    SetCamActiveWithInterp(cam8, cam7, 12000, 1, 1)
    SetFocusPosAndVel(GetCamCoord(cam8), 0.0, 0.0, 0.0)
    Wait(6000)
    SetCamActiveWithInterp(cam9, cam8, 10000, 1, 1)
    SetFocusPosAndVel(GetCamCoord(cam9), 0.0, 0.0, 0.0)
    Wait(9000)
end

function cLongEnd() 
    c = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 284.21697998047,-1569.7664794922,4000.0, -90.0, 0.0, -168.0, 45.0, true, 2)
    SetCamActiveWithInterp(c, cam9, 2000, 1, 1)
    FinalEnd()
end

function cFromTop()
    cam  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 96.358459472656,-611.05651855469,10000.0, -90.0, 0.0, -168.0, 45.0, true, 2)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 96.358459472656,-611.05651855469,1500.00, -90.0, 0.0, -168.0, 45.0, true, 2)
    RenderScriptCams(1, 1, 0, 0, 0)
    Wait(0) -- Needed to load map
    SetFocusPosAndVel(GetCamCoord(cam), 0.0, 0.0, 0.0)
    SetCamActiveWithInterp(cam2, cam, 10000, 1, 1)
    Wait(0)
    SetFocusPosAndVel(GetCamCoord(cam2), 0.0, 0.0, 0.0)
    Wait(10000)
end

function cFromTopEnd()
    c = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 96.358459472656,-611.05651855469,4000.0, -90.0, 0.0, -168.0, 45.0, true, 2)
    SetCamActiveWithInterp(c, cam2, 2000, 1, 1)
    FinalEnd()
end

function FinalEnd()
    if Config.CameraToPlayerFade then
        DoScreenFadeOut(500)
    end

    if Config.Title.fadeInAndOut or Config.Subtitle.fadeInAndOut then
        mustFadeOut = true
    end
    Wait(3000)
    SetFocusEntity(GetPlayerPed(-1))
    inProgress = false
    RenderScriptCams(0, 1, 2000, 1, 0)
    Wait(2000)
    
    if Config.CameraToPlayerFade then
        DoScreenFadeIn(500)
    end

    if Config.OnPlayerFocus.enabled then
        PlaySoundFrontend(-1,Config.OnPlayerFocus.data[1], Config.OnPlayerFocus.data[2])
    end
    DestroyAllCams(true)
    isOnEndScreen = false
    cam,cam2,cam3,cam4,cam5,cam6,cam7,cam8,cam9 = nil
end

function PlayMusic(b)
    SendNUIMessage({
        type = "music",
        volume = Config.Music.volume,
        fadeDelay = Config.Music.fadeDelay,
        enable = b
    })
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if mustFadeOut then
            if Config.Title.enabled or Config.Subtitle.enabled then
                if Config.Title.enabled then
                    if FadeInTitle > 0 then
                        TextFade(Config.Title.data, 0.5, 0.1, 1.5, Config.Title.font, "title", "out")
                    end
                end

                if Config.Subtitle.enabled then
                    if FadeInSubTitle > 0 then
                        TextFade(Config.Subtitle.data, 0.5, 0.17, 0.6, Config.Subtitle.font, "subtitle", "out")
                    end
                end

                if FadeInSubTitle <= 0 and FadeInTitle <= 0 then
                    break
                end
            end
        end
    end
end)