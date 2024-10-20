# For the test datasets in the deposit 
acc1.mat : S01_D3_A013_T01_IP.csv  (sitting down, waist)
acc2.mat :  S01_D3_A101_T01_IP.csv (walking—> stumbling/tripping, waist. Forward fall, no rotation, no recovery)
acc3.mat : S01_D3_A121_T02_IP.csv  (jogging —> stumbling/tripping, waist. Forward fall, no rotation, no recovery)

% In MATLAB, it can be read as follows：
load acc1.mat;  % x, y, z are the Accelerometer signal from x-, y- and z-axis respectively.
Time = [0:1:767]'./238;  

% In MATLAB, it can be processed as follows：
Acc = x; % Taking x as an example.
[fAcc] = accKalman(Acc, 238, 0.0025, 0.1); 

% Observe the result: (this following code has been incorporated in accKalman.m)
figure; 
plot(Time, Acc, Time, fAcc, 'r-.'); 
xlabel('Time (sec)'); ylabel('Accelerometer Signal');
