classdef audioUtility
    properties
        fs             % Sampling frequency
        channelsPlay   % Channels for playback
        channelsRec    % Channels for recording
        player         % audioplayer object
        recorder       % audiorecorder object
    end
    
    methods
        function obj = audioUtility(varargin)
            % Constructor to initialize playback and recording properties
            p = inputParser;
            addParameter(p, 'channelsPlay', 1);
            addParameter(p, 'channelsRec', [1 2]);
            addParameter(p, 'fs', 44100);
            parse(p, varargin{:});
            
            obj.fs = p.Results.fs;
            obj.channelsPlay = p.Results.channelsPlay;
            obj.channelsRec = p.Results.channelsRec;
            
            % Initialize audiorecorder with specified sampling frequency and number of channels
            obj.recorder = audiorecorder(obj.fs, 16, length(obj.channelsRec));
        end
        
        function y = playrec(obj, x)
            % Play and record simultaneously
            obj.player = audioplayer(x, obj.fs);  % Initialize audioplayer
            
            % Start recording and playback
            record(obj.recorder); % Start recording
            play(obj.player);     % Start playback
            
            % Wait for playback to finish
            pause(length(x) / obj.fs);
            
            % Stop recording and retrieve recorded data
            stop(obj.recorder);
            y = getaudiodata(obj.recorder);
            
            % Reshape to match the number of recorded channels
            y = reshape(y, [], length(obj.channelsRec));
        end
    end
end