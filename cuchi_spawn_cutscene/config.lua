Config = {}

Config.Type = "fast" -- fast (~3.5s) / short (~10s) / normal (~30s) / long (~55s) / fromtop (~9s)
Config.CameraToPlayerFade = true -- Enable/Disable the fade when switching the camera to the player's cam

Config.Message = {
    msg = "Press ~g~SPACE~w~ to confirm spawn", -- Message displayed at the end of the cutscene
    font = 4 -- 1, 2 or 4 are valid fonts
}

Config.SetInvincible = true -- Set player invincible while loading
Config.SetInvisible = true -- Set player invisible while loading
Config.DisablePlayerCollision = true -- Disable player collision (can't be pushed or shooted by other player while loading)

Config.Title = {
    enabled = true,
    data = "Welcome to ~p~Server",
    font = 1, -- 1, 2 or 4 are valid fonts
    fadeInAndOut = true,
    FadeIn = 3, -- Most you increase this most the fade in will be fast
    FadeOut = 6 -- Most you increase this most the fade out will be fast
}

Config.Subtitle = {
    enabled = true,
    data = "Enjoy on our server!",
    font = 4, -- 1, 2 or 4 are valid fonts
    fadeInAndOut = true,
    FadeIn = 3, -- Most you increase this most the fade in will be fast
    FadeOut = 6 -- Most you increase this most the fade out will be fast
}

--[[
    To change sounds, check out https://pastebin.com/DCeRiaLJ
    In data array, replace first value by the sound name wanted
    and replace the second value by the soundset name.
    If sound isn't working, try to replace him by another one
]]
Config.SpacebarSound = {
    enabled = true, -- Play sound when play valid his spawn
    data = {"TOGGLE_ON", "HUD_FRONTEND_DEFAULT_SOUNDSET"}
}
Config.OnPlayerFocus = {
    enabled = false, -- Play sound when cam is on player
    data = {"CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET"}
}

Config.Music = {
    -- To change the audio, just add a mp3 file (rename it by > "music.mp3"), place it in the html directory by replacing the current music.mp3
    enabled = true,
    volume = 0.2, -- 0 to 1
    fadeDelay = 100, -- The more you reduce this delay, the faster the fade ends.
    canUserPause = true -- Allow user to press a button to pause music
}
