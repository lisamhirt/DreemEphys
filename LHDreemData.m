readdataLOC = 'Z:\Hirt_Neurosurgery_Projects\DBS_Dreem_AJB\DREEMData\DBSSleep03\Pre-DBS ON med\Dreem data';

cd(readdataLOC)
% 
% 
% %%
% one edf file and hypnogram for each day 
% edf has ephys and hypnogram has sleep stages 

%%

ephys = edfread("pddbssleep_s03_2022-10-19T20-56-16[06-00].edf");



%% 

hypnoTab = readtable("pddbssleep_s03_2022-10-19T20-56-16[06-00]_hypnogram.txt");
unique(hypnoTab.SleepStage)

%% 

% infoTAB = readtable("pddbssleep_s03_30-10-22T21-19-12[-0600]_depreciated_report.csv");

%%

% pull out first 30 rows for an epoch 

F7_01.epoch_1 = cell2mat(ephys.EEGF7_O1(1:30));
epoch1 = cell2mat(ephys.EEGF7_O1(1:30)); % these are my voltages 

plot(F7_01.epoch_1)

% then run PSD on each of the epochs 
% use pspectrum 

[fxx, pxx] = pspectrum(F7_01.epoch_1);
pxx2 = pow2db(pxx);

% then use fxx to locate the power and break up the power into the bands 

deltaFinx = find(fxx>=0.05 & fxx <=4);
deltaPxx = pxx2(deltaFinx);

% get the power output from this 

% then use pow2db on the power output 
% - changes power to decibles 