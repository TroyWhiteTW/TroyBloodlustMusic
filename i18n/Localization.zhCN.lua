local addon = select(2, ...)
local zhCNLocale = {
    ["A message will be shown in chat when the addon detects a Bloodlust-like effect and when it fades"] = "当插件检测到嗜血类效果出现或消退时，在聊天框显示消息",
    ["Ambience"] = "环境",
    ["Dialog"] = "对话",
    ["Enable Bloodlust detection"] = "启用嗜血检测",
    ["Master"] = "主音量",
    ["Music"] = "音乐",
    ["Preview sound"] = "预览音效",
    ["Preview the selected sound file on the selected channel"] = "在所选频道预览所选音效",
    ["Random: A random sound each time"] = "随机：每次随机播放一个音效",
    ["SFX"] = "音效",
    ["Show bloodlust detection messages in chat"] = "在聊天框显示嗜血检测消息",
    ["Sound channel to use"] = "音效频道",
    ["Sound to play"] = "播放音效",
    ["The sound channel to use when playing the sound. The volume of the sound will be affected by your sound options for that channel."] = "播放音效时使用的频道，音量受该频道的音量设置影响。",
    ["The sound to play when a Bloodlust-like effect is detected.\n\nTo add your own sounds, place .ogg or .mp3 files in the sounds folder and add their filenames to sounds\\sounds.lua, then /reload."] = "检测到嗜血类效果时播放的音效。\n\n添加自定义音效：将 .ogg 或 .mp3 文件放入 sounds 文件夹，并在 sounds\\sounds.lua 加入文件名，然后 /reload。",
    ["Turns on the detection of Bloodlust-like effects on your character and playing of custom sounds"] = "开启检测角色身上的嗜血类效果，并在触发时播放音效",
    ["Bloodlust detected!"] = "检测到嗜血！",
    ["Bloodlust has faded"] = "嗜血已消退",
}

addon:RegisterLocale('zhCN', zhCNLocale)