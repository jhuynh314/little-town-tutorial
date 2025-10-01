// Play music based on room
switch room {
    case rm_gameMain: {
        audio_play_sound(snd_townBGM,1,1);
        audio_play_sound(snd_townAmbience,1,1);
    } break;
}

// Mark Sequences Layer
if (layer_exists("Cutscenese")) {
    curSeqLayer = "Cutscenese";
} else {
    curSeqLayer = "Instances";
}