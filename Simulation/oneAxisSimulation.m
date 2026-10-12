clear variables; clc; close all;

% Initialize input parameters
fmin = 4000;
vmin = 600;
vmax = 800;

% Compute resulting parameters
UTD = vmin/fmin;
fmax = vmax/UTD;
deltaMax = 5;

% Initialize sample frequency, period and samples number
fs = 4*fmax;
dt = 1/fs;
N = 4*round(1*fs);

% Initialize variables
lastToggleTime = 0;   % Toggle square wave
F = zeros(1, N);      % Current frequency value
time = zeros(1, N);   % time vector
pulses = zeros(1,N);  % Pulses signal sent to SCON 
signs = zeros(1,N);   % Signs signal sent to SCON
pM = zeros(1,N);      % Motor position
pF = zeros(1,N);      % Finger position
currentPM = 0;        % Current motor position

% Run real time loop simulation
for n = 1:N
    % Current time
    time(n) = (n-1)*dt;
    % Finger position simulation
    % 1. Sinus
    % pF(n) = 100*sin(2*pi*0.5*time(n)) + 2*(rand - 0.5);
    % 2. Step
    pF(n) = 0;
    if(time(n) > 1)
        pF(n) = 100;
    end
    % Current motor position
    pM(n) = currentPM;
    % Compute error position
    delta = pF(n) - currentPM;
    % Frequencies lookup table
    if(abs(delta) < deltaMax)
        F(n) = (fmax - fmin) /deltaMax * abs(delta) + fmin;
    else
        F(n) = fmax;
    end
    % Compute signs signal et current time
    signs(n) = sign(delta);
    % If error is less than half UTD, no need to move
    if(abs(delta) < UTD/2.0)
        F(n) = 0;
        signs(n) = 0;
    else
        if(time(n) - lastToggleTime >= 1/F(n))
            % If last toggle time is farther than current period,
            % record current time an move one UTD
            lastToggleTime = time(n);
            currentPM = currentPM + UTD*signs(n);
        end
        % If last toggle time is less than half current period,
        % init current pulse value to one else to zero
        if(time(n) - lastToggleTime <= 0.5/F(n))
            pulses(n) = 1;
        else
            pulses(n) = 0;
        end
    end
    
end

% Plots
plot(time, pM, time, pF);
xlabel 'time (s)';
ylabel 'Amplitude (mm)'
legend 'Motor position' 'Finger position';