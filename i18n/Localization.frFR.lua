local addon = select(2, ...)
local frFRLocale = {
    ["A message will be shown in chat when the addon detects a Bloodlust-like effect and when it fades"] = "Un message s'affichera dans le chat lorsque l'addon détecte un effet de type Soif de sang et lorsqu'il disparaît",
    ["Ambience"] = "Ambiance",
    ["Dialog"] = "Dialogue",
    ["Enable Bloodlust detection"] = "Activer la détection de Soif de sang",
    ["Master"] = "Principal",
    ["Music"] = "Musique",
    ["Preview sound"] = "Aperçu du son",
    ["Preview the selected sound file on the selected channel"] = "Joue le fichier sonore sélectionné sur le canal sélectionné en aperçu",
    ["Random: A random sound each time"] = "Aléatoire : un son aléatoire à chaque fois",
    ["SFX"] = "Effets sonores",
    ["Show bloodlust detection messages in chat"] = "Afficher les messages de détection de Soif de sang dans le chat",
    ["Sound channel to use"] = "Canal sonore à utiliser",
    ["Sound to play"] = "Son à jouer",
    ["The sound channel to use when playing the sound. The volume of the sound will be affected by your sound options for that channel."] = "Le canal sonore à utiliser pour jouer le son. Le volume du son sera affecté par vos options sonores pour ce canal.",
    ["The sound to play when a Bloodlust-like effect is detected.\n\nTo add your own sounds, place .ogg or .mp3 files in the sounds folder and add their filenames to sounds\\sounds.lua, then /reload."] = "Le son à jouer lorsqu'un effet de type Soif de sang est détecté.\n\nPour ajouter vos propres sons, placez des fichiers .ogg ou .mp3 dans le dossier sounds et ajoutez leurs noms dans sounds\\sounds.lua, puis /reload.",
    ["Turns on the detection of Bloodlust-like effects on your character and playing of custom sounds"] = "Active la détection des effets de type Soif de sang sur votre personnage et la lecture de sons personnalisés",
    ["Bloodlust detected!"] = "Soif de sang détectée !",
    ["Bloodlust has faded"] = "Soif de sang a disparu",
}

addon:RegisterLocale('frFR', frFRLocale)