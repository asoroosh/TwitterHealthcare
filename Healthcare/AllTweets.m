clear all

scoreFile = 'AFINN/AFINN-111.txt';
% stopwordsURL ='http://www.textfixer.com/resources/common-english-words.txt';
stopwordsURL='/TW_HC/Removables.txt';

D=dir(['/TW_HC/Trend/']);
fNum=length(D(not([D.isdir])));
fshift=numel([D.isdir])-fNum;
fNam={D.name};

%All tweets
dhAll=[];
hcAll=[];
for tf=1:fNum
    disp(['Opening ' fNam{tf+fshift} ' ...'])
    load(['/TW_HC/Trend/' fNam{tf+fshift}])
    for t=1:size(DigitalHealth,2)
        dhAll=[dhAll DigitalHealth{t}{1}.statuses];
        hcAll=[hcAll Healthcare{t}{1}.statuses];
    end
    clear DigitalHealth Healthcare
end

[dhUsers,dhTweets] = processTweets.extract(dhAll);
dh.Sentiment=processTweets.scoreSentiment(dhTweets,scoreFile,stopwordsURL);
dhNSR = (sum(dh.Sentiment>=0)-sum(dh.Sentiment<0))/height(dhTweets);

[dhwords, dhdict] = processTweets.tokenize(dhTweets,stopwordsURL);
% create a dictionary of unique words
dhdict = unique(dhdict);
% create a word count matrix
[~,dh_tdf] = processTweets.getTFIDF(dhwords,dhdict);
% plot the word count

processTweets.saveEdgeList(dhAll,'Nets/all_dh_el.csv');

% hcAll=[];
% for t=1:size(Healthcare,2)
% %     for i=1:100
% %         DigitalHealth{t}{1}.statuses{i}.text
% %     end
%     hcAll=[hcAll Healthcare{t}{1}.statuses];    
% end

[hcUsers,hcTweets] = processTweets.extract(hcAll);
hc.Sentiment=processTweets.scoreSentiment(hcTweets,scoreFile,stopwordsURL);
hcNSR=(sum(hc.Sentiment>=0)-sum(hc.Sentiment<0))/height(hcTweets);

[hcwords, hcdict] = processTweets.tokenize(hcTweets,stopwordsURL);
% create a dictionary of unique words
hcdict = unique(hcdict);
% create a word count matrix
[~,hc_tdf] = processTweets.getTFIDF(hcwords,hcdict);
% plot the word count

processTweets.saveEdgeList(hcAll,'Nets/all_hc_el.csv');

%% Vis
figure; 
hold on; box on;
title('Sentiment Analysis')
histogram(dh.Sentiment)
histogram(hc.Sentiment)
legend({'DigitalHealth';'Healthcare'})
hold off

figure;
hold on
plot(1:length(dhdict),sum(dh_tdf),'b.')
xlabel('Word Indices')
ylabel('Word Count')
% annotate high frequency words
annotated = find(sum(dh_tdf)>= 70);
jitter = 6*rand(1,length(annotated))-3;
for i = 1:length(annotated)
    text(annotated(i)+3, ...
        sum(dh_tdf(:,annotated(i)))+jitter(i),dhdict{annotated(i)})
end

figure;
hold on
plot(1:length(hcdict),sum(hc_tdf),'b.')
xlabel('Word Indices')
ylabel('Word Count')
% annotate high frequency words
annotated = find(sum(hc_tdf)>= 70);
jitter = 6*rand(1,length(annotated))-3;
for i = 1:length(annotated)
    text(annotated(i)+3, ...
        sum(hc_tdf(:,annotated(i)))+jitter(i),hcdict{annotated(i)})
end

