% Matrix Objective

function [SSE] = MatrixObj(time,data,k,dy)

    A = exp(-k(1)*time) - exp(-k(2)*time);
    data2 = data.*data;
    A(:,2) = -data; A(:,3) = -data2;
    vec_solve = A\dy;
    DY = A*vec_solve;
    err = dy - DY;
    SSE = sum(err.*err); % sum of squared error
    assignin('base', 'coeff', vec_solve);
    assignin('base', 'A', A);
    %assignin('base', 'a', size(A));
    %assignin('base', 'b', size(dy));