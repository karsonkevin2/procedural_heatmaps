function [x,y] = randomLine82(sd, sizeX, sizeY)

%weight

x=ceil(sizeX/2);
y=ceil(sizeY/2);

dir = rand*360;

trace = zeros(sizeY, sizeX);

while x~=0 && x~=sizeX+1 && y~=0 && y~=sizeY+1
    %[x,y]
    
    trace(y,x) = 1;
    
    diradd = normrnd(0,sd);
    
    dir = dir + diradd;
    dir = mod(dir,360)
    
    dir2 = round(dir/45)*45;
    
    if dir2==0 || dir2==360
        x = x + 1;
    elseif dir2==45
        x=x+1;
        y=y-1;
    elseif dir2==90
        y=y-1;
    elseif dir2==135
        x=x-1;
        y=y-1;
    elseif dir2==180
        x=x-1;
    elseif dir2==225
        x=x-1;
        y=y+1;
    elseif dir2==270
        y=y+1;
    elseif dir2==315
        x=x+1;
        y=y+1;
    end
    
end

imshow(trace);

end



