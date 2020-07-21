
s=11;

A = zeros(s+2,s+2);

for i=1:100
    [x,y] = randomLinedd(10, s,s);
    A(y+1,x+1) = A(y+1,x+1) + 1;
    i
end