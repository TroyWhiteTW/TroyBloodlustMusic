local addon = select(2, ...)
local zhTWLocale = {
    ["A message will be shown in chat when the addon detects a Bloodlust-like effect and when it fades"] = "當插件偵測到嗜血類效果出現或消退時，將在聊天框顯示訊息",
    ["Ambience"] = "環境音",
    ["Dialog"] = "對話",
    ["Enable Bloodlust detection"] = "啟用嗜血偵測",
    ["Master"] = "主音量",
    ["Music"] = "音樂",
    ["Preview sound"] = "預覽音效",
    ["Preview the selected sound file on the selected channel"] = "在所選頻道預覽所選音效",
    ["Random: A random sound each time"] = "隨機：每次隨機播放一個音效",
    ["SFX"] = "音效",
    ["Show bloodlust detection messages in chat"] = "在聊天框顯示嗜血偵測訊息",
    ["Sound channel to use"] = "音效頻道",
    ["Sound to play"] = "播放音效",
    ["The sound channel to use when playing the sound. The volume of the sound will be affected by your sound options for that channel."] = "播放音效時使用的頻道，音量受該頻道的音量設定影響。",
    ["The sound to play when a Bloodlust-like effect is detected.\n\nTo add your own sounds, place .ogg or .mp3 files in the sounds folder and add their filenames to sounds\\sounds.lua, then /reload."] = "偵測到嗜血類效果時播放的音效。\n\n新增自訂音效：將 .ogg 或 .mp3 檔放入 sounds 資料夾，並在 sounds\\sounds.lua 加入檔名，然後 /reload。",
    ["Turns on the detection of Bloodlust-like effects on your character and playing of custom sounds"] = "開啟偵測角色身上的嗜血類效果，並在觸發時播放音效",
    ["Bloodlust detected!"] = "偵測到嗜血！",
    ["Bloodlust has faded"] = "嗜血已消退",
}

addon:RegisterLocale('zhTW', zhTWLocale)
