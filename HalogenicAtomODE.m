function [dy] = HalogenicAtomODE(k,t,y,order,sulfFlag,ksulf)

% 

if sulfFlag == 1,
    if order == 1,
        dy = k(2)*(exp(-k(1)*t) - exp(-ksulf*t)) - k(3)*y;
    else
        dy = k(2)*(exp(-k(1)*t) - exp(-ksulf*t)) - k(3)*y - k(4)*y*y;
    end
else
    if order == 1,
        dy = k(3)*(exp(-k(1)*t) - exp(-k(2)*t)) - k(4)*y;
    else
        dy = k(3)*(exp(-k(1)*t) - exp(-k(2)*t)) - k(4)*y - k(5)*y*y;
    end
end
