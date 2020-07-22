%{
s=11;

A = zeros(s+2,s+2);

for i=1:100
    [x,y] = randomLinedd(10, s,s);
    A(y+1,x+1) = A(y+1,x+1) + 1;
    i
end
%}

%{
s=1000;
a=zeros(1,s);
for i=1:1:s
    a(i)=normrnd(0,20);
end
%}

s=50
a=zeros(1,s);
for n=1:250
    for i=1:1:s
        tic
        randomLinedd(i,100,100);
        a(i) = toc/s;
    end
    plot(a)
end