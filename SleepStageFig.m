
cd('Z:\Hirt_Neurosurgery_Projects\DBS_Dreem_AJB\CaseData\DreemSleepStage')

preTab = readtable('DBSSleep_preCombined.csv');
postTab = readtable('DBSSleep_postCombined.csv');


perDiffPre = table2array(preTab(:, 3:34));
perDiffPost = table2array(postTab(:, 3:34));

% % per diff equation 
% abs(A-B)/(A+B)/2 % A is post 

perDiff = (abs(perDiffPost - perDiffPre))./((perDiffPost+perDiffPre)./2);
perDiff2 = mean(perDiff, 1, "omitnan");

% want 8 columns with 4 sleep stages 

%bans are on the x and sleep stage is on the y 
perDiff3 =transpose(reshape(perDiff2, 8,4));

% make plot 
bar(perDiff3, 'grouped')

