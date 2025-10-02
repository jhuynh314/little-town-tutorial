global.playerControl = true;
global.gameOver = false;
global.gameStart = false;


// Player States
enum playerState {
    idle,
    walking,
    pickingUp,
    carrying,
    carryIdle,
    puttingDown,
}

// Item states
enum itemState {
    idle,
    taken,
    used,
    puttingBack,
}

// Sequence States
enum seqState {
    notPlaying,
    waiting,
    playing,
    finished,
}

// sequence variables
sequenceState = seqState.notPlaying;
curSeqLayer = noone;
curSeq = noone;

// NPC States
enum npcState {
    normal,
    done,
}