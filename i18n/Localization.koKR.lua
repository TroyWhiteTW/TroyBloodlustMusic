local addon = select(2, ...)
local koKRLocale = {
    ["A message will be shown in chat when the addon detects a Bloodlust-like effect and when it fades"] = "애드온이 피의 욕망 계열 효과의 발동과 소멸을 감지할 때 채팅에 메시지를 표시합니다",
    ["Ambience"] = "환경",
    ["Dialog"] = "대화",
    ["Enable Bloodlust detection"] = "피의 욕망 감지 사용",
    ["Master"] = "마스터",
    ["Music"] = "음악",
    ["Preview sound"] = "사운드 미리듣기",
    ["Preview the selected sound file on the selected channel"] = "선택한 채널에서 선택한 사운드 파일을 미리 재생합니다",
    ["Random: A random sound each time"] = "무작위: 매번 임의의 사운드 재생",
    ["SFX"] = "효과음",
    ["Show bloodlust detection messages in chat"] = "채팅에 피의 욕망 감지 메시지 표시",
    ["Sound channel to use"] = "사용할 사운드 채널",
    ["Sound to play"] = "재생할 사운드",
    ["The sound channel to use when playing the sound. The volume of the sound will be affected by your sound options for that channel."] = "사운드 재생에 사용할 채널입니다. 사운드 볼륨은 해당 채널의 사운드 설정에 영향을 받습니다.",
    ["The sound to play when a Bloodlust-like effect is detected.\n\nTo add your own sounds, place .ogg or .mp3 files in the sounds folder and add their filenames to sounds\\sounds.lua, then /reload."] = "피의 욕망 계열 효과가 감지되었을 때 재생할 사운드입니다.\n\n사용자 사운드 추가: .ogg 또는 .mp3 파일을 sounds 폴더에 넣고, sounds\\sounds.lua에 파일명을 추가한 다음 /reload 하십시오.",
    ["Turns on the detection of Bloodlust-like effects on your character and playing of custom sounds"] = "캐릭터에 적용된 피의 욕망 계열 효과 감지와 사용자 사운드 재생을 켭니다",
    ["Bloodlust detected!"] = "피의 욕망 감지됨!",
    ["Bloodlust has faded"] = "피의 욕망이 소멸되었습니다",
}

addon:RegisterLocale('koKR', koKRLocale)