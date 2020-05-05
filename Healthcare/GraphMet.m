clear all

addpath /Users/sorooshafyouni/Home/matlab/Ext

rngN=10;
load('/Twitter/dh_all_GraphMet.mat')

Hashtags=find(Vals(:,end)==2);

HTID=InDgr(Hashtags);
[sID,iID]=sort(HTID,'descend');
HTsl=Labels(Hashtags);
HTsl=HTsl(iID);

ff=figure; 
subplot(6,1,1)
hold on
title('In-Degree Centrality of Hashtags')
hh=bar(sID(1:rngN))
hh.EdgeColor = 'k';
hh.FaceColor = 'k';
axis([0 rngN+1 300 1500])
set(gca,'XTick',[])
subplot(6,1,[2 5])
hold on
ylabel('In-Degree')
xlabel('Hashtags')
h=bar(sID(1:rngN))
set(gca,'XTick',1:rngN,'XTickLabel',HTsl(1:rngN))
h.EdgeColor = 'k';
h.FaceColor = 'k';
rotateXLabels(gca, 90)
axis([0 rngN+1 0 300])

Users=find(Vals(:,end)==1);
UID=InDgr(Users);
[usID,uiID]=sort(UID,'descend');
Usl=Labels(Users);
Usl=Usl(uiID);

ff=figure; 
% subplot(6,1,1)
hold on
title('In-Degree Centrality of Users')
% hh=bar(usID(1:rngN))
% hh.EdgeColor = 'k';
% hh.FaceColor = 'k';
% axis([0 rngN+1 300 1500])
% set(gca,'XTick',[])
% subplot(6,1,[2 5])
% hold on
ylabel('In-Degree')
xlabel('Users')
h=bar(usID(1:rngN))
set(gca,'XTick',1:rngN,'XTickLabel',Usl(1:rngN))
h.EdgeColor = 'k';
h.FaceColor = 'k';
rotateXLabels(gca, 90)
axis([0 rngN+1 0 250])
