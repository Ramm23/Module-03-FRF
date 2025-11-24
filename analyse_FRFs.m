clc
clear
close all


rect_rand_file = "measurements_12_11_2025\4096_rect_random_4096_13_51_30__G10.mat";
rect_pseudo_synch_file = "measurements_12_11_2025\4096_rect_pseudo_4096_13_55_26__G10.mat";

rect_pseudo_asynch_1024_file = "measurements_12_11_2025\4096_rect_pseudo_1024_13_56_52__G10.mat";
rect_pseudo_asynch_8192_file = "measurements_12_11_2025\4096_rect_pseudo_8192_13_56_26__G10.mat";
rect_pseudo_asynch_32768_file = "measurements_12_11_2025\4096_rect_pseudo_32768_13_58_31__G10.mat";


rect_rand = load(rect_rand_file);
rect_pseudo_synch = load(rect_pseudo_synch_file);

rect_pseudo_asynch_1024 = load(rect_pseudo_asynch_1024_file);
rect_pseudo_asynch_8192 = load(rect_pseudo_asynch_8192_file);
rect_pseudo_asynch_32768 = load(rect_pseudo_asynch_32768_file);

%%Get relevant frequencies
f = rect_rand.f;
freqIndexes = find(f >= 300 & f <= 3000);
f = f(freqIndexes);

%%
%load(hann_psedo_synch_file)

%% Rectangular window
C_rect_rand_ave = getMeanCoherenec(rect_rand.C, freqIndexes)
C_rect_pseudo_ave = getMeanCoherenec(rect_pseudo_synch.C, freqIndexes)

C_rect_pseudo_1024_ave = getMeanCoherenec(rect_pseudo_asynch_1024.C, freqIndexes)
C_rect_pseudo_8192_ave = getMeanCoherenec(rect_pseudo_asynch_8192.C, freqIndexes)
C_rect_pseudo_32678_ave = getMeanCoherenec(rect_pseudo_asynch_32768.C, freqIndexes)



%% Plotting rect window
% Plot H1 and H2 on top of eachother
figure()
loglog(f,abs(rect_rand.H1(freqIndexes)),f,abs(rect_rand.H2(freqIndexes)))
title('Rectangular Window (Random Noise) |H_1| and |H_2|')
xlabel('Freqeuncy (Hz)')
ylabel('Magnitude')
legend('|H_1|','|H_2|')

% Plot H1 and H2 on top of eachother
figure()
loglog(f,abs(rect_pseudo_synch.H1(freqIndexes)),f,abs(rect_pseudo_synch.H2(freqIndexes)))
title('Rectangular Window (Pseudo-random Synchronized Noise) |H_1| and |H_2|')
legend('|H_1|','|H_2|')
xlabel('Freqeuncy (Hz)')
ylabel('Magnitude')

%Plot H! on top of eachother
figure()
loglog(f,abs(rect_rand.H1(freqIndexes)),f,abs(rect_pseudo_synch.H1(freqIndexes)))
title('Rectangular Window, |H_1|')
legend('Random Noise','Pseudo-random Synchronized Noise')
xlabel('Freqeuncy (Hz)')
ylabel('Magnitude')

%Plot H2 on top of eachother
figure()
loglog(f,abs(rect_rand.H2(freqIndexes)),f,abs(rect_pseudo_synch.H2(freqIndexes)))
title('Rectangular Window, |H_2|')
legend('Random Noise','Pseudo-random Synchronized Noise')
xlabel('Freqeuncy (Hz)')
ylabel('Magnitude')

%Plot C on top of eachother
figure()
hold on
semilogx(f,rect_rand.C(freqIndexes))
semilogx(f,rect_pseudo_synch.C(freqIndexes))
legend('Random Noise','Pseudo-random Synchronized Noise')
xlabel('Freqeuncy (Hz)')
ylabel('Ratio')
title('Coherence')
hold off


%% Calculate mean and variance for coherencer in range

