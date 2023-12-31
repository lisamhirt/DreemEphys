
function [] = DreemData_prepost_v1(PartID, PrePost)

% PartID = 'DBSSleep06';
% PrePost = 'Pre_On';

allData = struct;

readdataLOC = 'Z:\Hirt_Neurosurgery_Projects\DBS_Dreem_AJB\CaseData\DREEMData_raw\DBSSleep03\PreDBS\Pre-DBS ON med\Dreem data';
cd(readdataLOC)

sleepStageList = [{'SLEEP-S1' 'SLEEP-S2' 'SLEEP-S3' 'SLEEP-REM'}];

hypnoList = dir('*.txt');
hypnoList2 = string({hypnoList.name});

ephysList = dir('*.edf');
ephysList2 = string({ephysList.name});

for i = 1:length(hypnoList2)

    tempList = readtable(hypnoList2(i));
    tempSleepList = unique(tempList.SleepStage);
    tempSleepList2 = any(matches(tempSleepList, sleepStageList));

    if tempSleepList2

        % Load .edf file with same name as hypno
        tempStringName = extractBefore(hypnoList2(i), '_hypnogram.txt');
        tempStringName2 = plus(tempStringName, '.edf');

        tempEDF = edfread(tempStringName2); % load edf file with same name as hypnogram

        % Create variable for the date
        tempNightNum = strcat('d', extractBetween(tempStringName, 16, 25));
        tempNightNum2 = regexprep(tempNightNum, '-', '_');

        % Create start and stop lines for epochs within the EDF file
        epochStartLoc = round(linspace(1, (height(tempEDF)-30), height(tempEDF)/30));
        epochEndLoc = [epochStartLoc(2:end)-1 height(tempEDF)];

        epochStartLoc = transpose(epochStartLoc);
        epochEndLoc = transpose(epochEndLoc);

        epochLocInx = [epochStartLoc epochEndLoc]; % index of start and stop rows in tempEDF file. column 1 is start column 2 is end

        % get what stages are in the hypno file
        tempSleepStage = tempSleepList(matches(tempSleepList, sleepStageList));

        for j = 1:length(tempSleepStage)
            switch tempSleepStage{j}
                case 'SLEEP-S1'
                    s1Name = 'S1';
                    tempSleepLoc = matches(tempList.SleepStage, sleepStageList{1});
                    tempSleepLoc2 = find(tempSleepLoc); % rows of where Sleep-S1 is in the hypno list

                    [F7_01, F8_02, F8_F7, F8_01, F7_02] = getEphysPerEpoch(tempSleepLoc2,epochLocInx, tempEDF);
                    allData.(PartID).(PrePost).(tempNightNum2).(s1Name).F7_01 = F7_01;
                    allData.(PartID).(PrePost).(tempNightNum2).(s1Name).F8_02 = F8_02;
                    allData.(PartID).(PrePost).(tempNightNum2).(s1Name).F8_F7 = F8_F7;
                    allData.(PartID).(PrePost).(tempNightNum2).(s1Name).F8_01 = F8_01;
                    allData.(PartID).(PrePost).(tempNightNum2).(s1Name).F7_02 = F7_02;

                case 'SLEEP-S2'
                    s2Name = 'S2';
                    tempSleepLoc = matches(tempList.SleepStage, sleepStageList{2});
                    tempSleepLoc2 = find(tempSleepLoc);

                    [F7_01, F8_02, F8_F7, F8_01, F7_02] = getEphysPerEpoch(tempSleepLoc2,epochLocInx, tempEDF);
                    allData.(PartID).(PrePost).(tempNightNum2).(s2Name).F7_01 = F7_01;
                    allData.(PartID).(PrePost).(tempNightNum2).(s2Name).F8_02 = F8_02;
                    allData.(PartID).(PrePost).(tempNightNum2).(s2Name).F8_F7 = F8_F7;
                    allData.(PartID).(PrePost).(tempNightNum2).(s2Name).F8_01 = F8_01;
                    allData.(PartID).(PrePost).(tempNightNum2).(s2Name).F7_02 = F7_02;

                case 'SLEEP-S3'
                    s3Name = 'S3';
                    tempSleepLoc = matches(tempList.SleepStage, sleepStageList{3});
                    tempSleepLoc2 = find(tempSleepLoc);

                    [F7_01, F8_02, F8_F7, F8_01, F7_02] = getEphysPerEpoch(tempSleepLoc2,epochLocInx, tempEDF);
                    allData.(PartID).(PrePost).(tempNightNum2).(s3Name).F7_01 = F7_01;
                    allData.(PartID).(PrePost).(tempNightNum2).(s3Name).F8_02 = F8_02;
                    allData.(PartID).(PrePost).(tempNightNum2).(s3Name).F8_F7 = F8_F7;
                    allData.(PartID).(PrePost).(tempNightNum2).(s3Name).F8_01 = F8_01;
                    allData.(PartID).(PrePost).(tempNightNum2).(s3Name).F7_02 = F7_02;

                case 'SLEEP-REM'
                    sREMName = 'REM';
                    tempSleepLoc = matches(tempList.SleepStage, sleepStageList{4});
                    tempSleepLoc2 = find(tempSleepLoc);

                    [F7_01, F8_02, F8_F7, F8_01, F7_02] = getEphysPerEpoch(tempSleepLoc2,epochLocInx, tempEDF);
                    allData.(PartID).(PrePost).(tempNightNum2).(sREMName).F7_01 = F7_01;
                    allData.(PartID).(PrePost).(tempNightNum2).(sREMName).F8_02 = F8_02;
                    allData.(PartID).(PrePost).(tempNightNum2).(sREMName).F8_F7 = F8_F7;
                    allData.(PartID).(PrePost).(tempNightNum2).(sREMName).F8_01 = F8_01;
                    allData.(PartID).(PrePost).(tempNightNum2).(sREMName).F7_02 = F7_02;

                otherwise 
                    continue 

            end % switch
        end % for j / tempSleepStage

    else 
        continue

    end % if

