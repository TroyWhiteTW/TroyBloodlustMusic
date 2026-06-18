# TroyBloodlustMusic — Changelog

Version history. Original concept inspired by [OhnoBloodlust](https://github.com/jnwhiteh/OhnoBloodlust) by Cladhaire (jnwhiteh) — independent reimplementation.

[繁體中文更新紀錄見下方 ↓](#中文更新紀錄)

---

## English Changelog

### v1.1.1-release (2026-06-18)

- Bumped `## Interface` to 120007 for compatibility with World of Warcraft 12.0.7

### v1.1.0-release (2026-05-15)

- Added Simplified Chinese (zhCN), Korean (koKR), German (deDE), and French (frFR) localizations covering all settings-panel strings and chat messages
- Updated `.toc` load order so enUS loads first as the baseline, with the active client locale loaded afterwards to override; missing keys fall back to enUS, then to the key itself

### v1.0.0-release (2026-05-14)

- Plays a configurable sound when a bloodlust-like buff appears on the player — Bloodlust / Heroism (Shaman), Time Warp (Mage), Ancient Hysteria / Primal Rage (Hunter pet), Fury of the Aspects (Evoker)
- Settings panel via Blizzard Settings API: enable toggle, chat-message toggle, sound picker, sound-channel picker, preview button
- Dynamic sound loading: drop `.ogg` / `.mp3` into `sounds/`, list filenames in `sounds/sounds.lua`, then `/reload`; a "Random" option is built in
- Localizations: English (enUS), Traditional Chinese (zhTW)
- Login suppression: buffs already present at login/reload do not trigger playback
- SavedVariables `TroyBloodlustMusicDB`, profile managed via AceDB-3.0

---

## 中文更新紀錄

### v1.1.1-release (2026-06-18)

- 更新 `## Interface` 至 120007，相容魔獸世界 12.0.7 版本

### v1.1.0-release (2026-05-15)

- 新增簡體中文（zhCN）、韓文（koKR）、德文（deDE）、法文（frFR）四種語系，涵蓋設定面板與聊天訊息全部字串
- 調整 `.toc` 載入順序：enUS 先載入作為基底，當前 client locale 後載入覆蓋；缺漏的 key 會 fallback 到 enUS，再 fallback 到 key 本身

### v1.0.0-release (2026-05-14)

- 偵測玩家身上出現嗜血類加成時播放自訂音效 — 薩滿嗜血／英勇、法師時光扭曲、獵人寵物 Ancient Hysteria／Primal Rage、喚能師 Fury of the Aspects
- 設定面板（Blizzard Settings API）支援啟用切換、聊天提示、音效與音效頻道選擇、預覽按鈕
- 動態音效載入：將 `.ogg` / `.mp3` 放入 `sounds/`、於 `sounds/sounds.lua` 列出檔名後 `/reload` 即可使用；內建「隨機」選項
- 多語系：英文（enUS）、繁體中文（zhTW）
- 登入抑制：登入或重載時若已有嗜血類加成不觸發播音
- SavedVariables `TroyBloodlustMusicDB`，由 AceDB-3.0 管理 profile