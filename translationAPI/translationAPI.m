function output = translationAPI(foreignText,fromLang,toLang)
%% Uses google API to make the translations
% Input : foreignText - Text to be translated
%         fromLang - Language of the text to be trnaslated, use google
%         language tags. See GoogleTranslateAPI doccumentation.
%         toLang - Language to be translated to
    import org.jsoup.*
    foreignText = char(java.net.URLEncoder.encode(foreignText,'UTF-8'));
    qryStr = ['https://translation.googleapis.com/language/translate/v2?',...
             'source=',fromLang,...
             '&target=',toLang,...
             '&key=AIzaSyD5Rfu2cZktIASGyQppRewaMY5g5XYkhfY',...
             '&q=',foreignText];
    conn = Jsoup.connect(qryStr);
    conn = conn.timeout(20*1000);
    conn = conn.referrer("http://www.google.com");     
    conn = conn.followRedirects(true);
    conn = conn.userAgent("Chrome");
    conn = conn.ignoreContentType(true); % Ignore conent type should be set to 
                                 % true when extracting rss xml to 
                                 % avoid errors
    objectDOMStr = string(conn.get().toString);
    objectDOMStr = strrep(objectDOMStr,'&quot;','');
    output = strtrim(string(regexp(objectDOMStr,'translatedText:(.*?)}','tokens')));