end % for hypnoList2

% Save 
saveCD = ['Z:\Hirt_Neurosurgery_Projects\DBS_Dreem_AJB\CaseData\DreemEpochs\' PartID];
cd(saveCD)

saveName = [PartID '_' PrePost];
save(saveName, 'allData')


end % function


function [eegF7_01, eegF8_02, eegF8_F7, eegF8_O1, eegF7_O2] = getEphysPerEpoch(SleepStageLoc, epochLocations, tempEDFepoch)

for k = 1:length(SleepStageLoc)

    tempSleepHypno = SleepStageLoc(k);

    % Electrode F7_O1
    tempF7_O1 = cell2mat(tempEDFepoch.EEGF7_O1(epochLocations(tempSleepHypno,1):epochLocations(tempSleepHypno,2)));
    [deltaData_F7_O1,thetaData_F7_O1,alphaData_F7_O1,betaData_F7_O1,betaLData_F7_O1,betaHData_F7_O1,gammaData_F7_O1,gammaLData_F7_O1,gammaHData_F7_O1] = getPowerSpectrum(tempF7_O1);

    tempEpochName = strcat('epoch',string(tempSleepHypno));

    eegF7_01.(tempEpochName).deltaData = deltaData_F7_O1;
    eegF7_01.(tempEpochName).thetaData = thetaData_F7_O1;
    eegF7_01.(tempEpochName).alphaData = alphaData_F7_O1;
    eegF7_01.(tempEpochName).betaData = betaData_F7_O1;
    eegF7_01.(tempEpochName).betaLData = betaLData_F7_O1;
    eegF7_01.(tempEpochName).betaHData = betaHData_F7_O1;
    eegF7_01.(tempEpochName).gammaData = gammaData_F7_O1;
    eegF7_01.(tempEpochName).gammaLData = gammaLData_F7_O1;
    eegF7_01.(tempEpochName).gammaHData = gammaHData_F7_O1;

    % Electrode F8_O2
    tempF8_O2 = cell2mat(tempEDFepoch.EEGF8_O2(epochLocations(tempSleepHypno,1):epochLocations(tempSleepHypno,2)));
    [deltaData_F8_O2 ,thetaData_F8_O2 ,alphaData_F8_O2 ,betaData_F8_O2 ,betaLData_F8_O2 ,betaHData_F8_O2 ,gammaData_F8_O2 ,gammaLData_F8_O2 ,gammaHData_F8_O2] = getPowerSpectrum(tempF8_O2);

    eegF8_02.(tempEpochName).deltaData = deltaData_F8_O2;
    eegF8_02.(tempEpochName).thetaData = thetaData_F8_O2;
    eegF8_02.(tempEpochName).alphaData = alphaData_F8_O2;
    eegF8_02.(tempEpochName).betaData = betaData_F8_O2;
    eegF8_02.(tempEpochName).betaLData = betaLData_F8_O2;
    eegF8_02.(tempEpochName).betaHData = betaHData_F8_O2;
    eegF8_02.(tempEpochName).gammaData = gammaData_F8_O2;
    eegF8_02.(tempEpochName).gammaLData = gammaLData_F8_O2;
    eegF8_02.(tempEpochName).gammaHData = gammaHData_F8_O2;

    % Electrode F8_F7
    tempF8_F7 = cell2mat(tempEDFepoch.EEGF8_F7(epochLocations(tempSleepHypno,1):epochLocations(tempSleepHypno,2)));
    [deltaData_F8_F7 ,thetaData_F8_F7 ,alphaData_F8_F7 ,betaData_F8_F7 ,betaLData_F8_F7 ,betaHData_F8_F7 ,gammaData_F8_F7 ,gammaLData_F8_F7 ,gammaHData_F8_F7 ] = getPowerSpectrum(tempF8_F7);

    eegF8_F7.(tempEpochName).deltaData = deltaData_F8_F7;
    eegF8_F7.(tempEpochName).thetaData = thetaData_F8_F7;
    eegF8_F7.(tempEpochName).alphaData = alphaData_F8_F7;
    eegF8_F7.(tempEpochName).betaData = betaData_F8_F7;
    eegF8_F7.(tempEpochName).betaLData = betaLData_F8_F7;
    eegF8_F7.(tempEpochName).betaHData = betaHData_F8_F7;
    eegF8_F7.(tempEpochName).gammaData = gammaData_F8_F7;
    eegF8_F7.(tempEpochName).gammaLData = gammaLData_F8_F7;
    eegF8_F7.(tempEpochName).gammaHData = gammaHData_F8_F7;

    % Electrode F8_O1
    tempF8_O1 = cell2mat(tempEDFepoch.EEGF8_O1(epochLocations(tempSleepHypno,1):epochLocations(tempSleepHypno,2)));
    [deltaData_F8_O1 ,thetaData_F8_O1 ,alphaData_F8_O1 ,betaData_F8_O1 ,betaLData_F8_O1 ,betaHData_F8_O1 ,gammaData_F8_O1 ,gammaLData_F8_O1 ,gammaHData_F8_O1 ] = getPowerSpectrum(tempF8_O1);

    eegF8_O1.(tempEpochName).deltaData = deltaData_F8_O1;
    eegF8_O1.(tempEpochName).thetaData = thetaData_F8_O1;
    eegF8_O1.(tempEpochName).alphaData = alphaData_F8_O1;
    eegF8_O1.(tempEpochName).betaData = betaData_F8_O1;
    eegF8_O1.(tempEpochName).betaLData = betaLData_F8_O1;
    eegF8_O1.(tempEpochName).betaHData = betaHData_F8_O1;
    eegF8_O1.(tempEpochName).gammaData = gammaData_F8_O1;
    eegF8_O1.(tempEpochName).gammaLData = gammaLData_F8_O1;
    eegF8_O1.(tempEpochName).gammaHData = gammaHData_F8_O1;

    % Electrode F7_O2
    tempF7_O2 = cell2mat(tempEDFepoch.EEGF7_O2(epochLocations(tempSleepHypno,1):epochLocations(tempSleepHypno,2)));
    [deltaData_F7_O2 ,thetaData_F7_O2 ,alphaData_F7_O2 ,betaData_F7_O2 ,betaLData_F7_O2 ,betaHData_F7_O2 ,gammaData_F7_O2 ,gammaLData_F7_O2 ,gammaHData_F7_O2 ] = getPowerSpectrum(tempF7_O2);

    eegF7_O2.(tempEpochName).deltaData = deltaData_F7_O2;
    eegF7_O2.(tempEpochName).thetaData = thetaData_F7_O2;
    eegF7_O2.(tempEpochName).alphaData = alphaData_F7_O2;
    eegF7_O2.(tempEpochName).betaData = betaData_F7_O2;
    eegF7_O2.(tempEpochName).betaLData = betaLData_F7_O2;
    eegF7_O2.(tempEpochName).betaHData = betaHData_F7_O2;
    eegF7_O2.(tempEpochName).gammaData = gammaData_F7_O2;
    eegF7_O2.(tempEpochName).gammaLData = gammaLData_F7_O2;
    eegF7_O2.(tempEpochName).gammaHData = gammaHData_F7_O2;


end % for k


end % end getEphysPerEpoch


function [deltaData,thetaData,alphaData,betaData,betaLData,betaHData,gammaData,gammaLData,gammaHData] = getPowerSpectrum(tempEEG)

[tempfxx, temppxx] = pspectrum(tempEEG, 250, 'FrequencyResolution', 2, 'FrequencyLimits', [0.5 50]);
temppxx2 = pow2db(temppxx);

% Get frequency ranges and power spectrums
detlaFinx = find(tempfxx>=0.05 & tempfxx<=4);
deltaPxx = temppxx2(detlaFinx);

thetaFinx = find(tempfxx>=4 & tempfxx<=8);
thetaPxx = temppxx2(thetaFinx);

alphaFinx = find(tempfxx>=8 & tempfxx<=13);
alphaPxx = temppxx2(alphaFinx);

betaFinx = find(tempfxx>=13 & tempfxx<=30);
betaPxx = temppxx2(betaFinx);

betaLFinx = find(tempfxx>=13 & tempfxx<=21);
betaLPxx = temppxx2(betaLFinx);

betaHFinx = find(tempfxx>=21 & tempfxx<=30);
betaHPxx = temppxx2(betaHFinx);

gammaFinx = find(tempfxx>=30 & tempfxx(end));
gammaPxx = temppxx2(gammaFinx);

gammaLFinx = find(tempfxx>=30 & tempfxx<=50);
gammaLPxx = temppxx2(gammaLFinx);

gammaHFinx = find(tempfxx>=50 & tempfxx(end));
gammaHPxx = temppxx2(gammaHFinx);

% Get mean, stadard dev., min, max for each power

freqBands = [{'delta' 'theta' 'alpha' 'beta' 'betaL' 'betaH' 'gamma' 'gammaL' 'gammaH'}];

for fi = 1:length(freqBands)
    switch freqBands{fi}
        case 'delta'
            deltaData.deltaStats.mean = mean(deltaPxx);
            deltaData.deltaStats.maxAmp = max(deltaPxx);
            deltaData.deltaStats.minAmp = min(deltaPxx);
            deltaData.deltaStats.stDev = std(deltaPxx);

            maxFreqLoc = find(ismember(deltaPxx, max(deltaPxx)));
            deltaData.deltaStats.maxFreq = detlaFinx(maxFreqLoc);
            deltaData.powerVal = deltaPxx;

        case 'theta'
            thetaData.thetaStats.mean = mean(thetaPxx);
            thetaData.thetaStats.maxAmp = max(thetaPxx);
            thetaData.thetaStats.minAmp = min(thetaPxx);
            thetaData.thetaStats.stDev = std(thetaPxx);

            maxFreqLoc = find(ismember(thetaPxx, max(thetaPxx)));
            thetaData.thetaStats.maxFreq = thetaFinx(maxFreqLoc);
            thetaData.powerVal = thetaPxx;

        case 'alpha'
            alphaData.alphaStats.mean = mean(alphaPxx);
            alphaData.alphaStats.maxAmp = max(alphaPxx);
            alphaData.alphaStats.minAmp = min(alphaPxx);
            alphaData.alphaStats.stDev = std(alphaPxx);

            maxFreqLoc = find(ismember(alphaPxx, max(alphaPxx)));
            alphaData.alphaStats.maxFreq = alphaFinx(maxFreqLoc);
            alphaData.powerVal = alphaPxx;

        case 'beta'
            betaData.betaStats.mean = mean(betaPxx);
            betaData.betaStats.maxAmp = max(betaPxx);
            betaData.betaStats.minAmp = min(betaPxx);
            betaData.betaStats.stDev = std(betaPxx);

            maxFreqLoc = find(ismember(betaPxx, max(betaPxx)));
            betaData.betaStats.maxFreq = betaFinx(maxFreqLoc);
            betaData.powerVal = betaPxx;

        case 'betaL'
            betaLData.betaLStats.mean = mean(betaLPxx);
            betaLData.betaLStats.maxAmp = max(betaLPxx);
            betaLData.betaLStats.minAmp = min(betaLPxx);
            betaLData.betaLStats.stDev = std(betaLPxx);

            maxFreqLoc = find(ismember(betaLPxx, max(betaLPxx)));
            betaLData.betaLStats.maxFreq = betaLFinx(maxFreqLoc);
            betaLData.powerVal = betaLPxx;

        case 'betaH'
            betaHData.betaHStats.mean = mean(betaHPxx);
            betaHData.betaHStats.maxAmp = max(betaHPxx);
            betaHData.betaHStats.minAmp = min(betaHPxx);
            betaHData.betaHStats.stDev = std(betaHPxx);

            maxFreqLoc = find(ismember(betaHPxx, max(betaHPxx)));
            betaHData.betaHStats.maxFreq = betaHFinx(maxFreqLoc);
            betaHData.powerVal = betaHPxx;

        case 'gamma'
            gammaData.gammaStats.mean = mean(gammaPxx);
            gammaData.gammaStats.maxAmp = max(gammaPxx);
            gammaData.gammaStats.minAmp = min(gammaPxx);
            gammaData.gammaStats.stDev = std(gammaPxx);

            maxFreqLoc = find(ismember(gammaPxx, max(gammaPxx)));
            gammaData.gammaStats.maxFreq = gammaFinx(maxFreqLoc);
            gammaData.powerVal = gammaPxx;

        case 'gammaL'
            gammaLData.gammaLStats.mean = mean(gammaLPxx);
            gammaLData.gammaLStats.maxAmp = max(gammaPxx);
            gammaLData.gammaLStats.minAmp = min(gammaPxx);
            gammaLData.gammaLStats.stDev = std(gammaLPxx);

            maxFreqLoc = find(ismember(gammaLPxx, max(gammaLPxx)));
            gammaLData.gammaLStats.maxFreq = gammaLFinx(maxFreqLoc);
            gammaLData.powerVal = gammaLPxx;

        case 'gammaH'
            gammaHData.gammaHStats.mean = mean(gammaHPxx);
            gammaHData.gammaHStats.maxAmp = max(gammaHPxx);
            gammaHData.gammaHStats.minAmp = min(gammaHPxx);
            gammaHData.gammaHStats.stDev = std(gammaHPxx);

            maxFreqLoc = find(ismember(gammaHPxx, max(gammaHPxx)));
            gammaHData.gammaHStats.maxFreq = gammaHFinx(maxFreqLoc);
            gammaHData.powerVal = gammaHPxx;
        otherwise
            continue

    end % switch

end % getPowerSpectrum / fi

end % getPowerSpec fxn

