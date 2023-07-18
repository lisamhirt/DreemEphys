


readdataLOC = 'Z:\Hirt_Neurosurgery_Projects\DBS_Dreem_AJB\DREEMData\DBSSleep03\Pre-DBS ON med\Dreem data';
cd(readdataLOC)

sleepStageList = [{'SLEEP-S1' 'SLEEP-S2' 'SLEEP-S3'}];

hypnoList = dir('*.txt');
hypnoList2 = string({hypnoList.name});

for i = 1:length(hypnoList2)
    
    tempList = readtable(hypnoList2(i));
    tempSleepList = unique(tempList.SleepStage);
    tempSleepList2 = matches(tempSleepList, sleepStageList);
    
    if any(tempSleepList2)
        
    
end % for 