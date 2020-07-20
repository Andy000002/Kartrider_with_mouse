forward,backward,left,right,sft,ctr="i","k","j","l","h","z";

state,sw,fod=1,1,0;--fod[fwd:1 stop:0 bwd:-1]
EnablePrimaryMouseButtonEvents(true)
function OnEvent(event, arg)
    OutputLogMessage("Event: "..event.." Arg: "..arg.."\n");
    swit(event,arg);
    FB(event,arg);
    LRS(event,arg);

end

function swit(event,arg)
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 9) then
		if(state%2==1)then
			OutputLogMessage("ON\n");
            sw=1;
            MoveMouseRelative(0,-20);
		else
            OutputLogMessage("OFF\n");
            sw=0;
            MoveMouseRelative(0,20);
            stop();
            fod=0;
		end
        state=(state+1)%2;
    end
end

function FB(event,arg)
    --F
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 5 and sw==1 and fod<1) then
        fod=fod+1;
    end
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 5 and sw==1 and fod==1) then
        ReleaseKey(forward);
        PressKey(forward);
    end
    --B
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 4 and sw==1 and fod>-1) then
        fod=fod-1;
    end
    if(fod==1 and sw == 1)then
        PressKey(forward);
    elseif(fod==-1 and sw == 1)then
        PressKey(backward);
    else
        stop();
    end
end

function LRS(event,arg)
    --L
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 1 and sw == 1) then
        PressKey(left);
    elseif (event == "MOUSE_BUTTON_RELEASED" and arg == 1 and sw == 1) then
        ReleaseKey(left);
    end
    --R
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 2 and sw == 1) then
        PressKey(right);
    elseif (event == "MOUSE_BUTTON_RELEASED" and arg == 2 and sw == 1) then
        ReleaseKey(right);
    end
    --SFT
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 6 and sw == 1) then
        PressKey(sft);
    elseif (event == "MOUSE_BUTTON_RELEASED" and arg == 6 and sw == 1) then
        ReleaseKey(sft);
    end
    --CTR
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 3 and sw == 1) then
        PressAndReleaseKey(ctr);
    end
end

function stop()
    ReleaseKey("k");
    ReleaseKey("i");
end