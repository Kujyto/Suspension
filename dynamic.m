function eq = dynamic(t, state, P, R, G)
    disp(t);
  [z_s, dot_z_s, z_u, dot_z_u] = extractState(state);

  u = command(t,state,P,R,G); % u = u * (z_s' - z_u')

  F_f = P.C_f .* tanh(P.gamma_f .* dot_z_s);

  z = R.z(t);
  z_r = z.v;
  
  %% z_s'
  eq(1) = dot_z_s;
  %% z_s''
  eq(2) = (1 ./ P.m_s) .* (-F_f - P.k_s .* (z_s - z_u) - u);

  %% z_u'
  eq(3) = dot_z_u;
  %% z_u''
  eq(4) = (1 ./ P.m_u) .* (F_f + u .* (dot_z_s - dot_z_u) + P.k_s .* (z_s - z_u) - P.k_t .* (z_u - z_r));

  eq = eq';
end
