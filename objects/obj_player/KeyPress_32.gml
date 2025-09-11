var _text;

// create a textbox if npc is nearby
if(nearbyNPC && global.playerControl == true){
    _text = nearbyNPC.myText;
    if (!instance_exists(obj_textbox)){
        var _textbox = instance_create_depth(x, y, -10000, obj_textbox);
        _textbox.textToShow = _text;
    }
}