local addon = select(2, ...)
local baseLocale = {
    ["A message will be shown in chat when the addon detects a Bloodlust-like effect and when it fades"] = "A message will be shown in chat when the addon detects a Bloodlust-like effect and when it fades",
    ["Ambience"] = "Ambience",
    ["Dialog"] = "Dialog",
    ["Enable Bloodlust detection"] = "Enable Bloodlust detection",
    ["Master"] = "Master",
    ["Music"] = "Music",
    ["Preview sound"] = "Preview sound",
    ["Preview the selected sound file on the selected channel"] = "Preview the selected sound file on the selected channel",
    ["Random: A random sound each time"] = "Random: A random sound each time",
    ["SFX"] = "SFX",
    ["Show bloodlust detection messages in chat"] = "Show bloodlust detection messages in chat",
    ["Sound channel to use"] = "Sound channel to use",
    ["Sound to play"] = "Sound to play",
    ["The sound channel to use when playing the sound. The volume of the sound will be affected by your sound options for that channel."] = "The sound channel to use when playing the sound. The volume of the sound will be affected by your sound options for that channel.",
    ["The sound to play when a Bloodlust-like effect is detected.\n\nTo add your own sounds, place .ogg or .mp3 files in the sounds folder and add their filenames to sounds\\sounds.lua, then /reload."] = "The sound to play when a Bloodlust-like effect is detected.\n\nTo add your own sounds, place .ogg or .mp3 files in the sounds folder and add their filenames to sounds\\sounds.lua, then /reload.",
    ["Turns on the detection of Bloodlust-like effects on your character and playing of custom sounds"] = "Turns on the detection of Bloodlust-like effects on your character and playing of custom sounds",
    ["Bloodlust detected!"] = "Bloodlust detected!",
    ["Bloodlust has faded"] = "Bloodlust has faded",
}

addon:RegisterLocale('enUS', baseLocale)
