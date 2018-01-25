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

                                % référence
R.z = @zRef;

                                % state = [z_s, z_s', z_u, z_u']
initState = [2, 0, 1, 0];                  

                                % gains
G.lambda_0 = 1;
G.lambda_1 = 4;
G.lambda_2 = 6;
G.lambda_3 = 4;

                                % options
options = [];

[t,state] = ode45(@dynamic, [0,40], initState, options, P, R, G);

%% DEBUG zRef
%t = [0:0.01:10];
%z = zRef(t);
%figure;
%plot(t,z.v);
%figure;
%plot(t,z.d1);
%figure;
%plot(t,z.d2);
%figure;
%plot(t,z.d3);
%figure;
%plot(t,z.d4);
%figure;
%plot(t,z.d5);
