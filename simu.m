clear;

                                % parameters
%% sprung mass
P.m_s = 282;
%% unsprung mass
P.m_u = 45;
%% spring stiffness
P.k_s = 17900;
%% tire stiffness
P.k_t = 165790;

%% TODO: réglage
P.C_f = 200;
P.gamma_f = 20;

P.z_u_0 = 0;
P.z_s_0 = 0;
P.J = 1; % jerk max
P.eps = 1e-3;

                                % référence
R.z = @zRef;

                                % state = [z_s, z_s', z_u, z_u']
initState = [P.z_s_0, 0, P.z_u_0, 0];                  

                                % gains
g = 15;
g1 = g;
g2 = g;
g3 = g;
g4 = g;
G.lambda_0 = g1 * g2 * g3 * g4;
G.lambda_1 = g1 * g2 * (g3 + g4) + g3 * g4 * (g1 + g2);
G.lambda_2 = g1 * g2 + g3 * g4 + (g1 + g2) * (g3 + g4);
G.lambda_3 = g1 + g2 + g3 + g4;

                                % options
options = odeset('RelTol', 1e-3, 'AbsTol', 1e-5);

[t,state] = ode23tb(@dynamic, [0,40], initState, options, P, R, G);

subplot(4,1,1);
plot(t,state(:,1));
subplot(4,1,2);
plot(t,state(:,3));
subplot(4,1,3);
plot(t,(P.m_u.*state(:,3) + P.m_s.*state(:,1)) / (P.m_u + P.m_s));
subplot(4,1,4);
z = R.z(t);
plot(t,z.v);

% %% DEBUG zRef
% t = [0:0.01:50];
% z = zRef(t);
% figure;
% plot(t,z.v);
% figure;
% plot(t,z.d1);
% figure;
% plot(t,z.d2);
% figure;
% plot(t,z.d3);
% figure;
% plot(t,z.d4);
% figure;
% plot(t,z.d5);
