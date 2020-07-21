function [x,y] = randomLine8Arr(weight, sizeX, sizeY)

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

x=ceil(sizeX/2);
y=ceil(sizeY/2);

dirX=round(rand*3-1.5);
dirY=round(rand*3-1.5);
while dirX==0 && dirY==0
    dirX=round(rand*3-1.5);
    dirY=round(rand*3-1.5);
end

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
        dirX = -1;
        dirY = -1;
    elseif r<b
        dirX = 0;
        dirY = -1;
    elseif r<c
        dirX = 1;
        dirY = -1;
    elseif r<d
        dirX = -1;
        dirY = 0;
    elseif r<m
        dirX = 0;
        dirY = 0;
    elseif r<e
        dirX = 1;
        dirY = 0;
    elseif r<f
        dirX = -1;
        dirY = 1;
    elseif r<g
        dirX = 0;
        dirY = 1;
    elseif r<h
        dirX = 1;
        dirY = 1;
    end
    
    x = x + dirX;
    y = y + dirY;
    
end

imshow(trace);

end

