%% 
% Scripts for EEG waveforms 
%%
1. DreemData_prepost_v1
% Creates 30 epochs and does PSD on each waveform for each sleep stage.
% Makes a struct mat file will all data

%% 
2. Dreem_waveforms_v1
% pulls out data from DreemData_prepost_v1 and puts it into a cell array
% and saves it 

%% 
3. Waveforms_perPower
% averages data from Dreem_waveforms_v1 and writes a csv file for each
% patient for their pre and post data 

%% 
4. SleepStageFig
% creates bar plot for percent change in power 

%% 
% Script for voxel overlay 
%% 
1. VTA_mesh_extraction_STN
% probably modify it? 
D:\Documents\GitHub\DBSDreem_VTA

%% 
2. voxOver_STN_Dreem
% voxel overlay analysis 