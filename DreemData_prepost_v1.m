


readdataLOC = 'Z:\Hirt_Neurosurgery_Projects\DBS_Dreem_AJB\DREEMData\DBSSleep03\Pre-DBS ON med\Dreem data';
cd(readdataLOC)

sleepStageList = [{'SLEEP-S1' 'SLEEP-S2' 'SLEEP-S3'}];

hypnoList = dir('*.txt');
hypnoList2 = string({hypnoList.name});

ephysList = dir('*.edf');
ephysList2 = string({ephysList.name});

for i = 1:length(hypnoList2)
    
    tempList = readtable(hypnoList2(i));
    tempSleepList = unique(tempList.SleepStage);
    tempSleepList2 = matches(tempSleepList, sleepStageList);
    
    if any(tempSleepList2) == 1 

        % Load .edf file with same name as hypno
        tempStringName = extractBefore(hypnoList2(i), '_hypnogram.txt');
        tempStringName2 = plus(tempStringName, '.edf');

        tempEDF = edfread(tempStringName2); % load edf file with same name as hypnogram 
        tempEDF(1,:) = []; % get rid of first row

                % get what stages are in the hypno file 
        tempSleepStage = tempSleepList(tempSleepList2);

        for j = 1:length(tempSleepStage)
            switch tempSleepStage(j)
                case 'SLEEP-S1'
                tempSleepLoc = matches(tempList.SleepStage, sleepStageList{1});
                tempSleepLoc2 = find(tempSleepLoc) % rows of where Sleep-S1 is 

                

            end % switch
        end % for j

    end % if 

        
    
end % for 