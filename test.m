
s=101;

A = zeros(s+2,s+2);

for i=1:100000
    [x,y] = asdf(0.33, s,s);
    A(y+1,x+1) = A(y+1,x+1) + 1;
    i
end