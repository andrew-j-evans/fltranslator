%text2speech Synthesize speech from text
%
%   The text2speech function enables you to interface with 3rd party
%   cloud-based text-to-speech APIs through MATLAB. Supported 3rd party
%   speech synthesis APIs include: Google, IBM, Microsoft, and Amazon.
%
%   To use the text2speech function, set up an account with the 3rd party
%   API as outlined in <a
%   href="matlab:web('https://www.mathworks.com/matlabcentral/fileexchange/65266-speech2text','-browser')">the documentation</a>.
%
%   [speech,fs] = text2speech(clientObject,txt) synthesizes the speech,
%   sampled at fs hertz, based on text by passing the data to the
%   clientObject. The clientObject is an interface to a third-party API,
%   and is an object of the speechClient class.
%
%   [speech,fs] = text2speech(...,'HTTPTimeOut',TIMEOUT) specifies the
%   TIMEOUT value in seconds to wait for the initial server connection.
%
%   [speech,fs,rawOutput] = text2speech(...) returns the unprocessed
%   output from the server.
%
%   Example:
%     synthesizer = speechClient('Google');
%     [speech,fs] = text2speech(synthesizer,"Hello world");
%     sound(speech,fs)
%
%   See also SPEECHCLIENT, SPEECH2TEXT

 
%   Copyright 2019-2022 The MathWorks, Inc.

