function xlatedString = gtranslate( inputString, destLanguage, sourceLanguage )
%TRANSLATE Uses Google web service to translate a string
%
%  str = translate(input) converts English string to French using the
%          Google language API.
%
%  str = translate(input, destinationLanguage) converts English string to
%          another language. The destinationLanguage should be a two-letter
%          language code (example: en, fr, tk, es). See the Google Language
%          API for a list of supported languages:
%          http://code.google.com/apis/ajaxlanguage/documentation/#SupportedLanguages
%
%  str = translate(input, destLanguage, sourceLanguage) converts a
%          sourceLanguage string to the destLanguage. Both source and
%          destination languages must be the two letter strings. 
%
% Note that many of the supported languages will be undisplayable in the
% default character encoding on Windows.
%
% If an incorrect language is supplied, there will be a gtranslate:error
% error usually with the message: "invalid translation language pair"
%
% For more information about the Google language API see:
% http://code.google.com/apis/ajaxlanguage/
% Make sure all your usage conforms to their Terms of Service:
% http://code.google.com/apis/ajaxlanguage/terms.html

% Acknowledgements:  François Glineur for (another) JSON Parser
%     http://www.mathworks.com/matlabcentral/fileexchange/23393

% Copyright 2009 The MathWorks, Inc.

if nargin < 2
    destLanguage = 'fr';
end
if nargin < 3
    %'en' (English) is the base language
    sourceLanguage = 'en';
end

%build url and send to google
%url = 'https://translation.googleapis.com/language/translate/v2';
%options = weboptions('get', {'v', '1.0','q', inputString, ...
%'langpair', [sourceLanguage '|' destLanguage]}, 'key', 'AIzaSyD5Rfu2cZktIASGyQppRewaMY5g5XYkhfY')
url = ['https://translation.googleapis.com/language/translate/v2?',...
             'source=',sourceLanguage,...
             '&target=',destLanguage,...
             '&key=AIzaSyD5Rfu2cZktIASGyQppRewaMY5g5XYkhfY',...
             '&q=',inputString]
url = strjoin(url)
page = webread(url)

%parse the response
response = parse_json(page);
if response.responseStatus ~= 200 %there was an error
    error('gtranslate:error', response.responseDetails);
end
xlatedString = response.responseData.translatedText;
