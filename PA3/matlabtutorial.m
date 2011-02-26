%% --------------------------------------------------------------------- %%
clc
clear
disp('%-------------------------------------------------------------%');
disp('%            CS228 Probabilistic Graphical Models             %');
disp('%                                                             %');
disp('%                       Matlab Tutorial                       %');
disp('%                                                             %');
disp('%           Copyright (C) 2011, Stanford University           %');
disp('%        Contact: Huayan Wang <huayanw@cs.stanford.edu>       %');
disp('%-------------------------------------------------------------%');
%% ----------------------------------------------------------------------%%
pause; disp(' ');
disp('% if you''re new to Matlab, there''s no need to remmember all');
disp('% the syntax you see in this tutorial');
pause; disp(' ');
disp('% it''s more important to have an impression of what can be done');
disp('% in Matlab, and lookup the syntax at http://www.mathworks.com/');
pause; disp(' ');
disp('% we will also put this tutorial script online');
pause; disp(' ');

disp('% to get started:');
pause; disp(' ');

disp('% in Linux: ssh to ''corn'' or ''myth'' clusters');
disp('% ssh yourself@corn.stanford.edu -X');
disp('% matlab                                      (full display, slow)');
disp('% matlab -nojvm       (command line, can display plots, no images)');
disp('% matlab -nodisplay                         (fast, ssh without -X)');
disp('% matlab -logfile "filename"           (keep a log of all outputs)');
pause; disp(' ');

disp('% in Windows: use ssh softwares such as SecureCRT'); 
pause; disp(' ');
disp('% residential/library computer clusters: find Matlab on desktop');
pause; disp(' ');

disp('% a free alternative to Matlab: Octave ');
disp('% http://www.gnu.org/software/octave/');
pause; disp(' ');

%% ----------------------------------------------------------------------%%
warning('off', 'all');
disp('% we start with basic arithmetic operators: plus +, minus -,');
disp('% multiply *, divide /, power ^ ');
disp(' ');
disp('(1 + 1)^(2 * 3)'); (1 + 1)^(2 * 3)
pause; disp(' ');

disp('% the ''ans'' gives the answer for the statement ');
pause; disp(' ');

disp('% relational operators: equality ==, inequality ~= (not !=), ');
disp('%  >, <, >=, <= ');
disp(' ');
disp('sqrt(2) < 1'); sqrt(2) < 1
pause; disp(' ');

disp('% logical operators: AND &&, OR ||, NOT ~, exclusive-OR xor()');
disp(' ');
disp('1 + 1 == 3 || 2 + 2 ~= 5'); 1 + 1 == 3 || 2 + 2 ~= 5 
pause; disp(' ');

disp('% useful constants: pi, e, and i, j (square root of -1) ');
disp(' ');
disp('i*i*pi'); i*i*pi
pause; disp(' ');

disp('% variables are AUTOMATICALLY defined when you assign values');
disp(' ');
disp('a = 1 + 1;'); a = 1 + 1;
pause; disp(' ');

disp('% you can even override existing names in Matlab,');
disp('% it is okay if you do this unconsciously, (use i for loops)');
disp(' ');
disp('pi = 1;'); pi = 1;
pause; disp(' ');

disp('% omit semicolon ; at the end of a statement to get output');
disp(' ');
disp('b = a + pi'); b = a + pi
pause; disp(' ');

disp('% detele the variable, and you get the original pi back');
disp(' ');
disp('clear pi'); clear pi
disp('b = a + pi'); b = a + pi
pause; disp(' ');

disp('% define a row vector');
disp(' ');
disp('a = [1 2 3]'); a = [1 2 3]
pause; disp(' ');

disp('% define a column vector, Matlab is case sensitive');
disp(' ');
disp('A = [2; 2; 3]'); A = [2; 2; 3]
pause; disp(' ');

disp('% matrix multiplication');
disp(' ');
disp('a * A'); a * A 
disp('A * a'); A * a
pause; disp(' ');

