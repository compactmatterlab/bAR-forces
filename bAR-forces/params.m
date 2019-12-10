ks0 = 5.2e-4; % slip koff in seconds
kc0 = 55; % catch koff in seconds
ms = 1e-3; % seconds to miliseconds conversion
ks0 = ks0 * ms; % slip koff in miliseconds
kc0 = kc0 * ms;% catch koff in miliseconds
k_on = 1e5; % integrin kon in seconds
epsilon = 0.74; % value for dissociation probability
k_on = k_on*ms; % integrin kon in miliseconds
actlen = 300; % actin length in nm
nactin = 1; % number of actin filaments for future versions
nmotors = 32; % number of myosin heads
realtime = 30; % realtime simulation in seconds
realtime = realtime*1000;% convert to  ms
n12=zeros(nactin,1); % count of 1 to 2 transitions per run
delta_t = 1;% time step size in ms
tao = 1; % previous time stamp
k12 = 0.00014;% in ms, rate of transition from state 1 to state 2, 
k23 = 0.007;% in ms, rate of transition from state 2 to state 3
k32 = 0.011;% in ms, rate of transition from state 3 to state 2
k34 = 0.00016;% in ms, rate of transition from state 3 to state 4
k41 = 0.028;% in ms, rate of transition from state 4 to state 1
ATP = 1; % ATP concentration in microM
% lamda = 1; % probability that the actin filament is open 
km = 4; % pN/nm, stiffness of motor stalk
F = 0; % applied force in pN
t = 0; % time ms
y = 5.3; % myosin step size nm
bsd = 2.7;  % binding site distance on actin nm
toler = 1.017;%brownian motion in nm
N = zeros(nactin,1);% count of state 1 + state 4
nn = zeros(nactin,1); % count of state 1 + state 4 + state 3
kb = 1.3806e-2;  % Boltzman Constant (J/K)
T = 300;% Kelvin
kbT = kb*T; %
mu = 14.3; % myosin spacing (nm)
sigma = 0; % standard deviation
% in pN.ms/nm
drag = 6*10^-4; % pN*ms/nm
k_spring_vals = [0.1 1 10 100 1000]; % substrate stiffness kPa 
k_spring = k_spring_vals(5); % choose value for substrate stiffness
runtime = realtime/delta_t; % unitless
myo_pos = zeros(nmotors,nactin,1); % zero matrix for myosin position matrix
steps = zeros(nmotors,nactin,1);% matrix of zeros to record number of steps (full cycle) for each motor
change = zeros(nmotors,nactin,1);% matrix of zeros to record number of state changes for each motor
tao = ones(nmotors,nactin);% matrix of ones for previous time stamp
% matrix of twos for cycle start point set 50 percent of motors to be in 2, 50% in 1.5
state = ones(nmotors,nactin)*15;     
init_on_motors = randperm(nmotors)';
state(init_on_motors(1:ceil(0.5*nmotors)),:)=2;
a= state';
[m,nn] = size(a) ;
b = a ;
for i = 1:m
    idx = randperm(nn);
    b(i,idx) = a(i,:);
end
state = b';
clear a b i idx
prev_state = state; % previous state of motor
delta = zeros(runtime,nactin,1); % total distance each motor moved for the given runtime
xx = zeros(runtime,nactin,1);% distance the motor moved at a specific time point
strain = zeros(nmotors,nactin,1); % strain created by attached motors
% experimental ratios
%     veh      0.1       1         10       100      1000
%     WB(1)    WB(2)     WB(3)     WB(4)    WB(5)    WB(6)
WB = [0.112881 0.2124537 0.3221689 1.246547 1.464541 2.860933];
WBratio = WB(1);% select which ratio to use
ks152 = .01;% phosphorylated to dephosphorylated
k215 = (WBratio^-1)*ks152;% dephosporylated to phosphorylated  
attch = zeros(t,1);
delta = zeros(t,1);
Force = zeros(t,1);
kctch = zeros(t,1);
koff = zeros(t,1);
kslip = zeros(t,1);
n34 = zeros(t,1);
pprob = zeros(t,1);
prob_attch = zeros(t,1);
state1 = zeros(t,1);
state2 = zeros(t,1);
state3 = zeros(t,1);
state4 = zeros (t,1);
xx = zeros(t,1);


