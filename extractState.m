function [z_s, dot_z_s, z_u, dot_z_u] = extractState(state)
if(size(state,1) == 4)
    z_s = state(1);
    dot_z_s = state(2);
    z_u = state(3);
    dot_z_u = state(4);
else
    z_s = state(:,1);
    dot_z_s = state(:,2);
    z_u = state(:,3);
    dot_z_u = state(:,4);
end
end
