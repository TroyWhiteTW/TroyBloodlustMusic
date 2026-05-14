local addon = select(2, ...)
local deDELocale = {
    ["A message will be shown in chat when the addon detects a Bloodlust-like effect and when it fades"] = "Eine Nachricht wird im Chat angezeigt, wenn das AddOn einen Blutdurst-ähnlichen Effekt erkennt und wenn dieser endet",
    ["Ambience"] = "Umgebung",
    ["Dialog"] = "Dialog",
    ["Enable Bloodlust detection"] = "Blutdurst-Erkennung aktivieren",
    ["Master"] = "Hauptlautstärke",
    ["Music"] = "Musik",
    ["Preview sound"] = "Sound-Vorschau",
    ["Preview the selected sound file on the selected channel"] = "Spielt die ausgewählte Sound-Datei auf dem ausgewählten Kanal als Vorschau ab",
    ["Random: A random sound each time"] = "Zufällig: Jedes Mal ein zufälliger Sound",
    ["SFX"] = "Soundeffekte",
    ["Show bloodlust detection messages in chat"] = "Blutdurst-Erkennungsnachrichten im Chat anzeigen",
    ["Sound channel to use"] = "Zu verwendender Soundkanal",
    ["Sound to play"] = "Abzuspielender Sound",
    ["The sound channel to use when playing the sound. The volume of the sound will be affected by your sound options for that channel."] = "Der Soundkanal, der beim Abspielen des Sounds verwendet wird. Die Lautstärke wird von deinen Sound-Einstellungen für diesen Kanal beeinflusst.",
    ["The sound to play when a Bloodlust-like effect is detected.\n\nTo add your own sounds, place .ogg or .mp3 files in the sounds folder and add their filenames to sounds\\sounds.lua, then /reload."] = "Der Sound, der abgespielt wird, wenn ein Blutdurst-ähnlicher Effekt erkannt wird.\n\nUm eigene Sounds hinzuzufügen, lege .ogg- oder .mp3-Dateien in den sounds-Ordner und füge ihre Dateinamen zu sounds\\sounds.lua hinzu, dann /reload.",
    ["Turns on the detection of Bloodlust-like effects on your character and playing of custom sounds"] = "Aktiviert die Erkennung von Blutdurst-ähnlichen Effekten auf deinem Charakter und das Abspielen benutzerdefinierter Sounds",
    ["Bloodlust detected!"] = "Blutdurst erkannt!",
    ["Bloodlust has faded"] = "Blutdurst ist verblasst",
}

addon:RegisterLocale('deDE', deDELocale)