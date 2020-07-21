function [x,y] = randomLine8(weight, sizeX, sizeY)

%weight [0,1]

%1: 0,1
%0.5: 0.25,0.75
%0.33: 0.33,0.66

min = (1 - weight) / 2;
max = 1 - min;

x=ceil(sizeX/2);
y=ceil(sizeY/2);

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

imshow(trace);

    
    
    
    

end

