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

P.st = 1.75; % raideur de z_r
P.h = 0.2; % hauteur de z_r
P.t0 = 20;

P.st_precision = 0.1; % precision sur la raideur de la sortie plate
P.st_min = 0.25;
P.stSp = stiffness(P);
P.t0Sp = P.t0;



% référence
R.z = @zRef;

% state = [z_s, z_s', z_u, z_u']
initState = [P.z_s_0, 0, P.z_u_0, 0];

% gains
g = 30;
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

U = command(t,state,P,R,G);
F_f = P.C_f .* tanh(P.gamma_f .* state(:,2));

jerk = (1 ./ P.m_s) .* (-F_f - P.k_s .* (state(:,1) - state(:,3)) - U);
disp("Jerk max: " + max(abs(jerk)));
disp("z_r stiffness: " + P.st);
disp("Sp stiffness: " + P.stSp);

subplot(5,1,1);
plot(t,state(:,1));
legend("z_s");
subplot(5,1,2);
plot(t, jerk);
legend("z_s'' (jerk passagers)");
subplot(5,1,3);
plot(t,(P.m_u.*state(:,3) + P.m_s.*state(:,1)) / (P.m_u + P.m_s));
legend("S_p");
subplot(5,1,4);
z = R.z(t,P);
plot(t,z.v);
legend("z_r");
subplot(5,1,5);
S = Spr(t,'',P,R);
plot(t,S.v);
legend("Spr");

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

function stSp = stiffness(P)
    a = P.h ./ 2;
    stSp = P.st;
    
    while true
        j = (6 * a * stSp^3 / P.m_s) + (104 * P.m_u * a * stSp^5 / (P.k_t * P.m_s)) + (4 * P.m_u * a * P.st^3 / P.m_s);
        if j <= P.J
            break;
        else
            stSp = stSp - P.st_precision;
            if stSp <= P.st_min
                stSp = P.st_min;
                break;
            end
        end
    end
    
    while true
        j = (4 * a * stSp^3 / P.m_s) + (96 * P.m_u * a * stSp^5 / (P.k_t * P.m_s)) + (6 * P.m_u * a * P.st^3 / P.m_s);
        if j <= P.J
            break;
        else
            stSp = stSp - P.st_precision;
            if stSp <= P.st_min
                stSp = P.st_min;
                break;
            end
        end
    end
end