disp('% transpose and element-wise multiplication');
disp(' ');
disp('a .* A'''); a .* A'
pause; disp(' ');

disp('% define a 3x3 matrix, semicolon ; separates rows');
disp(' ');
disp('c = [1  0 -1; 0  1  0; -1  0  1]'); c=[1  0 -1; 0  1  0; -1  0  1]
pause; disp(' ');

disp('% concatenate matrices horizontally or vertically');
disp('% prefix dot . to an operator makes it element-wise');
disp(' ');
disp('[c^2  c.^2]'); [c^2  c.^2]
disp('[c^2 ; c.^2]'); [c^2 ; c.^2]
pause; disp(' ');

disp('% relational and logical operators applies to matrices');
disp(' ');
disp('c >= 0'); c >= 0    
pause; disp(' ');

disp('% 3x3 identity matrix');
disp(' ');
disp('a = eye(3)'); a = eye(3)
pause; disp(' ');

disp('% 2x4 matrix with all 1s, you also have zeros()');
disp(' ');
disp('b = ones(2,4)'); b = ones(2,4)
pause; disp(' ');

disp('% define a vector by specifying start:step:end');
disp(' ');
disp('c = 1:0.2:2'); c = 1:0.2:2
pause; disp(' ');

disp('% omit step to get default step size 1');
disp(' ');
disp('d = 1:6'); d = 1:6
pause; disp(' ');

disp('% 1x4 matrix from uniform distribution U[0 1]');
disp(' ');
disp('e = rand(1,4)'); e = rand(1,4)
pause; disp(' ');

disp('% 2x3 matrix from normal distribution N(0,1)');
disp(' ');
disp('a = randn(2,3)'); a = randn(2,3)
pause; disp(' ');

disp('% access matrix elements, two key differences from c++');
disp('% indexing from 1 instead of 0');
disp('% use ( ) instead of [ ]');
disp(' ');
disp('a(1,1)'); a(1,1)
pause; disp(' ');

disp('% out of range? the matrix grows AUTOMATICALLY');
disp(' ');
disp('a(3,5) = 7'); a(3,5) = 7
pause; disp(' ');

disp('% access a sub-matrix, use start:end to specify range');
disp(' ');
disp('b = a(2:3, 2:5)'); b = a(2:3, 2:5)
pause; disp(' ');

disp('% access second column (omit start and end for whole range)');
disp(' ');
disp('c = a(:, 2)'); c = a(:, 2)
pause; disp(' ');

disp('% images are matrices too, load an image from jpg file');
disp(' ');
disp('img = imread(''image.jpg'');'); img = imread('image.jpg');
pause; disp(' ');

disp('% use ''whos'' to check the workspace (all variables)');
disp(' ');
disp('whos'); whos
disp('% we can see the (color) image is stored as 3-D matrix of uint8');
pause; disp(' ');

disp('% we can access its pixels as matrix elements');
disp(' ');
disp('img(3:10, 56:64, 2)'); img(3:10, 56:64, 2)
pause; disp(' ');

disp('% to get the size of the image (or any other matrix)');
disp(' ');
disp('size(img)'); size(img)
pause; disp(' ');

disp('% get size along individual dimensions');
disp(' ');
disp('size(img,1)'); size(img,1)
disp('size(img,3)'); size(img,3)
pause; disp(' ');

disp('% longest dimension for a multi-dim array');
disp(' ');
disp('length(img)'); length(img)
pause; disp(' ');

disp('% total number of elements');
disp(' ');
disp('numel(img)'); numel(img)
pause; disp(' ');

disp('% show the image and set title for the figure');
disp(' ');
disp('imshow(img)'); imshow(img)
disp('title(''lena'')'); title('lena')
pause; disp(' ');

disp('% save image in different formats, just by specify an extension');
disp(' ');
disp('imwrite(img, ''lena.png'');'); imwrite(img, 'lena.png');
pause; disp(' ');

