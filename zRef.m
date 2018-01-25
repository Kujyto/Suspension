function z = zRef(t)
  t0 = 3;
  delta = 2;
  st = 2;

  z1 = tanhTr(t,st,0,1,t0-delta,'');
  z2 = tanhTr(t,st,1,0,t0+delta,'');

  F = t < t0;
  z.v = F .* z1.v .+ (1.-F) .* z2.v;
  z.d1 = F .* z1.d1 .+ (1.-F) .* z2.d1;
  z.d2 = F .* z1.d2 .+ (1.-F) .* z2.d2;
  z.d3 = F .* z1.d3 .+ (1.-F) .* z2.d3;
  z.d4 = F .* z1.d4 .+ (1.-F) .* z2.d4;
  z.d5 = F .* z1.d5 .+ (1.-F) .* z2.d5;
  %if t <= t0
  %  z = tanhTr(t,3,0,1,t0-delta,'');
  %else
  %  z = tanhTr(t,3,1,0,t0+delta,'');
  %end

  %z = gammaFunc(t,t0,delta,1);
end