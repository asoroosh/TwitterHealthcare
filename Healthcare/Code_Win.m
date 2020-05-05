
% % a sample structure array to store the credentials
% save('creds.mat','creds');
clear all

% set up a Twitty object
addpath twitty_1.1.1; % Twitty
addpath parse_json; % Twitty's default json parser
addpath jsonlab-1.0RC1/jsonlab; % I prefer JSONlab, however.
load('creds.mat') % load my real credentials
tw = twitty(creds); % instantiate a Twitty object
tw.jsonParser = @loadjson; % specify JSONlab as json parser


clkstart=clock;

halth=0.20;
halts=halth*60*60;

for t=1:48
    % search for English tweets that mention 'amazon' and 'hachette'
    Healthcare{t}= tw.search('Healthcare','count',180,'include_entities','true','lang','en');
    DigitalHealth{t}= tw.search('DigitalHealth','count',180,'include_entities','true','lang','en');
    % hachette = tw.search('hachette','count',100,'include_entities','true','lang','en');
    % both = tw.search('amazon hachette','count',100,'include_entities','true','lang','en');
    clk=clock;
    disp(['LastCheck:' num2str(clk(1:5))])
%     sampt(:,t)=clk(1:5);
    pause(960);
end
save(['\TW_HC\Trend\DigitalHealthcare' num2str(clkstart(3:5)) '.mat'],'Healthcare','DigitalHealth','-v7.3');

% exit