disp('% convert color (RGB) image to gray scale img');
disp(' ');
disp('gray = rgb2gray(img);'); gray = rgb2gray(img);
disp('imshow(gray)'); imshow(gray)
pause; disp(' ');

disp('% resize the image');
disp(' ');
disp('small = imresize(img, 0.6);'); small = imresize(img, 0.6);
disp('imshow(small)'); imshow(small)
pause; disp(' ');

disp('% edge detection, only applies to binary or grayscale images');
disp(' ');
disp('edgemap = edge(gray);'); edgemap = edge(gray);
disp('imshow(edgemap)'); imshow(edgemap)
pause; disp(' ');

disp('% the edgemap is a very sparse matrix, with ones for edge pixels');
disp(' ');
disp('edgemap(160:170, 116:122)'); edgemap(160:170, 116:122)
pause; disp(' ');

disp('% EXAMPLE TASK 1 : for each edge pixel, do something interesting');
pause; disp(' ');

disp('% EXAMPLE TASK 1, PROGRAM 1');
disp('% flow control statements such as for, while, do, if, elseif, else');
disp('% can be used similarly as in C++, use ''end'' instead of { }');
disp('tic');
disp('for i = 1 : size(edgemap, 1) ');
disp('    for j = 1 : size(edgemap, 2) ');
disp('        if edgemap(i,j) > 0 ');
disp('            % do something interesting');
disp('            count=0;');
disp('            for k=1:10 ');
disp('                count = count+1; ');
disp('            end ');
disp('        end ');
disp('    end');
disp('end');
disp('toc');
pause; disp(' ');

tic
for i = 1 : size(edgemap, 1) 
    for j = 1 : size(edgemap, 2) 
        if edgemap(i,j) > 0
            count=0;
            for k=1:10
                count = count+1;
            end
        end
    end
end
toc
pause; disp(' ');

disp('% use find() to retrive all non-zero elements ');
disp(' ');
disp('[I J] = find(edgemap);'); [I J] = find(edgemap);
pause; disp(' ');

disp('% whos + variable names ');
disp(' ');
disp('whos I J '); whos I J
pause; disp(' ');

disp('% EXAMPLE TASK 1, PROGRAM 2 ');
disp('tic ');
disp('[I J] = find(edgemap); ');
disp('for idx = 1:length(I) ');
disp('    % edgemap(I(idx), J(idx)) is an edge pixel ');
disp('    % do the same thing ');
disp('    count=0; ');
disp('    for k=1:10 ');
disp('        count = count+1; ');
disp('    end ');
disp('end ');
disp('toc ');
pause; disp(' ');

tic
[I J] = find(edgemap);
for idx = 1:length(I)
    count=0;
    for k=1:10
        count = count+1;
    end
end
toc
pause; disp(' ');

disp('% EXAMPLE TASK 2 : add pepper to image');
disp('% (randomly set 10% pixels of the image as green, 10% as red)');
pause; disp(' ');

disp('% EXAMPLE TASK 2, PROGRAM 1');
disp('tic ');
disp('peppered = img; ');
disp('for i = 1 : size(img,1) ');
disp('    for j = 1 : size(img,2) ');
disp('        rd = rand(1,1); ');
disp('        if rd < 0.2 ');
disp('            peppered(i,j,:) = zeros(1,1,3); ');
disp('            if rd < 0.1 ');
disp('                peppered(i,j,2) = 255; ');
disp('            else ');
disp('                peppered(i,j,1) = 255; ');
disp('            end ');
disp('        end ');
disp('    end ');
disp('end ');
disp('toc ');
disp('imshow(peppered);');
pause; disp(' ');

tic
peppered = img;
for i = 1 : size(img,1)
    for j = 1 : size(img,2)
        rd = rand(1,1);
        if rd < 0.2
            peppered(i,j,:) = zeros(1,1,3);
            if rd < 0.1
                peppered(i,j,2) = 255;
            else
                peppered(i,j,1) = 255;
            end
        end 
    end
