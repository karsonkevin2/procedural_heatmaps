function [x,y] = randomLine8Arr2(weight, sizeX, sizeY)

%weight 
%{
a b c
d 0 f
g h i
%}

if ~isequal(size(weight),[3,3])
    error('Wrong size array')
end
if sum(weight,'all') < 1-.001 || 1+0.001<sum(weight,'all')
    error('Probabilities must sum to 1')
end
for i=1:3
    for j=1:3
        if weight(j,i) < 0 || 1 < weight(j,i)
            error('Probabilites must be [0,1]')
        end
    end
end
if weight(2,2) ~= 0 
    error('central element must be 0')
end

x=ceil(sizeX/2);
y=ceil(sizeY/2);


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

imshow(trace);

end



