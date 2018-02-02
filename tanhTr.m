function y = tanhTr(t, st, lowVal, highVal, tRaise, plotOrNot)

aR   = (highVal-lowVal)./2;
phi =  tanh(st.*(t-tRaise));

y.v  =  aR .* (1+ phi) + lowVal;
y.d1 =  aR*st.*(1-phi.^2);
y.d2 =  2*aR .* (st^2.*phi.*(1-phi.^2));
y.d3 = -2*aR*st^3.*(1-phi.^2).*(1-3.*phi.^2);
y.d4 =  8*aR*st^4 .* phi.*(3.*phi.^4 - 5.*phi.^2 + 2);
y.d5 = -8*aR*st^5 .* (15.*phi.^6 - 30.*phi.^4 + 17.*phi.^2 - 2);
if (nargin == 6)
    if (strcmp(plotOrNot, 'plot') == 1)
        figure(20); plot(t, y.v, 'r', t, y.d, 'g'); grid;
        figure(21); plot(t, y.d2, 'r', t, y.d3, 'g'); grid;
        figure(22); plot(t, y.d4, 'r', t, y.d5, 'g'); grid;
    end
end
