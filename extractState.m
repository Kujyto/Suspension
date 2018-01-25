function [z_s, dot_z_s, z_u, dot_z_u] = extractState(state)
  z_s = state(1);
  dot_z_s = state(2);
  z_u = state(3);
  dot_z_u = state(4);
end
