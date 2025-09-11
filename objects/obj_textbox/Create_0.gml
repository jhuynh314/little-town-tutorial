textToShow = "This is the text and this is even more text to get it on to another line";
textWidth = 450;
lineHeight = 35;
fadeMe = 0;
fadeSpeed = 0.1;
image_alpha = 0;

global.playerControl = false;

// Play ui sound
audio_play_sound(snd_pop01, 1, false);

// Dismiss any visible prompts
scr_dismissPrompt(obj_prompt, 0);