end
toc
imshow(peppered);
pause; disp(' ');

disp('% EXAMPLE TASK 2, PROGRAM 2');
disp('% do exactly the same thing without ''for'' and ''if''');

disp('tic');
disp('sz = size(img(:,:,1));');
disp('rd = repmat(rand(sz), [1 1 3]);');
disp('green = cat(3, zeros(sz), 255*ones(sz), zeros(sz));');
disp('red = cat(3, 255*ones(sz), zeros(sz), zeros(sz));');
disp('peppered = uint8((rd < 0.1).*green + (rd > 0.9).*red);');
disp('peppered = peppered + uint8((rd >= 0.1).*(rd <= 0.9)).*img;');
disp('toc');
disp('imshow(peppered);');
pause; disp(' ');

tic
sz = size(img(:,:,1));
rd = repmat(rand(sz), [1 1 3]);
green = cat(3, zeros(sz), 255*ones(sz), zeros(sz));
red = cat(3, 255*ones(sz), zeros(sz), zeros(sz));
peppered = uint8((rd < 0.1).*green + (rd > 0.9).*red);
peppered = peppered + uint8((rd >= 0.1).*(rd <= 0.9)).*img;
toc
imshow(peppered);
pause; disp(' ');

disp('% in this program, we use two functions ''repmat'' and ''cat''');
disp('% manipulate matrices to get rid of loops and ''if''s for speed-up');
pause; disp(' ');
disp('% ''repmat'': replicate matrix');
disp(' ');
disp('a = rand(2,2)');a = rand(2,2)
disp('b = repmat(a,[2 3])'); b = repmat(a,[2 3])
pause; disp(' ');

disp('% ''cat'': concatenate matrix');
disp(' ');
disp('a = rand(2,2);');a = rand(2,2);
disp('b = eye(2);'); b = eye(2);
disp('cat(1, a, b) % concatenate along the 1st dim (rows)'); cat(1, a, b)
pause; disp(' ');
disp('cat(2, a, b) % concatenate along the 2nd dim (cols)'); cat(2, a, b)
pause; disp(' ');
disp('cat(3, a, b) % concatenate along the 3rd dim'); cat(3, a, b)
pause; disp(' ');

disp('% pre-allocate space and avoid loops to get speed-up');
pause; disp(' ');

disp('% EXAMPLE TASK 3 : compute log() for 1kx1k numbers');
disp('A = rand(1000,1000);'); A = rand(1000,1000);
pause; disp(' ');

disp('% EXAMPLE TASK 3, PROGRAM 1');
disp('% the matrix grows inside the loop');
disp('tic ');
disp('for i=1:1000 ');
disp('   for j=1:1000 ');
disp('       B(i,j) = log(A(i,j));');
disp('   end ');
disp('end ');
disp('toc ');
pause; disp(' ');

tic
for i=1:1000
   for j=1:1000
       B(i,j) = log(A(i,j));
   end
end
toc
pause; disp(' ');

disp('% EXAMPLE TASK 3, PROGRAM 2');
disp('% pre-allocate the matrix');
disp('tic ');
disp('B = zeros(1000, 1000);');
disp('for i=1:1000 ');
disp('   for j=1:1000 ');
disp('       B(i,j) = log(A(i,j));');
disp('   end ');
disp('end ');
disp('toc ');
pause; disp(' ');

tic
B = zeros(1000, 1000);
for i=1:1000
   for j=1:1000
       B(i,j) = log(A(i,j));
   end
end
toc
pause; disp(' ');

disp('% EXAMPLE TASK 3, PROGRAM 3');
disp('% use matrix computation');
disp('tic ');
disp('B = log(A);');
disp('toc ');
pause; disp(' ');

tic
B = log(A);
toc
pause; disp(' ');

disp('% functions in Matlab can return multiple values/matrices');
pause; disp(' ');

