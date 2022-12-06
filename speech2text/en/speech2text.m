%speech2text Transcribe speech signal to text
%
%   speech2text enables you to transcribe speech to text locally using a
%   pretrained wav2vec model (requires Deep Learning Toolbox), or to
%   interface with 3rd-party cloud-based speech-to-text APIs through
%   MATLAB. Supported 3rd-party speech recognition APIs include: Google(R),
%   IBM(R), Microsoft(R), and Amazon(R).
%
%   The wav2vec model requires R2022b or later.
%
%   To use the speech2text function with 3rd-party cloud-based
%   speech-to-text APIs, set up an account with the 3rd-party API as
%   outlined in the speech2text documentation.
%
%   transcript = speech2text(clientObj,audioIn,fs) transcribes the
%   audioIn, sampled at fs hertz, to text by passing the data to the
%   clientObj. The clientObj is a pretrained wav2vec 2.0 model or an
%   interface to a 3rd-party API. The clientObj is created by the
%   speechClient function. The output transcript is returned as a table
%   that contains the transcription and confidence metrics. Some APIs
%   provide additional outputs that are returned in the table. The
%   wav2vec2.0 API returns transcript as a string if the Segmentation
%   option of the clientObj is set to 'none'.
%
%   transcript = speech2text(...,'HTTPTimeOut',TIMEOUT) specifies the
%   TIMEOUT value in seconds to wait for initial server connection. This
%   syntax only applies to cloud-based speech-to-text APIs.
%
%   [transcript,rawOutput] = speech2text(...) returns the unprocessed
%   output from the server. This syntax only applies to cloud-based
%   speech-to-text APIs.
%
%   Example 1:
%     [y,fs] = audioread('speech_dft.wav');
%     clientObj = speechClient('wav2vec2.0');
%     transcript = speech2text(clientObj,y,fs);
%
%   Example 2:
%     [y,fs] = audioread('speech_dft.wav');
%     clientObj = speechClient('Google');
%     setOptions(clientObj,'languageCode','en-US');
%     transcript = speech2text(clientObj,y,fs);
%
%   See also SPEECHCLIENT, SIGNALLABELER, TEXT2SPEECH

 
%   Copyright 2017-2022 The MathWorks, Inc.

