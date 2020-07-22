function [trace,x,y] = randomLinedd(sd, sizeX, sizeY)

valid = false;

%while valid == false
    valid = true;
    
    x=ceil(sizeX/2);
    y=ceil(sizeY/2);

    dir = rand*360;
    
    trace = zeros(sizeY, sizeX);

    while 0.5<x && x<sizeX+1-0.5 && 0.5<y && y<sizeY+1-0.5
        %[x,y]

%       if(trace(round(y),round(x)) == 1)
 %           valid = false;
  %          break
   %     end

        trace(round(y),round(x)) = 1;

        diradd = normrnd(0,sd);

        dir = dir + diradd;
        dir = mod(dir,360);

        x = x + cos(deg2rad(dir));
        y = y + sin(deg2rad(dir));

        %imshow(trace)
    %end
end

x=round(x);
y=round(y);

imshow(trace);

end



