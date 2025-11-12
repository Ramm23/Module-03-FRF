% Clear stuff
clear variables
clear mex
close all
clc

addpath measurements_12_11_2025



%% LOAD SIGNALS FROM MEASUREMENTS

file_names = strvcat(...
    '8_hann_random_8_13_34_40__G10.mat',...
    '64_hann_random_64_13_34_58__G10.mat',...
    '256_hann_random_256_13_44_40__G10.mat',...
    '512_hann_random_512_13_35_13__G10.mat',...
    '1024_hann_random_1024_13_45_06__G10.mat',...
    '4096_hann_random_4096_13_32_08__G10.mat',...
    '32768_hann_random_32768_13_38_17__G10.mat'...
    );
    

disp(strsplit(file_names(1,:), '_'))


%% PLOTS

for i = 1:size(file_names,1)
    load(file_names(i,:));

    % Strip file extension, then split
    [~, name, ~] = fileparts(file_names(i,:));
    params = strsplit(name, '_');  % now it's a cell array of chars

    figure(i)
    semilogx(f, C)
    title(['Coherence - ' strjoin(params(1:3), ' ')], 'Interpreter', 'none')
    axis([0 fs/2 0 1])
    xlabel('Frequency (Hz)')
    ylabel('Coherence')
    grid on
end



%% H1 AND H2 RATIO PLOT


for i = 1:size(file_names,1)
    load(file_names(i,:));

    % Strip file extension, then split
    [~, name, ~] = fileparts(file_names(i,:));
    params = strsplit(name, '_');  % now it's a cell array of chars

    figure(i)
    loglog(f,abs(H1),f,abs(H2))
    title(['|H_1| and |H_2| - ' strjoin(params(1:3), ' ')], 'Interpreter', 'none')
    legend('|H_1|','|H_2|')
    ax=axis;
    axis([0 fs/2 ax(3) ax(4)])
    grid on
    %axis([500 1000 0 1])
end


%% RAW SIGNALS PLOTTED IN TIME

for i = 1:size(file_names,1)
    load(file_names(i,:));

    % Strip file extension, then split
    [~, name, ~] = fileparts(file_names(i,:));
    params = strsplit(name, '_');  % now it's a cell array of chars

    figure(i)
    plot(t,[x2 y2]')
    title(['Played and Recorded signals in Time - ' strjoin(params(1:3), ' ')], 'Interpreter', 'none')
    legend('Played signal (x)','Recorded signal (y) - F','Recorded signal (y) - a')
    grid on
end