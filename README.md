# TroyBloodlustMusic

Plays a custom sound whenever you receive a Bloodlust-like effect — Bloodlust / Heroism, Time Warp, Primal Rage, Fury of the Aspects, and Ancient Hysteria. Pick from the bundled tracks, or drop in your own.

[繁體中文說明見下方 ↓](#中文說明)

---

## Features

- **Detects every Bloodlust variant** — Shaman (Bloodlust / Heroism), Mage (Time Warp), Hunter pet (Primal Rage / Ancient Hysteria), Evoker (Fury of the Aspects)
- **Random mode** — a different track each time
- **Pick the sound channel** — Master / Music / SFX / Ambience / Dialog, so playback follows your volume settings
- **Bring your own sounds** — see [Adding your own sounds](#adding-your-own-sounds) below
- **Preview button** in the options panel — hear the selected track without waiting for combat
- **Login-safe** — won't fire if you log in while the effect is already active
- **Combat-safe re-sync** — corrects state after `UNIT_AURA` throttling in long fights
- **Optional chat messages** when the effect starts and fades
- **Localized** — English and 繁體中文

## Configuration

`ESC` → **Options** → **AddOns** → **TroyBloodlustMusic**

Available settings:

- Enable / disable Bloodlust detection
- Show start / fade messages in chat
- Pick a sound (or **Random**)
- Pick a sound channel
- **Preview sound** button

## Adding your own sounds

1. Drop `.ogg` or `.mp3` files into the addon's `sounds/` folder
2. Open `sounds/sounds.lua` and add the filename to the `soundManifest` list
3. `/reload` in-game

The new track will appear in the sound picker, and **Random** mode will include it automatically.

> **Note**: files added this way live in your local install only. They are not synced to other characters / installations, and will be overwritten when you update the addon — keep a backup.

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

## Issues

Bug reports and feature requests: [GitHub Issues](https://github.com/TroyWhiteTW/TroyBloodlustMusic/issues)

## Credits

Original concept inspired by [OhnoBloodlust](https://github.com/jnwhiteh/OhnoBloodlust) by Cladhaire (jnwhiteh). This addon is an independent reimplementation for retail World of Warcraft with custom sound management and additional features.

Built on [LibStub](https://www.wowace.com/projects/libstub) and [AceDB-3.0](https://www.wowace.com/projects/ace3) (WowAce).

---

## 中文說明

當你受到嗜血類效果時自動播放音效 — 涵蓋薩滿（嗜血／英勇）、法師（時光扭曲）、獵人寵物（原始狂怒／古老歇斯底里）、喚能者（諸神之怒）。內建多首音效，也可自行替換。

## 功能

- **偵測所有嗜血變體** — 薩滿、法師、獵人寵物、喚能者全系列嗜血類技能
- **隨機模式** — 每次播放不同曲目
- **可選音效頻道** — 主控／音樂／音效／環境／對話，跟隨遊戲音量設定
- **自訂音效** — 見下方[自訂音效](#自訂音效)段落
- **試聽按鈕** — 設定面板直接預覽，不必等實戰
- **登入抑制** — 登入時若已有嗜血 buff 不會誤觸
- **戰鬥結束後重新同步** — 修正 `UNIT_AURA` 在戰鬥中節流可能漏失的狀態
- **可選聊天提示** — 嗜血開始與結束時於聊天視窗顯示訊息
- **多語系** — 英文、繁體中文

## 設定

`ESC` → **選項** → **插件** → **TroyBloodlustMusic**

可設定項目：

- 啟用／停用嗜血偵測
- 聊天視窗顯示開始／結束提示
- 選擇音效（或**隨機**）
- 選擇音效頻道
- **試聽**按鈕

## 自訂音效

1. 將 `.ogg` 或 `.mp3` 檔放進插件的 `sounds/` 資料夾
2. 開啟 `sounds/sounds.lua`，將檔名加入 `soundManifest` 列表
3. 遊戲中執行 `/reload`

新音效會出現在音效選單中，**隨機**模式也會自動包含。

> **注意**：用這種方式新增的音檔僅存在本機安裝中。不會同步至其他角色／安裝，更新插件時會被覆蓋 — 請自行備份。

## 更新紀錄

詳見 [CHANGELOG.md](CHANGELOG.md)。

## 問題回報

錯誤回報與功能建議：[GitHub Issues](https://github.com/TroyWhiteTW/TroyBloodlustMusic/issues)

## 致謝

原始概念啟發自 Cladhaire (jnwhiteh) 的 [OhnoBloodlust](https://github.com/jnwhiteh/OhnoBloodlust)。本插件為正式版 World of Warcraft 的獨立重寫實作，加入自訂音效管理與其他功能。

基於 [LibStub](https://www.wowace.com/projects/libstub) 與 [AceDB-3.0](https://www.wowace.com/projects/ace3)（WowAce）構建。