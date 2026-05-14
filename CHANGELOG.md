# TroyBloodlustMusic

原始概念啟發自 [OhnoBloodlust](https://github.com/jnwhiteh/OhnoBloodlust)（Cladhaire / jnwhiteh）。獨立實作、獨立發佈。

Inspired by [OhnoBloodlust](https://github.com/jnwhiteh/OhnoBloodlust) by Cladhaire (jnwhiteh). Released as a standalone addon with an independent implementation.

## v1.0.0-release (2026-04-28)

- 偵測玩家身上出現嗜血類加成（薩滿嗜血／英勇、法師時光扭曲、獵人寵物 Ancient Hysteria／Primal Rage、喚能師 Fury of the Aspects）時播放自訂音效 / Plays a configurable sound when a bloodlust-like buff appears on the player (Bloodlust / Heroism, Time Warp, Ancient Hysteria / Primal Rage, Fury of the Aspects)
- 設定面板（Blizzard Settings API）支援啟用切換、聊天提示、音效與音效頻道選擇、預覽按鈕 / Settings panel via Blizzard Settings API: enable toggle, chat-message toggle, sound picker, sound-channel picker, preview button
- 動態音效載入：將 `.ogg` / `.mp3` 放入 `sounds/`、於 `sounds/sounds.lua` 列出檔名後 `/reload` 即可使用；內建「隨機」選項 / Dynamic sound loading: drop `.ogg` / `.mp3` into `sounds/`, list filenames in `sounds/sounds.lua`, then `/reload`; a "Random" option is built in
- 多語系：英文（enUS）、繁體中文（zhTW）/ Localizations: English (enUS), Traditional Chinese (zhTW)
- 登入抑制：登入或重載時若已有嗜血類加成不觸發播音 / Login suppression: buffs already present at login/reload do not trigger playback
- SavedVariables `TroyBloodlustMusicDB`，由 AceDB-3.0 管理 profile / SavedVariables `TroyBloodlustMusicDB`, profile managed via AceDB-3.0