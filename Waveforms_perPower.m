

mainDir = 'Z:\Hirt_Neurosurgery_Projects\DBS_Dreem_AJB\CaseData\DreemEpochMatTable';
cd(mainDir)

mdir = dir;
mdir1 = {mdir.name};
mdir2 = mdir1(~ismember(mdir1,{'.', '..'}));



    tempID = mdir2{1};

    tempFile = load(tempID);
    tempFile = tempFile.tempOutTable;
    tempFile(1,:) = [];

    % Pre %
    preLoc = contains(tempFile.PrePost, 'Pre');
    preTab = tempFile(preLoc,:);

    % Waveform Means - no sleep stages 
    % preDeltaM = mean(preTab.Delta,"omitnan" );
    % preAlphaM = mean(preTab.Alpha, "omitnan");
    % preThetaM = mean(preTab.Theta, "omitnan");
    % preBetaM = mean(preTab.Beta, "omitnan");
    % prelBetaM = mean(preTab.BetaL, "omitnan");
    % prehBetaM = mean(preTab.BetaH, "omitnan");
    % preGamma = mean(preTab.Gamma, "omitnan");
    % prelGamma = mean(preTab.GammaL, "omitnan");

    % Waveform means with sleep stages 
    % 
    preS1Loc = contains(preTab.SleepStage, 'S1');
    preS1 = preTab(preS1Loc,:);
    preS1delta = mean(preS1.Delta, "omitnan");
    preS1alpha = mean(preS1.Alpha, "omitnan");
    preS1theta = mean(preS1.Theta, "omitnan");
    preS1beta = mean(preS1.Beta, "omitnan");
    preS1Lbeta = mean(preS1.BetaL, "omitnan");
    preS1Hbeta = mean(preS1.BetaH, "omitnan");
    preS1gamma = mean(preS1.Gamma, "omitnan");
    preS1Lgamma = mean(preS1.GammaL, "omitnan");

    preS2Loc = contains(preTab.SleepStage, 'S2');
    preS2 = preTab(preS2Loc,:);
    preS2delta = mean(preS2.Delta, "omitnan");
    preS2alpha = mean(preS2.Alpha, "omitnan");
    preS2theta = mean(preS2.Theta, "omitnan");
    preS2beta = mean(preS2.Beta, "omitnan");
    preS2Lbeta = mean(preS2.BetaL, "omitnan");
    preS2Hbeta = mean(preS2.BetaH, "omitnan");
    preS2gamma = mean(preS2.Gamma, "omitnan");
    preS2Lgamma = mean(preS2.GammaL, "omitnan");

    preS3Loc = contains(preTab.SleepStage, 'S3');
    preS3 = preTab(preS3Loc,:);
    preS3delta = mean(preS3.Delta, "omitnan");
    preS3alpha = mean(preS3.Alpha, "omitnan");
    preS3theta = mean(preS3.Theta, "omitnan");
    preS3beta = mean(preS3.Beta, "omitnan");
    preS3Lbeta = mean(preS3.BetaL, "omitnan");
    preS3Hbeta = mean(preS3.BetaH, "omitnan");
    preS3gamma = mean(preS3.Gamma, "omitnan");
    preS3Lgamma = mean(preS3.GammaL, "omitnan");

    preREMLoc = contains(preTab.SleepStage, 'REM');
    preREM = preTab(preREMLoc, :);
    preREMdelta = mean(preREM.Delta, "omitnan");
    preREMalpha = mean(preREM.Alpha, "omitnan");
    preREMtheta = mean(preREM.Theta, "omitnan");
    preREMbeta = mean(preREM.Beta, "omitnan");
    preREMLbeta = mean(preREM.BetaL, "omitnan");
    preREMHbeta = mean(preREM.BetaH, "omitnan");
    preREMgamma = mean(preREM.Gamma, "omitnan");
    preREMLgamma = mean(preREM.GammaL, "omitnan");


    preTabOut = table({tempID}, {'Pre'}, preS1delta, preS1alpha, preS1theta, ...
     preS1beta, preS1Lbeta, preS1Hbeta, preS1gamma, preS1Lgamma,preS2delta, ...
     preS2alpha,preS2theta, preS2beta, preS2Lbeta, preS2Hbeta, preS2gamma, ...
     preS2Lgamma, preS3delta, preS3alpha, preS3theta, preS3beta, preS3Lbeta, ...
     preS3Hbeta, preS3gamma, preS3Lgamma, preREMdelta, preREMalpha, preREMtheta, ...
     preREMbeta, preREMLbeta, preREMHbeta, preREMgamma, preREMLgamma, ...
     'VariableNames', {'partID', 'Pre', 'preS1delta', 'preS1alpha', 'preS1theta', ...
     'preS1beta', 'preS1Lbeta', 'preS1Hbeta', 'preS1gamma', 'preS1Lgamma', ...
     'preS2delta', 'preS2alpha','preS2theta', 'preS2beta', 'preS2Lbeta', ...
     'preS2Hbeta', 'preS2gamma', 'preS2Lgamma', 'preS3delta', 'preS3alpha', ...
     'preS3theta', 'preS3beta', 'preS3Lbeta', 'preS3Hbeta', 'preS3gamma', ...
     'preS3Lgamma', 'preREMdelta', 'preREMalpha', 'preREMtheta','preREMbeta', ...
     'preREMLbeta', 'preREMHbeta', 'preREMgamma', 'preREMLgamma'});

    saveLoc = 'Z:\Hirt_Neurosurgery_Projects\DBS_Dreem_AJB\CaseData\DreemSleepStage';
    cd(saveLoc)

    writetable(preTabOut, 'DBSSleep06_pre.csv')


    % post %

    postLoc = contains(tempFile.PrePost, 'Post');
    postTab = tempFile(postLoc,:);

    % Waveform means with sleep stages 

    postS1Loc = contains(postTab.SleepStage, 'S1');
    postS1 = postTab(postS1Loc,:);
    postS1delta = mean(postS1.Delta, "omitnan");
    postS1alpha = mean(postS1.Alpha, "omitnan");
    postS1theta = mean(postS1.Theta, "omitnan");
    postS1beta = mean(postS1.Beta, "omitnan");
    postS1Lbeta = mean(postS1.BetaL, "omitnan");
    postS1Hbeta = mean(postS1.BetaH, "omitnan");
    postS1gamma = mean(postS1.Gamma, "omitnan");
    postS1Lgamma = mean(postS1.GammaL, "omitnan");

    postS2Loc = contains(postTab.SleepStage, 'S2');
    postS2 = postTab(postS2Loc,:);
    postS2delta = mean(postS2.Delta, "omitnan");
    postS2alpha = mean(postS2.Alpha, "omitnan");
    postS2theta = mean(postS2.Theta, "omitnan");
    postS2beta = mean(postS2.Beta, "omitnan");
    postS2Lbeta = mean(postS2.BetaL, "omitnan");
    postS2Hbeta = mean(postS2.BetaH, "omitnan");
    postS2gamma = mean(postS2.Gamma, "omitnan");
    postS2Lgamma = mean(postS2.GammaL, "omitnan");

    postS3Loc = contains(postTab.SleepStage, 'S3');
    postS3 = postTab(postS3Loc,:);
    postS3delta = mean(postS3.Delta, "omitnan");
    postS3alpha = mean(postS3.Alpha, "omitnan");
    postS3theta = mean(postS3.Theta, "omitnan");
    postS3beta = mean(postS3.Beta, "omitnan");
    postS3Lbeta = mean(postS3.BetaL, "omitnan");
    postS3Hbeta = mean(postS3.BetaH, "omitnan");
    postS3gamma = mean(postS3.Gamma, "omitnan");
    postS3Lgamma = mean(postS3.GammaL, "omitnan");

    postREMLoc = contains(postTab.SleepStage, 'REM');
    postREM = postTab(postREMLoc, :);
    postREMdelta = mean(postREM.Delta, "omitnan");
    postREMalpha = mean(postREM.Alpha, "omitnan");
    postREMtheta = mean(postREM.Theta, "omitnan");
    postREMbeta = mean(postREM.Beta, "omitnan");
    postREMLbeta = mean(postREM.BetaL, "omitnan");
    postREMHbeta = mean(postREM.BetaH, "omitnan");
    postREMgamma = mean(postREM.Gamma, "omitnan");
    postREMLgamma = mean(postREM.GammaL, "omitnan");

    postTabOut = table({tempID}, {'Post'}, postS1delta, postS1alpha, postS1theta, ...
        postS1beta, postS1Lbeta, postS1Hbeta, postS1gamma, postS1Lgamma,postS2delta, ...
        postS2alpha,postS2theta, postS2beta, postS2Lbeta, postS2Hbeta, postS2gamma, ...
        postS2Lgamma, postS3delta, postS3alpha, postS3theta, postS3beta, postS3Lbeta, ...
        postS3Hbeta, postS3gamma, postS3Lgamma, postREMdelta, postREMalpha, postREMtheta, ...
        postREMbeta, postREMLbeta, postREMHbeta, postREMgamma, postREMLgamma, ...
        'VariableNames', {'partID', 'Post', 'postS1delta', 'postS1alpha', ...
        'postS1theta', 'postS1beta', 'postS1Lbeta', 'postS1Hbeta', 'postS1gamma', ...
        'postS1Lgamma', ...
        'postS2delta', 'postS2alpha','postS2theta', 'postS2beta', 'postS2Lbeta', ...
        'postS2Hbeta', 'postS2gamma', 'postS2Lgamma', 'postS3delta', 'postS3alpha', ...
        'postS3theta', 'postS3beta', 'postS3Lbeta', 'postS3Hbeta', 'postS3gamma', ...
        'postS3Lgamma', 'postREMdelta', 'postREMalpha', 'postREMtheta','postREMbeta', ...
        'postREMLbeta', 'postREMHbeta', 'postREMgamma', 'postREMLgamma'})

    saveLoc = 'Z:\Hirt_Neurosurgery_Projects\DBS_Dreem_AJB\CaseData\DreemSleepStage';
    cd(saveLoc)

    writetable(postTabOut, 'DBSSleep06_post.csv')


