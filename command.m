function u = command(t, state, P, R, G)
[z_s, dot_z_s, z_u, dot_z_u] = extractState(state);

z = R.z(t,P);
z_r = z.v;
dot_z_r = z.d1;
dot_dot_z_r = z.d2;

sp_r = Spr(t,state,P,R);

e_0 = P.m_u .* z_u + P.m_s .* z_s - sp_r.v;
e_1 = P.m_u .* dot_z_u + P.m_s .* dot_z_s - sp_r.d1;
e_2 = - P.k_t .* (z_u - z_r) - sp_r.d2;
e_3 = - P.k_t .* (dot_z_u - dot_z_r) - sp_r.d3;
v = sp_r.d4 - G.lambda_0 .* e_0 - G.lambda_1 .* e_1 - G.lambda_2 .* e_2 - G.lambda_3 .* e_3;

T_v = P.m_u .* v ./ P.k_t;
T_s = P.k_s .* (z_s-z_u);
T_t = P.k_t .* (z_u-z_r);
F_f = P.C_f .* tanh(P.gamma_f .* dot_z_s);
T_r = P.m_u .* dot_dot_z_r;

delta = (dot_z_s - dot_z_u).^2;
% u = ( -T_v - T_s + T_t - F_f + T_r);

filter = delta > P.eps;
filterPos = (dot_z_s - dot_z_u) > 0;
filterNeg = 1-filterPos;
filterEps = filterPos - filterNeg;

% u = ( -T_v + T_r - T_s + T_t - F_f) ./ (filter .* (dot_z_s - dot_z_u) + (1-filter) .* (filterEps .* P.eps));
u = filter .* ( -T_v + T_r - T_s + T_t - F_f);

% u=(dot_z_s-dot_z_u); % command constant
end
