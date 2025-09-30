if (global.playerControl == true) {
    moveRight = keyboard_check(vk_right);
    moveLeft = keyboard_check(vk_left);
    moveUp = keyboard_check(vk_up);
    moveDown = keyboard_check(vk_down);
} else {
    moveRight = 0;
    moveLeft = 0;
    moveUp = 0;
    moveDown = 0;
}

// run with Shift Key
running = keyboard_check(vk_shift);
// speed up if running
if (running == true){
    // ramp up
    if (runSpeed < runMax) {
        runSpeed += 2;
    }
    // Start creating dust
    if (startDust == 0){
        alarm[0] = 2;
        startDust = 1;
    }
}
// slow down if no longer running
if (running == false) {
    if (runSpeed > 0){
        runSpeed -= 1;
    }
    
    startDust = 0;
}


// Calculate Movement
vx = (moveRight-moveLeft) * (walkSpeed + runSpeed) * (1-carryLimit);
vy = (moveDown - moveUp) * (walkSpeed + runSpeed) * (1-carryLimit);

// If Idle
if (vx == 0 && vy == 0) {
    // If I am not picking up or putting down an item
    if (myState != playerState.pickingUp && myState != playerState.puttingDown){
        // If I don't have an item
        if (hasItem == noone) {
            myState = playerState.idle;
        }
        // If I am carrying an item
        else {
            myState = playerState.carryIdle;
        }
    }
}

// If moving
if (vx != 0 || vy != 0){
    if (!collision_point(x+vx, y, obj_parent_environment, true, true)){
        x += vx;
    }
    if (!collision_point(x, y+vy, obj_parent_environment, true, true)){
        y += vy;   
    }
    
    // change direction based on movmenet
    if(vx > 0 ){
        dir = 0;
    }
    if(vx < 0 ){
        dir = 2;
    }
    if(vy > 0 ){
        dir = 3;
    }
    if(vy < 0 ){
        dir = 1;
    }
    
    // Set state
    // If we don't have an item
    if (hasItem == noone) {
        myState = playerState.walking;
    }
    else {
        myState = playerState.carrying
    }
    
    // Move audio listener with me
    audio_listener_set_position(0,x,y,0);
}

// Check for collisions with NPCs
nearbyNPC = collision_rectangle(x-lookRange, y-lookRange,x+lookRange, y+lookRange, obj_par_npc,false,true);
if(nearbyNPC){
    // Play greeting sound
    if (!hasGreeted){
        if !(audio_is_playing(snd_greeting01)) {
            hasGreeted = true;
            audio_play_sound(snd_greeting01,1,0);
        }
    }
    
    // Pop up prompt
    if(npcPrompt == noone || npcPrompt == undefined){
        npcPrompt = scr_showPrompt(nearbyNPC, nearbyNPC.x, nearbyNPC.y-450);
    }
}
if(!nearbyNPC){
    // reset greeting
    if(hasGreeted){
        hasGreeted = false;
    }
    
    // get rid of prompt
    scr_dismissPrompt(npcPrompt, 0);
}

// Check for collisions with items
nearbyItem = collision_rectangle(x-lookRange, y-lookRange,x+lookRange, y+lookRange, obj_par_item,false,true);
if(nearbyItem && !nearbyNPC){
    // Pop up prompt
    if(itemPrompt == noone || itemPrompt == undefined){
        show_debug_message("obj_player has found an item!");
        itemPrompt = scr_showPrompt(nearbyItem, nearbyItem.x, nearbyItem.y-100);
    }
}
if(!nearbyItem || nearbyNPC){
    // get rid of prompt
    scr_dismissPrompt(itemPrompt, 1);
}

// If picking up an item
if (myState == playerState.pickingUp){
    if (image_index >= image_number-1){
        myState = playerState.carrying;
        global.playerControl = true;
    }
}

// If putting down an item
if (myState == playerState.puttingDown){
    if (image_index >= image_number-1){
        myState = playerState.idle;
        global.playerControl = true;
    }
}

// Depth sorting
depth = -y;

// Auto-choose sprite based on state and diretion
sprite_index = playerSpr[myState][dir];