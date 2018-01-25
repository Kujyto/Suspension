function z = Spr(t, state, P, R)
    [z_s, dot_z_s, z_u, dot_z_u] = extractState(state);

    z_r = R.z(t);
    
    
    z.v = (P.m_u + P.m_s) .* z_r.v;
    z.d1 = (P.m_u + P.m_s) .* z_r.d1;
    z.d2 = (P.m_u + P.m_s) .* z_r.d2;
    z.d3 = (P.m_u + P.m_s) .* z_r.d3;
    z.d4 = (P.m_u + P.m_s) .* z_r.d4;
    z.d5 = (P.m_u + P.m_s) .* z_r.d5;
end