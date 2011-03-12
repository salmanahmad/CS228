function GestureVisualize( gesture )
%GestureVisualize Summary of this function goes here
%   Detailed explanation goes here


gesture = cell2mat(gesture);

frame_rate = 30;

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





j = 1;

frames = [];

for i = 1:size(gesture,1),
    
    x = [];
    y = [];
    z = [];
    
    points = [x y z];
    
    for j = 1:size(gesture,2),
        index = mod(j-1, 3);
        if index == 0,
            x = [x gesture(i,j)];
        elseif(index == 1),
            y = [y gesture(i,j)];
        elseif(index == 2),
            z = [z gesture(i,j)];
        end;
       
    end

    clf;
    axis([-1,1,-1,1])
    
    set(gca,'NextPlot','replacechildren');
    hold on;
    for a = 1:size(edges,1),
        for b = a:size(edges,2),
            if(edges(a,b) == 1),
                plot3([x(a) x(b)],[y(a) y(b)],[z(a) z(b)]);
            end;
        end;
    end;
    
    hold off;
    
    
    %scatter3(x,y,z);
    frames = [frames getframe];
    j = j + 1;
    %pause(1/frame_rate);
    
    
end;


movie2avi(frames, 'output.avi', 'fps', 30);

end

