%% SISTEMA 2: DUMMY COMERCIAL
%Escola Politécnica da Universidade de São Paulo
%PMR3302 - Sistemas Dinâmicos I para Mecatrônica (2022)
%Autores: Caio Felipe dos Santos Oliveira   NUSP:11808151
%         Gabriel Ranieri Vaz de Lima       NUSP:11804442
%Vamos analisar o modelo proposto para o dummy
%O modelo possui 3 graus de liberdade: o deslocamento longitudinal da massa 1, 
%o deslocamento angular da massa 2 em relação à 1 e o deslocamento angular da massa 3 em relação à 2;
%%

close all; clear all; clc
global k c m L I g Accelhead 

%% Dados de entrada
Nvar=3;   % #variaveis
Nspring=7; % #molas
Ndumper=5; % #amortecedores
k = [2000 , 	58860 , 39240 , 2500, 	2500, 380 , 200 ]; # Rigidez [N/m]
c = [92.57, 501.26, 537.76, 67.87, 23.5]; # Amortecimento [Ns/m]
m = [26.68, 46.06, 5.52];   # Massa [Kg]
L = [0.427, 0.427, 0.240];  # Comprimento das barras delgadas
g = 9.81;   # Aceleração da gravidade [m/s^2]
I=[];   # Momento de inércia calculado no centro de gravidade das massas [Kg m^2]
for Index = 1:Nvar
 I = [ I; m(Index)*(L(Index)**2)/12];
end
% Condições iniciais (i.c.)
Y0 = [0, 0., 0.]; # deslocamento inicial [m]
V0 = [ 13.33,  0, 0]; # velocidade inicial [m/s] - 48 km/h

# Organizando vetor de i.c. para ODE45
y0=[];
for Index=1:Nvar
 y0= [ y0; Y0(Index); V0(Index)];
end

% Tempo de simulação do problema
tspan = 0:0.001:1.4; % intervalo de tempo [s]

%% Solução do problema
options = odeset('OutputFcn',@AccHeadDef,'MaxStep',0.001);
[T,Y] = ode45(@dydt,tspan,y0,options);

% Cálculo do HIC a partir da aceleração da cabeça
HICMAX1 = hicN(Accelhead,15);
disp('O HIC do sistema possui valor de'),disp(HICMAX1);

%% Plot resultados
figure(1)
plot(T, [Y(:,1) Y(:,3) Y(:,5)])
grid
str = {'x1','theta1', 'theta2'};
h=legend(str, 'Location', 'northeast');
set(h,'FontSize',12);
xlabel('Time [s]')
ylabel('Displacement Response')

figure(2)
plot( T,[Y(:,2) Y(:,4) Y(:,6)])
grid
str = {'v_{x1}','v_{theta1}', 'v_{theta2}'};
h=legend(str, 'Location', 'northeast');
set(h,'FontSize',12);
xlabel('Time [s]')
ylabel('Displacement Response')

figure(3)
plot(T,Accelhead)
grid
xlabel('Time [s]')
ylabel('Head Acceleration [g]')
title(['HIC:', num2str(HICMAX1)])