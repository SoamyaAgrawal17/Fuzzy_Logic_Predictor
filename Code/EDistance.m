function [ x ] = EDistance(wj, aqj, abj)

x=0;
for k=1:10
    if( and( ne(5,k), ne(10,k) ) )
    x=x+wj(k)*(aqj(k)-abj(k))*(aqj(k)-abj(k));
    disp(x);
    end
end

x=x/8;
x=sqrt(x);

end