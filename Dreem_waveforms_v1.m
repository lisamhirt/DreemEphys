
function [] = Dreem_waveforms_v1()

% - Do Pre then post
% - For each pre and post combine on and off
% - pull out each sleep stage
% - average waveforms (delta, beta, alpha) over each sleep stage
% - average all waveforms (delta, beta, alpha) overall regarldess of sleep
% stage

% Go to patient folders
mainDir = 'Z:\Hirt_Neurosurgery_Projects\DBS_Dreem_AJB\CaseData\DreemEpochs';
cd(mainDir)

% Directory for patient folders
mdir = dir;
mdir1 = {mdir.name};
mdir2 = mdir1(~ismember(mdir1,{'.', '..'}));

% count
% Cc = 1;

for i = 1:length(mdir2)

    % cells
    % tempCell = {};
    tempOutCell = {};
    % tempCellEpoch = {};

    % table set up
    caseNameTemp = {'default'};
    tempPrePost = {'default'};
    tempDate = {'default'};
    tempElec = {'default'};
    tempSleepS = {'default'};

    tempDelta = 0;
    tempAlpha = 0;
    tempTheta = 0;
    tempBeta = 0;
    tempBetaL = 0;
    tempBetaH = 0;
    tempGamma = 0;
    tempGammaL = 0;


    tempOutTable = table(caseNameTemp,tempPrePost,tempDate,tempElec,tempSleepS, ...
        tempDelta,tempAlpha,tempTheta,tempBeta,tempBetaL,tempBetaH,tempGamma, ...
        tempGammaL, 'VariableNames', {'partID', 'PrePost', 'Date', 'Electrode', ...
        'SleepStage', 'Delta', 'Alpha', 'Theta', 'Beta', 'BetaL', 'BetaH', ...
        'Gamma', 'GammaL'});



    % CD into patient folders
    tempID = mdir2{i};
    cd(tempID) % cd into patient folder from main dir

    tdir = dir;
    tdir1 = {tdir.name};
    tdir2 =  tdir1(~ismember(tdir1,{'.', '..'}));

    for j = 1:length(tdir2)

        tempFile = tdir2{j};

        if contains(tempFile, '_Post_')
            tempPost = load(tempFile); % load temp post file

            % Get field names
            onOffFN = fieldnames(tempPost.allData.(tempID)); % cell for on or off
            dateFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1})); % cell for dates
            % stageFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{1})); % cell for sleep stages
            % elecFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{1}).(stageFN{1})); % cell for electrodes
            % epochFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{1}).(stageFN{1}).(elecFN{1})); % epochs
            % waveFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{1}).(stageFN{1}).(elecFN{1}).(epochFN{1})); % waveforms
            % statsFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{1}).(stageFN{1}).(elecFN{1}).(epochFN{1}).(waveFN{1})); % get to stats
            % waveStatsFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{1}).(stageFN{1}).(elecFN{1}).(epochFN{1}).(waveFN{1}).(statsFN{1}));

            % Reset count and tempCell %%%% make sure this is right and
            % then change in pre if wrong
            Cc = 1;
            tempCell = {};

            for di = 1:length(dateFN)
                stageFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di})); % cell for sleep stages

                for si = 1:length(stageFN)
                    elecFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si})); % cell for electrodes

                    for ei = 1:length(elecFN)
                        epochFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei})); % epochs

                        for epoci = 1:length(epochFN)
                            waveFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci})); % waveforms

                            for wi = 1:length(waveFN)
                                statsFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi})); % get to stats

                                switch string(waveFN(wi))
                                    case 'deltaData'
                                        tempDeltaMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'thetaData'
                                        tempThetaMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'alphaData'
                                        tempAlphaMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'betaData'
                                        tempBetaMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'betaLData'
                                        tempBetaLMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'betaHData'
                                        tempBetaHMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'gammaData'
                                        tempGammaMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'gammaLData'
                                        tempGammaLMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    otherwise
                                        continue
                                end % switch

                            end % end wi (waveFN)

                            % tempCell = {};
                            tempCell(Cc, 1) = {tempID};
                            tempCell(Cc, 2) = {'Post'};
                            tempCell(Cc, 3) = dateFN(di);
                            tempCell(Cc, 4) = elecFN(ei);
                            tempCell(Cc, 5) = stageFN(si);
                            tempCell(Cc, 6) = {tempDeltaMean};
                            tempCell(Cc, 7) = {tempThetaMean};
                            tempCell(Cc, 8) = {tempAlphaMean};
                            tempCell(Cc, 9) = {tempBetaMean};
                            tempCell(Cc, 10) = {tempBetaLMean};
                            tempCell(Cc, 11) = {tempBetaHMean};
                            tempCell(Cc, 12) = {tempGammaMean};
                            tempCell(Cc, 13) = {tempGammaLMean};
                            Cc = Cc+1;

                        end % end epochi (epochFN)
                    end % end ei (elecFN)
                end % for si (stageFN)
            end % for di (dateFN)

        else contains(tempFile, '_Pre_')

            tempPost = load(tempFile); % load temp post file

            % Get field names
            onOffFN = fieldnames(tempPost.allData.(tempID)); % cell for on or off
            dateFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1})); % cell for dates



            % Reset count and tempCell
            Cc = 1;
            tempCell = {};

            for di = 1:length(dateFN)
                stageFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di})); % cell for sleep stages

                for si = 1:length(stageFN)
                    elecFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si})); % cell for electrodes

                    for ei = 1:length(elecFN)
                        epochFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei})); % epochs

                        for epoci = 1:length(epochFN)
                            waveFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci})); % waveforms

                            for wi = 1:length(waveFN)
                                statsFN = fieldnames(tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi})); % get to stats

                                switch string(waveFN(wi))
                                    case 'deltaData'
                                        tempDeltaMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'thetaData'
                                        tempThetaMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'alphaData'
                                        tempAlphaMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'betaData'
                                        tempBetaMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'betaLData'
                                        tempBetaLMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'betaHData'
                                        tempBetaHMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'gammaData'
                                        tempGammaMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    case 'gammaLData'
                                        tempGammaLMean = tempPost.allData.(tempID).(onOffFN{1}).(dateFN{di}).(stageFN{si}).(elecFN{ei}).(epochFN{epoci}).(waveFN{wi}).(statsFN{1}).mean;
                                    otherwise
                                        continue
                                end % switch

                            end % end wi (waveFN)

                            % tempCell = {};
                            tempCell(Cc, 1) = {tempID};
                            tempCell(Cc, 2) = {'Pre'};
                            tempCell(Cc, 3) = dateFN(di);
                            tempCell(Cc, 4) = elecFN(ei);
                            tempCell(Cc, 5) = stageFN(si);
                            tempCell(Cc, 6) = {tempDeltaMean};
                            tempCell(Cc, 7) = {tempThetaMean};
                            tempCell(Cc, 8) = {tempAlphaMean};
                            tempCell(Cc, 9) = {tempBetaMean};
                            tempCell(Cc, 10) = {tempBetaLMean};
                            tempCell(Cc, 11) = {tempBetaHMean};
                            tempCell(Cc, 12) = {tempGammaMean};
                            tempCell(Cc, 13) = {tempGammaLMean};
                            Cc = Cc+1;

                        end % end epochi (epochFN)
                    end % end ei (elecFN)
                end % for si (stageFN)
            end % for di (dateFN)

        end % if else (pre/post)


        tempOutTable = [tempOutTable; tempCell];
        % tempCell2 = cell2table(tempCell);
        % tempOutTable = [tempOutTable; tempCell2];

        % tempOutCell = [tempOutCell; tempCell];


    end % for j (tdir2)

    % Save
    tempSaveLoc = 'Z:\Hirt_Neurosurgery_Projects\DBS_Dreem_AJB\CaseData\DreemEpochMatTable';
    cd(tempSaveLoc)

    tempSaveName = string(tempID);

    save(tempSaveName, 'tempOutTable');

    % Cd back to folder
    cd(mainDir)

end % i (mdir2)
end % function