disp('% file : myfunction.m');
disp('-------------------------------------------------------------');
disp('% myfucntion: separate positive and negative part of a matrix');
disp('function [posA negA] = myfunction(A)');
disp(' posA = (A>0).*A;');
disp(' negA = (A<0).*A;');
disp('% you don''t have to worry about the type/shape/size of A');
disp('-------------------------------------------------------------');
pause; disp(' ');

disp('% 4x4 randon matrix');
disp(' ');
disp('M = randn(4,4) '); M = randn(4,4)
pause; disp(' ');

disp('% apply myfunction ');
disp(' ');
disp('[B C] = myfunction(M)'); [B C] = myfunction(M)
pause; disp(' ');

disp(' ');
disp('% save matrix C (omit ''C'' to save all)');
disp(' ');
disp('save mydata C'); save mydata C
pause; disp(' ');

disp('% access shell by prefix ''!''');
disp(' ');
disp('!dir'); !dir
pause; disp(' ');

disp('% another way to check the current directory');
disp(' ');
disp('what'); what
pause; disp(' ');

disp('% delete all variables');
disp(' ');
disp('clear'); clear
pause; disp(' ');

disp('% check the workspace');
disp(' ');
disp('whos'); whos
pause; disp(' ');

disp('% load to get C back');
disp(' ');
disp('load mydata '); load mydata 
pause; disp(' ');

disp('% check the workspace');
disp(' ');
disp('whos'); whos
pause; disp(' ');

disp('% other useful functions in Matlab');
pause; disp(' ');

disp('% use the 3x3 magic matrix as an example');
disp(' ');
disp('a = magic(3)'); a = magic(3)
pause; disp(' ');

disp('% sum along dim 1 (rows)');
disp(' ');
disp('sum(a,1)'); sum(a,1)
pause; disp(' ');

disp('% sum along dim 2 (cols)');
disp(' ');
disp('sum(a,2)'); sum(a,2)
pause; disp(' ');

disp('% trace of matrix');
disp(' ');
disp('trace(a)'); trace(a)
pause; disp(' ');

disp('% determinant of matrix');
disp(' ');
disp('det(a)'); det(a)
pause; disp(' ');

disp('% matrix inversion');
disp(' ');
disp('inv(a)'); inv(a)
pause; disp(' ');

disp('% eigen values and eigen vectors');
disp(' ');
disp('[V, D] = eig(a)'); [V, D] = eig(a)
pause; disp(' ');

disp('% append a row, (you can also use ''cat'')');
disp(' ');
disp('a = [a; [-1 -2 -3]]'); a = [a; [-1 -2 -3]]
pause; disp(' ');

disp('% reshape to a 2x8 matrix');
disp(' ');
disp('b = reshape(a, 2, 6)'); b = reshape(a, 2, 6)   
pause; disp(' ');

disp('% reshape to a row vector');
disp(' ');
disp('b = a(:)'' ');  b = a(:)'
pause; disp(' ');

disp('% compute mean and median and put in a column vector');
disp(' ');
disp('[mean(b); median(b)]'); [mean(b); median(b)]
pause; disp(' ');

disp('% find the max element, ( yes, you also have min() )');
disp(' ');
disp('[max_value, max_index] = max(b)'); [max_value, max_index] = max(b)
pause; disp(' ');

disp('% plotting in matlab');
pause; disp(' ');

disp('% values for x in [0, 2*pi], with step size 0.1');
disp('x = 0:0.1:2*pi; '); x = 0:0.1:2*pi; 
disp('% function applies element-wise to x ');
disp('y1 = sin(x); '); y1 = sin(x);
disp('y2 = cos(x); '); y2 = cos(x);
pause; disp(' ');

figure
disp('% plot the sin curve in solid line, blue, mark with o ');
disp('plot(x, y1, ''-ob''); '); plot(x, y1, '-ob');
pause; disp(' ');

disp('% hold the figure to put the next plot in the same figure');
disp('hold'); hold
disp('% plot the cos curve in dash line, red, mark with x ');
disp('plot(x, y2, ''-.xr'');  '); plot(x, y2, '-.xr');
pause; disp(' ');

