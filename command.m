function u = command(t, state, P, R, G)
  [z_s, dot_z_s, z_u, dot_z_u] = extractState(state);

  v = 0; % TODO

  z = R.z(t);
  z_r = z.v;
  dot_dot_z_r = z.d2;

  T_v = P.m_u .* v ./ P.k_t;
  T_s = P.k_s .* (z_s-z_u);
  T_t = P.k_t .* (z_u-z_r);
  F_f = P.C_f .* tanh(P.gamma_f .* dot_z_s);
  T_r = P.m_u .* dot_dot_z_r;

  u = ( - T_v - T_s + T_t - F_f + T_r);
end
