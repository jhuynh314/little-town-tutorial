switch sequenceState {
    case seqState.playing: {
        global.playerControl = false;
    } break;
    case seqState.finished: {
        if (layer_sequence_exists(curSeqLayer, curSeq)){
            layer_sequence_destroy(curSeq);
        }
        global.playerControl = true;
        sequenceState = seqState.notPlaying;
        curSeq = noone;
    } break;
}