disp('% do some decoration');
disp('xlabel(''eks'') '); xlabel('eks')
disp('ylabel(''why'') '); ylabel('why')
disp('legend(''sin'',''cos'');'); legend('sin','cos'); 
disp('title(''sin and cos from zero to 2pi''); ');
title('sin and cos from zero to 2pi'); 
pause; disp(' ');

disp('% show grids');
disp(' ');
disp('grid'); grid
pause; disp(' ');

clear
disp('% values in a square');
disp(' ');
disp('[X Y] = meshgrid(-1.1:0.1:1.1);'); [X Y] = meshgrid(-1.1:0.1:1.1);
disp('whos '); whos
pause; disp(' ');

disp('% a squiz into these two matrices');
disp(' ');
disp('X(1:5, 1:5)'); X(1:5, 1:5)
disp('Y(1:5, 1:5)'); Y(1:5, 1:5)
pause; disp(' ');

disp('% the operators and functions apply element-wise to get Z ');
disp('Z = -sin(X.^2 + Y.^2);'); Z = -sin(X.^2 + Y.^2); 
pause; disp(' ');

figure
disp('% draw a beautiful hat ');
disp('surf(X,Y,Z)'); surf(X,Y,Z)
pause; disp(' ');

disp('% draw a box on image (to indicate object detection result)');
disp('% say, our face detection algorithm returns a face at:');
disp('% upperleft corner (235, 235), 130 pixels X 140 pixels');
figure
imshow('image.jpg');
pause; disp(' ');

disp('hold ');
disp('x = 235 ');
disp('y = 235 ');
disp('width = 130 ');
disp('height = 140 ');
disp('% use ... to separte statement into multiple lines');
disp('plot([ x x x+width x+width; x x+width x x+width], ... ');
disp('    [ y y y+height y+height; y+height y y+height y], ... ');
disp('    ''LineWidth'',3,''color'',''green''); ');
pause; disp(' ');

hold
x = 235; 
y = 235;
width = 130;
height = 140;
plot([ x x x+width x+width; x x+width x x+width], ...
    [ y y y+height y+height; y+height y y+height y], ...
    'LineWidth',3,'color','green');

pause; disp(' ');

disp('% sample 10,000 points from N(3, 0.5) ');
disp('pts = (randn(1,10000)*0.5+3); '); pts = (randn(1,10000)*0.5+3);
pause; disp(' ');

figure
disp('% histogram for the points');
disp('hist(pts)'); hist(pts)
pause; disp(' ');

disp('% build a new figure for subsequent plot(s)');
disp('figure '); figure
disp('% use customized bins (give a vec of centers for each bin)');
disp('hist(pts, 0.5:1:5.5)'); hist(pts, 0.5:1:5.5)
pause; disp(' ');

disp('% sampled points from 2D Gaussian around the origin');
disp(' ');
disp('pts = randn(1000,2);'); pts = randn(2000,2);
pause; disp(' ');

figure
disp('% draw the points');
disp(' ');
disp('scatter(pts(:,1),pts(:,2),''x'');'); scatter(pts(:,1),pts(:,2),'x');
pause; disp(' ');

