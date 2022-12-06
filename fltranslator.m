clear
clc
jsoup.install()

disp("What language would you like to translate?")

%Records a 3 second audio clip : Format is "Language 1" to "Language 2"
[audioIn,fs] = record(3);

%Gets English transcript to find the input and output languages
googleSpeechClient = speechClient('Google');
setOptions(googleSpeechClient,'languageCode','en-US');

transcript = speech2text(googleSpeechClient,audioIn,fs);

%Changes language to desired input language using the getLanguageCode
%function
[langIn, langInISO, langOut, language1, language2] = getLanguageCode(transcript);
setOptions(googleSpeechClient,'languageCode',langIn);


disp("What would you like to translate?")
%Records audio for the audio to be translated
[audioIn,fs] = record(7);

%Finds the rest of the transcript based on the desired input langauage
transcript = speech2text(googleSpeechClient,audioIn,fs);
transcriptWords = transcript{1, 1};
words = convertStringsToChars(transcriptWords);

%translation = gtranslate(transcriptWords, langOut, langInISO)
%translation =  translator(words,langInISO,langOut);
translation = translationAPI(words,langInISO,langOut);

setOptions(googleSpeechClient,'languageCode',langOut);
output = text2speech(googleSpeechClient,translation);
soundsc(output,fs/2)

language1 = upper(language1);
language2 = upper(language2);

fileID = fopen('output.txt','at+');
fprintf(fileID, "Phrase in %s: %s \nPhrase in %s: %s \n\n", language1, words, language2, translation);
fclose(fileID);

function [audioIn,fs] = record(time)
    recordTime = time;
    frameLength = 1024;
    Fs = 44100;
    frames = ceil(recordTime*Fs/frameLength);
    afw = dsp.AudioFileWriter(SampleRate=Fs,DataType="double",Filename = "tempSpeech.wav");
    adr = audioDeviceReader(SampleRate=Fs,SamplesPerFrame=frameLength);
    disp("-- Recording -- ")
    for index=1:frames
        x = adr();
        afw(x);
    end
    disp("-- Finished Recording -- ")
    disp("")
    release(afw);
    [audioIn,fs] = audioread(afw.Filename);
end

function [langIn, langInISO, langOut, language1, language2] = getLanguageCode(transcript)


    sentence = lower(transcript{1,1});
    words = split(sentence);

    %Lang in codes https://cloud.google.com/speech-to-text/docs/speech-to-text-supported-languages
    %Langout and ISO code http://www.transltr.org/api/getlanguagesfortranslate
    languages = {'french', 'german', 'japanese', 'chinese', 'korean','arabic', 'spanish', 'hindi', 'russian', 'hebrew', 'portugese', 'english'};
    langID = {'fr', 'de', 'ja', 'zh', 'ko', 'ar', 'es', 'hi', 'ru', 'iw', 'pt', 'en'};
    langISO = {'fr-FR', 'de-DE', 'ja-JP', 'zh', 'ko-KR', 'ar-EG', 'es-US', 'hi-IN', 'ru-RU', 'iw-IL', 'pt-PT', 'en-US'};
    
    %inputIndex = find(ismember(languages,words(1)));
    %outputIndex = find(ismember(languages,words(3)));
    langIn = 'Und';
    langInISO = 'Und';
    langOut = 'Und';
  

    for i = 1:length(languages)
        if char(languages(i)) == words(1)
            langIn = langID(i);
            langInISO = langISO(i);
        end
    end
    
    for i = 1:length(languages)
        if char(languages(i)) == words(3)
           langOut = langID(i);
        end
    end

    langIn = char(langIn);
    langInISO = char(langInISO);
    langOut =char(langOut);

    language1 = words(1);
    language2 = words(3);

end
