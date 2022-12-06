% Add the speech2text folder to MATLAB search path and save it for future
% MATLAB sessions. Also, install speech2text algorithm for Audio Labeler
% app for MATLAB releases R2019b through R2022b.

%   Copyright 2019-2022 The MathWorks, Inc.

% Add speech2text folder to MATLAB path.
setupFilePath = fileparts(mfilename('fullpath'));
speech2textFilePath = fileparts(setupFilePath);
addpath(speech2textFilePath);
savepath

% Set up speech2text automation algorithm in Audio Labeler app for MATLAB
% releases R2019b through R2022b. Starting in R2022a, Signal Labeler is the
% recommended app to perform both interactive and automatic labeling of
% audio signals.
if ~isempty(ver('audio')) && ~verLessThan('audio','2.1') && verLessThan('audio','3.4')
    % If Audio Labeler is already open, it needs to be restarted for the
    % automation algorithm to show up.
    registry = audio.labeler.automation.AutomationAlgorithmRegistry.getInstance;
    registry.addAlgorithm('SpeechToTextAutomation');
end
