function GestureVisualize( gestures, multipleGestures, makeAVI )
%GestureVisualize Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2,
    multipleGestures = false;
end;

if nargin < 3,
     makeAVI = false;
end;


frame_rate = 15;
height = 0;

if multipleGestures 
    count = length(gestures);
    height = ceil(count / 3);
    subplot(height, 3, 1);
else
    gestures = {gestures};
    
end


frames = [];
index = 1;

while true
    
    proceed = false;
    
    clf;
    
    for i = 1:length(gestures)
        
        if multipleGestures
           subplot(height, 3, i); 
        end
        
        gesture = gestures{i};
        gesture_index = index;
        
        if size(gesture,1) >= index
            proceed = true;
        else
            gesture_index = size(gesture,1);
        end
 
        % get x, y, z
        if (ndims(gesture) == 3)
            x = gesture(gesture_index,:,1);
            y = gesture(gesture_index,:,2);
            z = gesture(gesture_index,:,3);
        elseif (ndims(gesture) == 2),
            x = gesture(gesture_index, (1:(end/3)) * 3 - 2);
            y = gesture(gesture_index, (1:(end/3)) * 3 - 1);
            z = gesture(gesture_index, (1:(end/3)) * 3 - 0);
        else
            disp 'Error: make sure input has dimension 2 (interleaved xyz) or 3 (separate xyz)'
            return;
        end;
        
        
        axis([-1,1,-1,1])
        plotFrame(x,y,z);
        
        
    end
    
    
    
    if (makeAVI),
        % grab frame for AVI export
        frames = [frames getframe(gcf)];
    else,
        % delay before next frame
        pause(1/frame_rate);
    end;
    
    
    
    if proceed
        index = index + 1;
    else
        break;
    end
    
    
end


if (makeAVI),
    movie2avi(frames, 'output.avi', 'fps', frame_rate);
end;


end




function plotFrame(x,y,z)


    edges = zeros(20,20);

    %neck
    edges(1,2) = 1;
    edges(1,3) = 1;
    edges(1,7) = 1;

    %torso
    edges(3,20) = 1;
    edges(7,19) = 1;
    edges(3,19) = 1;
    edges(7,20) = 1;
    edges(1,19) = 1;
    edges(1,20) = 1;

    %hip
    edges(11,20) = 1;
    edges(11,19) = 1;
    edges(15,20) = 1;
    edges(15,19) = 1;
    edges(19,20) = 1;
    edges(11,15) = 1;

    %right hand
    edges(3,4) = 1;
    edges(4,5) = 1;
    edges(5,6) = 1;

    %left hand
    edges(7,8) = 1;
    edges(8,9) = 1;
    edges(9,10) = 1;

    %right leg
    edges(11,12) = 1;
    edges(12,13) = 1;
    edges(13,14) = 1;

    %left leg
    edges(15,16) = 1;
    edges(16,17) = 1;
    edges(17,18) = 1;


%    set(gca,'NextPlot','replacechildren');
    hold on;
    for a = 1:size(edges,1),
        for b = a:size(edges,2),
            if(edges(a,b) == 1),
                plot3([x(a) x(b)],[y(a) y(b)],[z(a) z(b)]);
            end;
        end;
    end;
    
    hold off;
    

end

