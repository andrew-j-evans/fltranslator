%speechClient Interface with pretrained model or 3rd-party speech service
%
%   clientObj = speechClient(apiName) creates a speechClient object to
%   interface with a pretrained wav2vec 2.0 model or 3rd-party cloud-based
%   speech service specified by apiName. Valid API names are 'wav2vec2.0',
%   'Google', 'IBM', 'Microsoft', and 'Amazon'.
%
%   The wav2vec model requires R2022b or later.
%
%   clientObj = speechClient(apiName,'Name',Value) specifies nondefault
%   client properties and server options.
%
%   The client properties depend on the API name.
%
%   'wav2vec2.0' Properties:
%   Segmentation - Segmentation of transcription ('word' or 'none')
%   TimeStamps   - Output time stamps of transcribed speech (false or true)
%
%   'Google', 'IBM', and 'Microsoft' Properties:
%   TimeOut - Connection timeout, specified as a scalar in seconds
%
%   'Amazon' Properties:
%   TimeOut      - Connection timeout, specified as a scalar in seconds
%   Segmentation - Segmentation of transcription ('word','sentence', or
%                  'none'). This property is only relevant for speech2text.
%   TimeStamps   - Output time stamps of transcribed speech (false or
%                  true). This property is only relevant for speech2text.
% 
%   For cloud-based APIs ('Google','IBM','Microsoft', and 'Amazon'), you
%   can set server-specific options using setOptions with comma separated
%   name-value pairs. You can query the currently set options using
%   getOptions. Not all server options are relevant and supported.
%
%   speechClient Functions:
%   setOptions   - Add server options used when performing speech-to-text 
%                  or text-to-speech. Server options are appended or
%                  overwritten.
%   getOptions   - Get user-specified server options set on client object.
%                  Options are returned as a cell array of name-value
%                  pairs.
%   clearOptions - Remove all user-specified server options from client
%
%   Example 1:
%     % Use the pretrained wav2vec 2.0 model to perform speech-to-text.
%     [y,fs] = audioread('speech_dft.wav');
%     clientObj = speechClient('wav2vec2.0','TimeStamps',true);
%     transcript = speech2text(clientObj,y,fs)
%
%   Example 2:
%     % Use the Google server to perform speech-to-text.
%     [y,fs] = audioread('speech_dft.wav');
%     clientObj = speechClient('Google');
%     setOptions(clientObj,'languageCode','en-US');
%     transcript = speech2text(clientObj,y,fs)
%
%   Example 3:
%     % Use the Amazon server to perform text-to-speech and speech-to-text.
%
%     % Create a speechClient object with server options specific to
%     % text-to-speech. Use text2speech to synthesis a speech signal.
%     speechSynthesizer = speechClient('Amazon');
%     setOptions(speechSynthesizer,'voice-id','Brian')
%     txt = "Play my favorite record. Volume up!";
%     y = text2speech(speechSynthesizer,txt);
%
%     % Clear the client options and specify a different voice ID.
%     % Synthesize the speech, then combine both speech signals and listen 
%     % to the result.
%     clearOptions(speechSynthesizer)
%     setOptions(speechSynthesizer,'voice-id','Amy','text-type','ssml')
%     txt = "<speak><break time='1s'/>" + ...
%           "<amazon:effect phonation='soft'>" + ...
%           "Keep it down<amazon:breath duration='x-long' volume='soft'/> " + ...
%           "the baby is sleeping.</amazon:effect></speak>";
%     [z,fs] = text2speech(speechSynthesizer,txt);
%     yz = [y;z];
%     sound(yz,fs)
%
%     % Create a speechClient object with server options specific to
%     % speech-to-text. Use speech2text to transcribe the speech signal.
%     speechTranscriber = speechClient("Amazon",'Segmentation','word','TimeStamps',true);
%     setOptions(speechTranscriber,'language-code','en-US','settings', ...
%                 struct('ShowSpeakerLabels',true,'MaxSpeakerLabels',3, ...
%                        'ShowAlternatives',true,'MaxAlternatives',4));
%     [transcript,rawOutput] = speech2text(speechTranscriber,yz,fs)
%
%   See also SPEECH2TEXT, TEXT2SPEECH, SIGNALLABELER

 
%   Copyright 2017-2022 The MathWorks, Inc.

