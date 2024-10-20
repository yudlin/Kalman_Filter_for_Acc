function [fAcc] = accKalman(Acc, fs, w, v)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program is used to aquire the Residual component of accelerometer 
% signal using Kalman filter (an adaptive lowpass filter). 
%                                            By Yue-Der Lin, on 2024/10/20.
%
% Input Parameters:
%       Acc : the accelerometer signal. 
%        fs : the sampling frequency of accelerometer signal (in Hz),
%             which is 238 Hz for FallAllD database. 
%         w : state transition noise. 
%         v : measurement noise.
%
% Output Parameters:  
%      fAcc : the filtered acceleromete signal.
%
% Example for usage:
%    >> load acc1.mat;
%    >> [fAcc] = accKalman(x, 238, 0.0025, 0.1); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check the correctness of parameter 'fs':
while (fs <= 0 || mod(fs,1) ~= 0)
   disp(' ');
   disp('You have a wrong input!');
   disp('The sampling frequency should be a positive integer.');
   fs = input('Your choice is: ');
end

L = length(Acc);
Acc = reshape(Acc, L, 1);
Time = reshape([0 : L-1]./fs, L, 1); 

% Initialization:
H = 1; A = 1; 
Q = w*w; R = v*v; 
x = Acc(1); 
P = 1; 

for k = 1 : length(Acc) 
    % Kalman Filter: 
    zk = Acc(k); 
    % Time update:
    xk = A*x;
    Pk = A*P*A' + Q;
    % Measurement update:
    K = Pk*H'*inv(H*Pk*H' + R);
    x = xk + K*(zk-H*xk); 
    P = Pk-K*H*Pk;
    fAcc(k) = x;
end

% Resgape to a column array and amplitude modification:
fAcc = reshape(fAcc, L, 1);
% fAcc = (fAcc/(max(fAcc)-min(fAcc)))*max(Acc);

% Plot whole figure:
figure; 
plot(Time, Acc, Time, fAcc, 'r-.'); 
xlabel('Time (sec)'); ylabel('Accelerometer Signal');

end  % End of accKalman function.
