function [trace,x,y] = randomLine8(weight, sizeX, sizeY)

%Creates a random line
%
%INPUT:
%
%   weight - how strong the line will be attracted to different directions,
%       measured relative to the direction of the head
%       
%       As a single number [0,1] the value is the weight of continuing
%       straight versus altering heading by 45. So 0.33 is equal weight to
%       straight and 45, 0 would be only 45, 1 would be only straight. A
%       good value is ~0.5
%
%       As a matrix of the form
%       [a b c
%        d 0 e
%        f g h]
%       These will be the weights for each direction relative to the head, 
%       where the current direction is b. These weights should add to 1
%
%   sizeX - the size of the x dimension
%   sizeY - the size of the y dimension
%
%OUTPUT:
%
%   trace - a bitmap image where the path of the line is marked with 1
%

if sizeX < 1 || sizeY < 1
    error('Dimensions must be a posotive value')
end
if rem(sizeX,1)~=0 || rem(sizeY,1)~=0
    error('Dimensions must be integers')
end

x=ceil(sizeX/2);
y=ceil(sizeY/2);


if isequal(size(weight),[1,1])
    if weight < 0 || 1 < weight
        error('Weight must be between [0,1]')
    end
    
    min = (1 - weight) / 2;
    max = 1 - min;

    dirX=round(rand*3-1.5);
    dirY=round(rand*3-1.5);
    while dirX==0 && dirY==0
        dirX=round(rand*3-1.5);
        dirY=round(rand*3-1.5);
    end

    trace = zeros(sizeY, sizeX);

    while x~=0 && x~=sizeX+1 && y~=0 && y~=sizeY+1
        %[x,y]
        r = rand;

        trace(y,x) = 1;

        if(dirX==1 && dirY==1)
            %1
            if r < min
                dirY = 0;
            elseif max < r
                dirX = 0;        
            end
        elseif(dirX==1 && dirY==0)
            %2
            if r < min
                dirY = -1;
            elseif max < r
                dirY = 1;
            end
        elseif(dirX==1 && dirY==-1)
            %3
            if r < min
                dirX = 0;
            elseif max < r
                dirY = 0;
            end
        elseif(dirX==0 && dirY==1)
            %4
            if r < min
                dirX = 1;
            elseif max < r
                dirX = -1;
            end
        elseif(dirX==0 && dirY==-1)
            %5
            if r < min
                dirX = -1;
            elseif max < r
                dirX = 1;
            end
        elseif(dirX==-1 && dirY==-1)
            %6
            if r < min
                dirY = 0;
            elseif max < r
                dirX = 0;
            end
        elseif(dirX==-1 && dirY==0)
            %7
            if r < min
                dirY = 1;
            elseif max < r
                dirY = -1;
            end
        elseif(dirX==-1 && dirY==1)
            %8
            if r < min
                dirX = 0;
            elseif max < r
                dirY = 0;
            end
        end

        x = x + dirX;
        y = y + dirY;

    end

    
elseif isequal(size(weight),[3,3])   
    if sum(weight,'all') < 1-.001 || 1+0.001<sum(weight,'all')
        error('Probabilities must sum to 1')
    end
    for i=1:3
        for j=1:3
            if weight(j,i) < 0 || 1 < weight(j,i)
                error('Probabilities must be [0,1]')
            end
        end
    end
    if weight(2,2) ~= 0 
        error('central element must be 0')
    end
    
    dir = round(rand*9 - 4.5)*45;

    trace = zeros(sizeY, sizeX);

    a = weight(1,1);
    b = weight(1,2) + a;
    c = weight(1,3) + b;
    d = weight(2,1) + c; 
    m = weight(2,2) + d;
    e = weight(2,3) + m;
    f = weight(3,1) + e;
    g = weight(3,2) + f;
    h = weight(3,3) + g;

    while x~=0 && x~=sizeX+1 && y~=0 && y~=sizeY+1
        %[x,y]
        r = rand;      

        trace(y,x) = 1;

        if r<a
            dir = dir - 45;
        elseif r<b
            dir = dir;
        elseif r<c
            dir = dir + 45;
        elseif r<d
            dir = dir - 90;
        elseif r<e
            dir = dir + 90;
        elseif r<f
            dir = dir - 135;
        elseif r<g
            dir = dir - 180;
        elseif r<h
            dir = dir + 135;
        end

        dir = mod(dir,360);

        if dir==0
            x = x + 1;
        elseif dir==45
            x=x+1;
            y=y-1;
        elseif dir==90
            y=y-1;
        elseif dir==135
            x=x-1;
            y=y-1;
        elseif dir==180
            x=x-1;
        elseif dir==225
            x=x-1;
            y=y+1;
        elseif dir==270
            y=y+1;
        elseif dir==315
            x=x+1;
            y=y+1;
        end

    end
    
    
else
    error('Enter a number or a 3x3 matrix')
end


imshow(trace);  

end

