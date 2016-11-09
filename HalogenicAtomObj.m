function [SSE] = HalogenicAtomObj(time,data,k,y0,order,sulfFlag,ksulf)

    f = @(t,y) HalogenicAtomODE(k,t,y,order,sulfFlag,ksulf);
    [~,state_data] = ode23s(f,time,y0);
    err = data - state_data;
    SSE = sum(err.*err); % sum of squared error