figure
disp('% another example that might be useful it you plan to write papers');
disp('Y = [99 22 11 9;');
disp('     85 23 22 12;');
disp('     83 12 16 5;');
disp('     92 17 15 14;');
disp('     80 24 10 20];');
disp('bar(Y)');
disp('legend(''Our algorithm'', ''Tim''''s algorithm'', ...');
disp('    ''Tom''''s algorithm'', ''Jim''''s algorithm'')');
disp('xlabel(''Tasks'');');
disp('ylabel(''Performance'');');
disp('title(''Experiment Results'');');
disp('axis([0.5 5.5 0 130]);');

Y = [99 22 11 9;
     85 23 22 12;
     83 12 16 5;
     92 17 15 14;
     80 24 10 20];
bar(Y)
legend('Our algorithm', 'Tim''s algorithm', ...
    'Tom''s algorithm', 'Jim''s algorithm')
xlabel('Tasks');
ylabel('Performance');
title('Experiment Results');
axis([0.5 5.5 0 130]);
pause; disp(' ');

disp('% structure arrays (similar to ''struct'' in c++)');
pause; disp(' ');

disp('% an empty structure array with 3 fields ');
disp('student = struct(''name'', {}, ''ID'', {}, ''age'', {}); ');
student = struct('name', {}, 'ID', {}, 'age', {});
pause; disp(' ');

disp('% add 3 students ');
disp('student(1).name = ''Jim''; '); student(1).name = 'Jim';
disp('student(1).ID = 1234; '); student(1).ID = 1234;
disp('student(1).age = 15; '); student(1).age = 15;
disp(' ');
disp('student(2) = struct(''name'', ''Tom'', ''ID'', 1235, ''age'', 14);');
student(2) = struct('name', 'Tom', 'ID', 1235, 'age', 14);
disp(' ');
disp('student(3) = struct(''name'', ''Tim'', ''ID'', 1236, ''age'', 14);');
student(3) = struct('name', 'Tim', 'ID', 1236, 'age', 14);
pause; disp(' ');

disp('% compute their average age ');
disp(' ');
disp('mean([student.age])'); mean([student.age])
pause; disp(' ');

disp('% cell arrays (put different things in an array)');
pause; disp(' ');

disp(' % use braces ''{'' ''}'' for cell arrays ');
disp('A= {rand(2,2,2), ''CS228'', 2011};'); A={rand(2,2,2),'CS228',2011};
pause; disp(' ');

figure
disp('% this is what the cell array looks like ');
disp('cellplot(A) '); cellplot(A)
pause; disp(' ');

disp('% braces to index cell array, parenthesis to index standard array');
disp('A{1}(2,:,1) % 2nd row in the 1st layer of the cube'); A{1}(2,:,1)
pause; disp(' ');

disp('% you can also define cell arrays be specifying elements 1-by-1 ');
disp(' ');
disp('% 3x3 diagnal matrix ');
disp('B{1,1}=diag([1 2 3]); '); B{1,1}=diag([1 2 3]);
disp('% concatenate strings vertically ');
disp('B{1,2}=strvcat(''Introduction'',''to'',''Computer'',''Vision'');');
B{1,2} = strvcat('Introduction','to','Computer','Vision');
disp('% we can even have nested cell arrays (omit semicolon for output)');
disp('B{2,2} = A '); B{2,2} = A
pause; disp(' ');

disp('% this is what the cell array B looks like ');
disp('cellplot(B) '); cellplot(B)
pause; disp(' ');

disp('% why would somebody want put different things in an array ?');
disp('% here is a serious example, image pyramid');
pause; disp(' ');
clear

disp('% let''s get lena back ');
disp(' ');
disp('img0 = imread(''lena.png'');'); img0 = imread('lena.png');
pause; disp(' ');

disp('% build the image pyramid');
disp('img1 = impyramid(img0,''reduce'');'); img1=impyramid(img0,'reduce');
disp('img2 = impyramid(img1,''reduce'');'); img2=impyramid(img1,'reduce');
disp('img3 = impyramid(img2,''reduce'');'); img3=impyramid(img2,'reduce');
disp('img4 = impyramid(img3,''reduce'');'); img4=impyramid(img3,'reduce');
pause; disp(' ');

disp('% the image pyramid is a very important data structure for ');
disp('% multi-scale computation in computer vision');
disp('whos'); whos
pause; disp(' ');

disp('% use a cell array to hold image of different sizes');
disp(' ');
disp('pyramid = {img0, img1, img2, img3, img4};');
pyramid = {img0, img1, img2, img3, img4};
pause; disp(' ');

disp('Thanks!');

