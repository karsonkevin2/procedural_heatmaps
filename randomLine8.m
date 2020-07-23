function [trace,x,y] = randomLine8(weight, sizeX, sizeY, varargin)

%Creates a random line
%
%EXAMPLES:
%   trace = randomLine8(0.5, 100, 100);
%   trace = randomLine8([0.15,0.6,0.15;0.05,0,0.05;0,0,0], 100, 100);
%   trace = randomLine8(0.5, 100, 100, 'x',30, 'y',70, 'dir',45, 'intersect',0);
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
%   sizeX - [1,infinity) the size of the x dimension
%   sizeY - [1,infinity) the size of the y dimension
%
%   varargin - a list of comma separated variables
%       'intersect' - {0,1} - specifies whether self intersection is
%           allowed
%       'x' - [1,sizeX] - x seed for the line
%       'y' - [1,sizeY] - y seed for the line
%       'dir' - {0,45,90,135,...,315} - seeds the direction of the line
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



intersect = 1;
x=ceil(sizeX/2);
y=ceil(sizeY/2);
dir=-1;

if 4*2 < nargin-3
    error('too many arguments')
end
if 1 < nargin
    
    n = 1;
    while n < nargin - 3
        if strcmp(varargin(n), 'intersect') 
            intersect = cell2mat(varargin(n+1));
            if ~(intersect == 0 || intersect == 1)
                error('intersect must be either 0 or 1')
            end
        elseif strcmp(varargin(n), 'x')
            x = cell2mat(varargin(n+1));
            if x < 1
                error('x must be 0<')
            end
            if sizeX < x
                error('x falls outside image size')
            end
            if rem(x,1) ~= 0 
                error('x must be a whole number')
            end
        elseif strcmp(varargin(n), 'y')
            y = cell2mat(varargin(n+1));
            if y < 1
                error('y must be 0<')
            end
            if sizeY < y
                error('y falls outside image size')
            end
            if rem(y,1) ~= 0 
                error('y must be a whole number')
            end
        elseif strcmp(varargin(n), 'dir')
            dir = cell2mat(varargin(n+1));
            if ~(dir==0 || dir==45 || dir==90 || dir==135 || dir==180 || dir==225 || dir==270 || dir==315)
                error('specify dir as a 45 degree bicardinal direction')
            end
        end
        
        n = n+2;
    end
end
   
copyX = x;
copyY = y;
copyDir = dir;

    
if isequal(size(weight),[1,1])
    if weight < 0 || 1 < weight
        error('Weight must be between [0,1]')
    end
    
    min = (1 - weight) / 2;
    max = 1 - min;

    valid = false;
    while valid == false
        valid = true;
        
        x = copyX;
        y = copyY;
        
        if dir == -1
            dirX=round(rand*3-1.5);
            dirY=round(rand*3-1.5);
            while dirX==0 && dirY==0
                dirX=round(rand*3-1.5);
                dirY=round(rand*3-1.5);
            end
        else
            if dir==0 || dir==45 || dir==315
                dirX = 1;
            elseif dir==90 || dir==270
                dirX = 0;
            else 
                dirX = -1;
            end
            if dir==0 || dir==180
                dirY = 0;
            elseif dir==45 || dir==90 || dir==135
                dirY = -1;
            else 
                dirY = 1;
            end
        end

        trace = zeros(sizeY, sizeX);

        while x~=0 && x~=sizeX+1 && y~=0 && y~=sizeY+1
            %[x,y]
            r = rand;

            if intersect == 0 && trace(y,x) == 1
                valid = false;
                break
            end
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
    
    
    
    valid = false;
    while valid == false
        valid = true;
        
        x = copyX;
        y = copyY;
    
        if copyDir == -1
            dir = round(rand*9 - 4.5)*45;
        else
            dir = copyDir;
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

            if trace(y,x) == 1
                valid = false;
                break
            end
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
    end
    
else
    error('Enter a number or a 3x3 matrix')
end

end

