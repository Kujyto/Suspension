function z = Spr(t, state, P, R)

st = P.stSp;
h = P.h;
t0 = P.t0Sp;

% z_r = R.z(t,P);
% 
% 
% z.v = (P.m_u + P.m_s) .* z_r.v;
% z.d1 = (P.m_u + P.m_s) .* z_r.d1;
% z.d2 = (P.m_u + P.m_s) .* z_r.d2;
% z.d3 = (P.m_u + P.m_s) .* z_r.d3;
% z.d4 = (P.m_u + P.m_s) .* z_r.d4;
% z.d5 = (P.m_u + P.m_s) .* z_r.d5;

z = tanhTr(t,st,0,h,t0,'');
z.v = (P.m_u + P.m_s) .* z.v;
z.d1 = (P.m_u + P.m_s) .* z.d1;
z.d2 = (P.m_u + P.m_s) .* z.d2;
z.d3 = (P.m_u + P.m_s) .* z.d3;
z.d4 = (P.m_u + P.m_s) .* z.d4;
z.d5 = (P.m_u + P.m_s) .* z.d5;

end

function b = beta(x,n)
b = 0;
for k = 0:(n+1)
    b = b + (-1)^k * nchoosek(n+1,k) * pos(x - k + (n+1)/2,n);
end
end

function y = pos(x,n)
if x < 0
    y = 0;
elseif (x == 0) && (n == 0)
    y = 1/2;
elseif x > 0 && n == 0
    y = 1;
else
    y = x^n;
end
end