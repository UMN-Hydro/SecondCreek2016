%Outputs head difference in CM


%CHANGES 1/31/17
% Updated file paths for 2015 and 2016 sections
% SCDiver_calc3.m 
%
% This script does the folloing:
% - Can do for each Diver...
% - Reads in pressure tranducer data and barologger time series data
% - Calculates pressure head by subtracting out atmospheric pressure
% - Plots pressure head over time
% - Uses manual depth-to-water measurement inside PVC piezometer at 
%   specified time to determine pressure tranducer elevation (above sea 
%   level)
% - Prints out pressure tranducer elevation 
% - Calculates, plots, and prints total head over time
% - Saves date/time, pressure head, total head, and temperatures in .mat
%   file
%
% Script development notes:
% - 6/26/15 (gcng): created script and ran it for SG-1, PZ-In, PZ-Out, and 
%   PZ-Bank
% - v3 (8/9/15): small modifications to process July data (mostly label
%   dates and added comments).
%   - 8/27/15: change file names to include calibration date and time
%     (i.e., date/time of manual depth-to-water measurement) 

% 3/1/2017
% Most up to date SC_Diver script. Produces correct plots for 2016 data.

clear all, close all, fclose all;

% - Choose one data file by download date 
% date_label = '150625';
% date_label = '150709';
% date_label = '150812';
%date_label = '151016'
% date_label = '160530';
 date_label = '161005';

% - Choose one transducer
% DivLabel = 'SG-1 2015';
 DivLabel = 'PZ-In';
 %DivLabel = 'PZ-Out';
% DivLabel = 'PZ-Bank';
 %DivLabel = 'PZ-CW'; %added summer 2016
%DivLabel = 'PZ-CC'; %added summer 2016
%  DivLabel = 'PZ-CE'; %added summer 2016
% DivLabel = 'PZ-E';
% DivLabel = 'A2';
% DivLabel = 'B1';
% DivLabel = 'C1';
% DivLabel = 'D1';
% DivLabel = 'E1';
%DivLabel = 'SG-1_1st_Position';
%  DivLabel = 'SG-1_2nd_Position';

% =========================
% 6/25/15
% =========================

if strcmp(date_label, '150625')
    % date_label = '150625';

    DivEndDate = nan; DivEndTime = nan;  % nan: use end of file
    if strcmp(DivLabel, 'SG-1 2015')
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_06_25\SG1_150625download_data_edit.csv';
        ManualDate = '2015/06/25'; ManualTime = '16:30:00';
        PVC_Elev = 429.486 * 100; % m -> cm [UPDATED elevations w 10/17 level transit survey]
        PVC_DepthToWater = 75; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = nan; DivStartTime = nan;  % nan: use top of file
            DiverElev = 428.490920 * 100; %[cm] from 08/12/2015 collection date where Diver Elev: 428.490920 m (1405.81 ft)iver

    % *********************

    elseif strcmp(DivLabel, 'PZ-In')
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_06_25\PZIn_150625download_data_edit.csv';
        ManualDate = '2015/06/25'; ManualTime = '16:15:00'; PVC_DepthToWater = 35; % cm
        % PVC_Elev = (1407.937)  * 12 * 2.54; % ft -> cm [Trimble elev]
        PVC_Elev = 429.102*100; % m -> cm [level transit]
        Div_Int_Min = 15; % time interval in min
        DivStartDate = nan; DivStartTime = nan;  % nan: use top of file
        DivEndDate = nan; DivEndTime = nan;  % nan: use end of file
                DiverElev =  428.104250 * 100; %[cm] from 10/16/2015 collection date where Diver Elev: 428.104250 m (1404.54 ft)

    elseif strcmp(DivLabel, 'PZ-Out')
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_06_25\PZOut_150625download_data_edit.csv';
        ManualDate = '2015/06/25'; ManualTime = '16:20:00';
        PVC_Elev =429.120 * 100; % m -> cm [UPDATED w level transit from 10/17]
        PVC_DepthToWater = 36.0; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = nan; DivStartTime = nan;  % nan: use top of file
                DiverElev = 428.117250 * 100; % from 10/16/2015 collection date where Diver Elev: 428.117250 m (1404.58 ft)

    elseif strcmp(DivLabel, 'PZ-Bank');
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_06_25\PZBank_150625download_data_edit.csv';
        ManualDate = '2015/06/25'; ManualTime = '16:10:00';
        PVC_Elev = 429.336 * 100; %  m -> cm [UPDATED elevations w 10/17 level transit survey]
        PVC_DepthToWater = 33.5; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/06/09'; DivStartTime = '15:00:00';
                DiverElev = 428.333000 * 100; % from 10/16/2015 collection date where Diver Elev: 428.333000 m (1405.29 ft)

    else
        fprintf('No data file for %s and %s; exiting... \n', date_label, DivLabel);
        return
    end
    
%     *********************
    
    SCBaro_fil = 'C:\SecondCreekGit\2015_data\2015_06_25\A2Baro_150625download_data.csv';
    Baro_Int_Min = 10; % time interval in min
end

% =========================
% 7/9/15
% =========================

if strcmp(date_label, '150709')
% date_label = '150709';

    if strcmp(DivLabel, 'SG-1 2015') 
        fprintf('SG1: did not log data for %s; exiting\n', date_label);
        return
    % PVC_Elev = 429.486*100; % m -> cm [level transit]
    % SCDiver_fil = '/home/gcng/workspace/ProjectFiles/WildRiceSulfate/SecondCreek_Summer2015/ProcessedResults/DiverData/150709download/SG1_150709download_data.csv';
    % ManualDate = '2015/07/10'; ManualTime = '09:30:00';
    % PVC_DepthToWater = 88.7; % cm
    % Div_Int_Min = 10; % time interval in min
    % DivStartDate = nan; DivStartTime = nan;  % nan: use top of file

    % *********************

    elseif strcmp(DivLabel, 'PZ-In') 
        PVC_Elev = 429.102*100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_07_09\PZIn_150709download_data.csv';
        ManualDate = '2015/07/09'; ManualTime = '14:00:00';
        PVC_DepthToWater = 46.99; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/06/26'; DivStartTime = '16:00:00';  % nan: use top of file
        %DivStartDate = nan; DivStartTime = nan;  % nan: use top of file
        DivEndDate = '2015/07/09'; DivEndTime = '14:00:00';  % nan: use end of file
        DiverElev =  428.104250 * 100; %[cm] from 10/16/2015 collection date where PZI Diver Elev: 428.104250 m (1404.54 ft)

    elseif strcmp(DivLabel, 'PZ-Out')
        PVC_Elev = 429.120 * 100; % m -> cm [UPDATED elevations w 10/17 level transit survey]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_07_09\PZOut_150709download_data.csv';
        % ManualDate = '2015/06/25'; ManualTime = '16:20:00'; PVC_DepthToWater = 36.0; % cm 
        ManualDate = '2015/07/09'; ManualTime = '14:40:00'; PVC_DepthToWater = 46.6725; %cm
        % ManualDate = '2015/06/26'; ManualTime = '14:20:00'; PVC_DepthToWater = 46.7; % cm
        Div_Int_Min = 10; % time interval in min
         DivStartDate = '2015/06/09'; DivStartTime = '11:00:00'; % nan: use start of file
        DivEndDate = '2015/07/09'; DivEndTime = '14:40:00';  % nan: use end of file
        DiverElev = 428.117250 * 100; % from 10/16/2015 collection date where Diver Elev: 428.117250 m (1404.58 ft)

    elseif strcmp(DivLabel, 'PZ-Bank')
        PVC_Elev = 429.336 * 100; % m -> cm [UPDATED elevations w 10/17 level transit survey]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_07_09\PZBank_150709download_data.csv';
        % ManualDate = '2015/06/25'; ManualTime = '16:10:00'; PVC_DepthToWater = 33.5; % cm
        ManualDate = '2015/06/26'; ManualTime = '14:20:00'; PVC_DepthToWater = 36; % cm
        % ManualDate = '2015/07/09'; ManualTime = '13:50:00'; PVC_DepthToWater = 42.5; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/06/09'; DivStartTime = '15:00:00'; % nan: use start of file
        DivEndDate = '2015/07/09'; DivEndTime = '13:50:00';  % nan: use end of file
        DiverElev = 428.333000 * 100; % from 10/16/2015 collection date where Diver Elev: 428.333000 m (1405.29 ft)

    elseif strcmp(DivLabel, 'A2')
        PVC_Elev = 431.638 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_07_09\A2_150709download_data.csv';
        ManualDate = '2015/06/26'; ManualTime = '13:20:00'; PVC_DepthToWater = 8.46*12*2.54; % cm, corresp to installation of y-stick venting
        % ManualDate = '2015/07/09'; ManualTime = '12:40:00'; PVC_DepthToWater = 8.77*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/06/26'; DivStartTime = '13:00:00'; % nan: use start of file
        DivEndDate = '2015/07/09'; DivEndTime = '12:40:00';  % nan: use end of file
        DiverElev = 428.564174 *100;  %from 10/16/2015 collection date where Diver Elev: 428.564174 m (1406.05 ft)

    elseif strcmp(DivLabel, 'B1')
        PVC_Elev = 431.083 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_07_09\B1_150709download_data.csv';
        % ManualDate = '2015/06/26'; ManualTime = '13:30:00'; PVC_DepthToWater = 6.7*12*2.54; % cm, corresp to installation of y-stick venting
        ManualDate = '2015/07/09'; ManualTime = '12:50:00'; PVC_DepthToWater = 7.05*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/06/26'; DivStartTime = '13:00:00'; % nan: use start of file
        DivEndDate = '2015/07/09'; DivEndTime = '12:50:00';  % nan: use end of file
        DiverElev = 428.409016 * 100; %from 10/16/2015 collection date where Diver Elev: 428.409016 m (1405.54 ft)

    elseif strcmp(DivLabel, 'C1')
        PVC_Elev = 431.348 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_07_09\C1_150709download_data.csv';
        % ManualDate = '2015/06/26'; ManualTime = '13:10:00'; PVC_DepthToWater = 6.96*12*2.54; % cm, corresp to installation of y-stick venting
        ManualDate = '2015/07/09'; ManualTime = '13:00:00'; PVC_DepthToWater = 7.32*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/06/26'; DivStartTime = '13:00:00'; % nan: use start of file
        DivEndDate = '2015/07/09'; DivEndTime = '13:00:00';  % nan: use end of file
        DiverElev = 428.694028 * 100;  %from 10/16/2015 collection date where Diver Elev: 428.694028 m (1406.48 ft)

    elseif strcmp(DivLabel, 'D1')
        PVC_Elev = 432.476 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_07_09\D1_150709download_data.csv';
        ManualDate = '2015/07/09'; ManualTime = '13:20:00'; PVC_DepthToWater = 10.18*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/06/26'; DivStartTime = '13:30:00'; % nan: use start of file
        DivEndDate = '2015/07/09'; DivEndTime = '13:20:00';  % nan: use end of file
        DiverElev = 428.899590 * 100;  %from 10/16/2015 collection date where Diver Elev: 428.899590 m (1407.15 ft)

    elseif strcmp(DivLabel, 'E1')
        PVC_Elev = 429.903 *100; % m -> cm [UPDATED elevations w 10/17 level transit survey]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_07_09\E1_150709download_data.csv';
        ManualDate = '2015/06/26'; ManualTime = '13:20:00'; PVC_DepthToWater = 4.89*12*2.54; % cm, corresp to installation of y-stick venting
%         ManualDate = '2015/06/26'; ManualTime = '13:30:00'; PVC_DepthToWater = 4.89*12*2.54; % cm, corresp to installation of y-stick venting
%         ManualDate = '2015/07/09'; ManualTime = '15:20:00'; PVC_DepthToWater = 6.34*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/06/26'; DivStartTime = '13:00:00'; % nan: use start of file
        DivEndDate = '2015/07/09'; DivEndTime = '15:20:00';  % nan: use end of file
        DiverElev = 427.867974 * 100;  %from 10/16/2015 collection date where Diver Elev: 427.867974 m (1403.77 ft)
    else
        fprintf('No data file for %s and %s; exiting... \n', date_label, DivLabel);
        return
    end

    % *********************

    SCBaro_fil = 'C:\SecondCreekGit\2015_data\2015_07_09\A2Baro_150709download_data.csv';
    Baro_Int_Min = 10; % time interval in min
end
    
% =========================
% 8/12/15
% =========================

if strcmp(date_label, '150812')
% date_label = '150812';

    DivEndDate = nan; DivEndTime = nan;  % nan: use end of file
    if strcmp(DivLabel, 'SG-1 2015')
        
        % for 8/12/15: process all data back from 6/26/15 (data download failed on 6/26/15)
        PVC_Elev = 429.486*100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_08_12\CSV_edit\SG1_150812download_data.csv'; % clipped out some data 6/25/15
%         ManualDate = '2015/06/25'; ManualTime = '16:30:00'; PVC_DepthToWater = 75; % cm
%         ManualDate = '2015/07/10'; ManualTime = '09:30:00'; PVC_DepthToWater = 88.7; % cm
        ManualDate = '2015/08/12'; ManualTime = '18:50:00'; PVC_DepthToWater = 33; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/06/25'; DivStartTime = '16:30:00';  % nan: use top of file
        DivEndDate = '2015/08/12'; DivEndTime = '18:50:00';  % nan: use end of file
        DiverElev = 428.490920 * 100; %[cm] from 08/12/2015 collection date where Diver Elev: 428.490920 m (1405.81 ft)

    % *********************

    elseif strcmp(DivLabel, 'PZ-In') 
        PVC_Elev = 429.102*100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_08_12\CSV_edit\PZIn_150812download_data.csv';
         ManualDate = '2015/07/10'; ManualTime = '09:20:00'; PVC_DepthToWater = 45.085; % cm
%         ManualDate = '2015/07/10'; ManualTime = '15:30:00'; PVC_DepthToWater = 45.72; % cm
%        ManualDate = '2015/08/12'; ManualTime = '19:00:00'; PVC_DepthToWater = -5.60; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/07/10'; DivStartTime = '09:20:00';  % nan: use top of file
        DivEndDate = '2015/08/12'; DivEndTime = '19:00:00';  % nan: use end of file
        DiverElev =  428.104250 * 100; %[cm] from 10/16/2015 collection date where Diver Elev: 428.104250 m (1404.54 ft)

    elseif strcmp(DivLabel, 'PZ-Out')
        PVC_Elev =429.120 * 100; % m -> cm [UPDATED w level transit from 10/17]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_08_12\CSV_edit\PZOut_150812download_data.csv';
%         ManualDate = '2015/07/10'; ManualTime = '09:40:00'; PVC_DepthToWater = 45.09; % cm
%         ManualDate = '2015/07/10'; ManualTime = '15:30:00'; PVC_DepthToWater = 46.99; % cm
        ManualDate = '2015/08/12'; ManualTime = '19:10:00'; PVC_DepthToWater = -3.9; % cm (DO NOT TRUST BC FLOODED AND BUBBLES WHEN CAP REMOVED)  
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/07/10'; DivStartTime = '09:40:00';  % nan: use top of file
        DivEndDate = '2015/08/12'; DivEndTime = '19:10:00';  % nan: use end of file
        DiverElev = 428.117250 * 100; % from 10/16/2015 collection date where Diver Elev: 428.117250 m (1404.58 ft)

    elseif strcmp(DivLabel, 'PZ-Bank')
        PVC_Elev = 429.336 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_08_12\CSV_edit\PZBank_150812download_data.csv';
%         ManualDate = '2015/07/10'; ManualTime = '15:30:00'; PVC_DepthToWater = 47.68; % cm
        ManualDate = '2015/08/12'; ManualTime = '18:40:00'; PVC_DepthToWater = 8.9; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/07/10'; DivStartTime = '15:30:00'; % nan: use start of file
        DivEndDate = '2015/08/12'; DivEndTime = '18:40:00';  % nan: use end of file
        DiverElev = 428.333000 * 100; % from 10/16/2015 collection date where Diver Elev: 428.333000 m (1405.29 ft)

    elseif strcmp(DivLabel, 'PZ-E')
        PVC_Elev = 429.477 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_08_12\CSV_edit\PZE_150812download_data.csv';
        ManualDate = '2015/07/10'; ManualTime = '15:30:00'; PVC_DepthToWater = 84; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/07/10'; DivStartTime = '15:30:00'; % nan: use start of file
        DivEndDate = '2015/08/13'; DivEndTime = '13:00:00';  % nan: use end of file
        DiverElev = 428.106250 * 100; % from 10/16/2015 collection date where Diver Elev: 428.106250 m (1404.55 ft)

    elseif strcmp(DivLabel, 'A2')
        PVC_Elev = 431.638 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_08_12\CSV_edit\A2_150812download_data.csv';
%         ManualDate = '2015/07/10'; ManualTime = '16:30:00'; PVC_DepthToWater = 8.82*12*2.54; % cm, corresp to end of y-stick venting
        ManualDate = '2015/08/12'; ManualTime = '18:10:00'; PVC_DepthToWater = 7.82*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/07/10'; DivStartTime = '16:30:00'; % nan: use start of file
        DivEndDate = '2015/08/12'; DivEndTime = '18:10:00';  % nan: use end of file
        DiverElev = 428.564174 *100;  %from 10/16/2015 collection date where Diver Elev: 428.564174 m (1406.05 ft)

    elseif strcmp(DivLabel, 'B1')
        PVC_Elev = 431.083 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_08_12\CSV_edit\B1_150812download_data.csv'; % clipped out some 7/10 data (diver removed temporarily?)
%         ManualDate = '2015/07/10'; ManualTime = '11:20:00'; PVC_DepthToWater = 7.04*12*2.54; % cm, corresp to end of y-stick venting
        ManualDate = '2015/08/12'; ManualTime = '18:00:00'; PVC_DepthToWater = 6.09*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/07/10'; DivStartTime = '11:20:00'; % nan: use start of file
        DivEndDate = '2015/08/12'; DivEndTime = '18:00:00';  % nan: use end of file
          DiverElev = 428.409016 * 100; %from 10/16/2015 collection date where Diver Elev: 428.409016 m (1405.54 ft)

    elseif strcmp(DivLabel, 'C1')
        PVC_Elev = 431.348 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_08_12\CSV_edit\C1_150812download_data.csv'; % clipped out some 7/10 data (diver removed temporarily?)
%         ManualDate = '2015/07/10'; ManualTime = '11:30:00'; PVC_DepthToWater = 7.32*12*2.54; % cm, corresp to end of y-stick venting
        ManualDate = '2015/08/12'; ManualTime = '17:00:00'; PVC_DepthToWater = 6.56*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/07/10'; DivStartTime = '11:30:00'; % nan: use start of file
        DivEndDate = '2015/08/12'; DivEndTime = '17:00:00';  % nan: use end of file
        DiverElev = 428.694028 * 100;  %from 10/16/2015 collection date where Diver Elev: 428.694028 m (1406.48 ft)

    elseif strcmp(DivLabel, 'D1')
        PVC_Elev = 432.476 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_08_12\CSV_edit\D1_150812download_data.csv'; % clipped out some 7/10 data (diver removed temporarily?)
%         ManualDate = '2015/07/10'; ManualTime = '12:10:00'; PVC_DepthToWater = 10.68*12*2.54; % cm
        ManualDate = '2015/07/10'; ManualTime = '16:30:00'; PVC_DepthToWater = 10.21*12*2.54; % cm
%         ManualDate = '2015/08/12'; ManualTime = '19:20:00'; PVC_DepthToWater = 9.98*12*2.54; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/07/10'; DivStartTime = '12:10:00'; % nan: use start of file
        DivEndDate = '2015/08/12'; DivEndTime = '19:20:00';  % nan: use end of file
        DiverElev = 428.899590 * 100;  %from 10/16/2015 collection date where Diver Elev: 428.899590 m (1407.15 ft)

    elseif strcmp(DivLabel, 'E1')
        PVC_Elev = 429.903 * 100; % m -> cm [UPDATED using level transit 10/17]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_08_12\CSV_edit\E1_150812download_data.csv'; 
%         ManualDate = '2015/07/10'; ManualTime = '16:40:00'; PVC_DepthToWater = 5.36*12*2.54; % cm, corresp to end of y-stick venting
        ManualDate = '2015/08/12'; ManualTime = '19:40:00'; PVC_DepthToWater = 4.25*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/07/10'; DivStartTime = '16:40:00'; % nan: use start of file
        DivEndDate = '2015/08/12'; DivEndTime = '19:40:00';  % nan: use end of file
         DiverElev = 427.867974 * 100;  %from 10/16/2015 collection date where Diver Elev: 427.867974 m (1403.77 ft)

    else
        fprintf('No data file for %s; exiting... \n', date_label);
        return
    end

    % *********************

    SCBaro_fil = 'C:\SecondCreekGit\2015_data\2015_08_12\CSV_edit\A2Baro_150812download_data.csv';
    Baro_Int_Min = 10; % time interval in min
        
end

    
% =========================
% 10/16/15
% =========================

if strcmp(date_label, '151016')
% date_label = '151016';

    DivEndDate = nan; DivEndTime = nan;  % nan: use end of file
    if strcmp(DivLabel, 'SG-1 2015')
       
        PVC_Elev = 429.4857552*100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_10_16\CSV_edit\SG1_151016download_data.csv'; % clipped out some data 6/25/15
%         ManualDate = '2015/06/25'; ManualTime = '16:30:00'; PVC_DepthToWater = 75; % cm
%         ManualDate = '2015/07/10'; ManualTime = '09:30:00'; PVC_DepthToWater = 88.7; % cm
        ManualDate = '2015/10/16'; ManualTime = '18:00:00'; PVC_DepthToWater = 102.2; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/08/13'; DivStartTime = '14:50:00';  % nan: use top of file
        DivEndDate = '2015/10/16'; DivEndTime = '17:50:00';  % nan: use end of file
        DiverElev = 428.490920 * 100; %[cm] from 08/12/2015 collection date where Diver Elev: 428.490920 m (1405.81 ft)

    % *********************

    elseif strcmp(DivLabel, 'PZ-In') 
        PVC_Elev = 429.102 * 100; % m -> cm [level transit 10/17]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_10_16\CSV_edit\PZI_151016download_data.csv';
%         ManualDate = '2015/07/10'; ManualTime = '09:20:00'; PVC_DepthToWater = 45.09; % cm
%         ManualDate = '2015/07/10'; ManualTime = '15:30:00'; PVC_DepthToWater = 45.72; % cm
        ManualDate = '2015/10/16'; ManualTime = '16:20:00'; PVC_DepthToWater = 61.2; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/08/13'; DivStartTime = '14:50:00';  % nan: use top of file
        DivEndDate = '2015/10/16'; DivEndTime = '16:20:00';  % nan: use end of file
         DiverElev =  428.104250 * 100; %[cm] from 10/16/2015 collection date where Diver Elev: 428.104250 m (1404.54 ft)

    elseif strcmp(DivLabel, 'PZ-Out')
        PVC_Elev = 429.120 * 100; % m -> cm [level transit 10/17]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_10_16\CSV_edit\PZO_151016download_data.csv';
%         ManualDate = '2015/07/10'; ManualTime = '09:40:00'; PVC_DepthToWater = 45.09; % cm
%         ManualDate = '2015/07/10'; ManualTime = '15:30:00'; PVC_DepthToWater = 46.99; % cm
        ManualDate = '2015/10/16'; ManualTime = '16:40:00'; PVC_DepthToWater = 59; % cm (DO NOT TRUST BC FLOODED AND BUBBLES WHEN CAP REMOVED)  
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/08/13'; DivStartTime = '15:10:00';  % nan: use top of file
        DivEndDate = '2015/10/16'; DivEndTime = '16:40:00';  % nan: use end of file
        DiverElev = 428.117250 * 100; % from 10/16/2015 collection date where Diver Elev: 428.117250 m (1404.58 ft)

    elseif strcmp(DivLabel, 'PZ-Bank')
        PVC_Elev = 429.336 * 100; % m -> cm [level transit 10/17 survey]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_10_16\CSV_edit\PZB_151016download_data.csv';
%         ManualDate = '2015/07/10'; ManualTime = '15:30:00'; PVC_DepthToWater = 47.68; % cm
        ManualDate = '2015/10/16'; ManualTime = '12:00:00'; PVC_DepthToWater = 50.1; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/08/13'; DivStartTime = '14:30:00'; % nan: use start of file
        DivEndDate = '2015/10/16'; DivEndTime = '12:00:00';  % nan: use end of file
        DiverElev = 428.333000 * 100; % from 10/16/2015 collection date where Diver Elev: 428.333000 m (1405.29 ft)

    elseif strcmp(DivLabel, 'PZ-E')
        PVC_Elev = 429.477 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_10_16\CSV_edit\PZE_151016download_data.csv';
        ManualDate = '2015/10/16'; ManualTime = '14:50:00'; PVC_DepthToWater = 101.1; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/08/13'; DivStartTime = '18:50:00'; % nan: use start of file
        DivEndDate = '2015/10/16'; DivEndTime = '14:50:00';  % nan: use end of file
        DiverElev = 428.106250 * 100; % from 10/16/2015 collection date where Diver Elev: 428.106250 m (1404.55 ft)

    elseif strcmp(DivLabel, 'A2')
        PVC_Elev = 431.638 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_10_16\CSV_edit\A2_151016download_data.csv';
%         ManualDate = '2015/07/10'; ManualTime = '16:30:00'; PVC_DepthToWater = 8.82*12*2.54; % cm, corresp to end of y-stick venting
        ManualDate = '2015/10/16'; ManualTime = '12:00:00'; PVC_DepthToWater = 8.87*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/08/13'; DivStartTime = '20:50:00'; % nan: use start of file
        DivEndDate = '2015/10/16'; DivEndTime = '12:00:00';  % nan: use end of file
        DiverElev = 428.564174 *100;  %from 10/16/2015 collection date where Diver Elev: 428.564174 m (1406.05 ft)

    elseif strcmp(DivLabel, 'B1')
        PVC_Elev = 431.083 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_10_16\CSV_edit\B1_151016download_data.csv'; % clipped out some 7/10 data (diver removed temporarily?)
%         ManualDate = '2015/07/10'; ManualTime = '11:20:00'; PVC_DepthToWater = 7.04*12*2.54; % cm, corresp to end of y-stick venting
        ManualDate = '2015/10/16'; ManualTime = '12:00:00'; PVC_DepthToWater = 7.08*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/08/13'; DivStartTime = '19:10:00'; % nan: use start of file
        DivEndDate = '2015/10/16'; DivEndTime = '12:00:00';  % nan: use end of file
          DiverElev = 428.409016 * 100; %from 10/16/2015 collection date where Diver Elev: 428.409016 m (1405.54 ft)

    elseif strcmp(DivLabel, 'C1')
        PVC_Elev = 431.348 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_10_16\CSV_edit\C1_151016download_data.csv'; % clipped out some 7/10 data (diver removed temporarily?)
%         ManualDate = '2015/07/10'; ManualTime = '11:30:00'; PVC_DepthToWater = 7.32*12*2.54; % cm, corresp to end of y-stick venting
        ManualDate = '2015/10/16'; ManualTime = '12:00:00'; PVC_DepthToWater = 7.39*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/08/13'; DivStartTime = '20:40:00'; % nan: use start of file
        DivEndDate = '2015/10/16'; DivEndTime = '12:00:00';  % nan: use end of file
        DiverElev = 428.694028 * 100;  %from 10/16/2015 collection date where Diver Elev: 428.694028 m (1406.48 ft)

    elseif strcmp(DivLabel, 'D1')
        PVC_Elev = 432.476 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_10_16\CSV_edit\D1_151016download_data.csv'; % clipped out some 7/10 data (diver removed temporarily?)
%         ManualDate = '2015/07/10'; ManualTime = '12:10:00'; PVC_DepthToWater = 10.68*12*2.54; % cm
        ManualDate = '2015/10/16'; ManualTime = '12:00:00'; PVC_DepthToWater = 10.45*12*2.54; % cm
%         ManualDate = '2015/08/12'; ManualTime = '19:20:00'; PVC_DepthToWater = 9.98*12*2.54; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/08/13'; DivStartTime = '21:00:00'; % nan: use start of file
        DivEndDate = '2015/10/16'; DivEndTime = '12:00:00';  % nan: use end of file
        DiverElev = 428.899590 * 100;  %from 10/16/2015 collection date where Diver Elev: 428.899590 m (1407.15 ft)

    elseif strcmp(DivLabel, 'E1')
        PVC_Elev = 429.903 * 100; % m -> cm [level transit 10/17]
        SCDiver_fil = 'C:\SecondCreekGit\2015_data\2015_10_16\CSV_edit\E1_151016download_data.csv'; 
%         ManualDate = '2015/07/10'; ManualTime = '16:40:00'; PVC_DepthToWater = 5.36*12*2.54; % cm, corresp to end of y-stick venting
        ManualDate = '2015/10/16'; ManualTime = '12:00:00'; PVC_DepthToWater = 4.97*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2015/08/13'; DivStartTime = '21:10:00'; % nan: use start of file
        DivEndDate = '2015/10/16'; DivEndTime = '12:00:00';  % nan: use end of file
        DiverElev = 427.867974 * 100;  %from 10/16/2015 collection date where Diver Elev: 427.867974 m (1403.77 ft)

    else
        fprintf('No data file for %s; exiting... \n', date_label);
        return
    end

    % *********************

    SCBaro_fil = 'C:\SecondCreekGit\2015_data\2015_10_16\CSV_edit\A2BARO_151016download_data.csv';
    Baro_Int_Min = 10; % time interval in min
        
end


% =========================
% 05/31/16
% =========================

if strcmp(date_label, '160530')    %Should date label be 160531?
% date_label = '160530';
% 
%     DivEndDate = nan; DivEndTime = nan;  % nan: use end of file
%      if strcmp(DivLabel, 'SG-1 1st Position')
%       
%         PVC_Elev = 428.757*100; % m -> cm [level transit]
%         SCDiver_fil = ''; 
% %         ManualDate = '2015/06/25'; ManualTime = '16:30:00'; PVC_DepthToWater = 75; % cm
% %         ManualDate = '2015/07/10'; ManualTime = '09:30:00'; PVC_DepthToWater = 88.7; % cm
%         ManualDate = '2016/05/30'; ManualTime = '19:00:00'; PVC_DepthToWater = 62.4; % cm
%         Div_Int_Min = 10; % time interval in min
%         DivStartDate = '2015/10/17'; DivStartTime = '17:00:00'; % nan: use start of file
%         DivEndDate = '2016/05/30'; DivEndTime = '19:00:00';  % nan: use end of file

%     % *********************
% 
%     elseif strcmp(DivLabel, 'PZ-In') 
%         PVC_Elev = 429.102 * 100; % m -> cm [level transit 10/17]
%         SCDiver_fil = 'C:\Users\Amanda\Desktop\Research\Diver\2015_10_16\CSV_edit\PZI_151016download_data.csv';
% %         ManualDate = '2015/07/10'; ManualTime = '09:20:00'; PVC_DepthToWater = 45.09; % cm
% %         ManualDate = '2015/07/10'; ManualTime = '15:30:00'; PVC_DepthToWater = 45.72; % cm
%         ManualDate = '2015/10/16'; ManualTime = '16:20:00'; PVC_DepthToWater = 61.2; % cm
%         Div_Int_Min = 10; % time interval in min
%         DivStartDate = '2015/08/13'; DivStartTime = '14:50:00';  % nan: use top of file
%         DivEndDate = '2015/10/16'; DivEndTime = '16:20:00';  % nan: use end of file
% 
%     elseif strcmp(DivLabel, 'PZ-Out')
%         PVC_Elev = 429.120 * 100; % m -> cm [level transit 10/17]
%         SCDiver_fil = 'C:\Users\Amanda\Desktop\Research\Diver\2015_10_16\CSV_edit\PZO_151016download_data.csv';
% %         ManualDate = '2015/07/10'; ManualTime = '09:40:00'; PVC_DepthToWater = 45.09; % cm
% %         ManualDate = '2015/07/10'; ManualTime = '15:30:00'; PVC_DepthToWater = 46.99; % cm
%         ManualDate = '2015/10/16'; ManualTime = '16:40:00'; PVC_DepthToWater = 59; % cm (DO NOT TRUST BC FLOODED AND BUBBLES WHEN CAP REMOVED)  
%         Div_Int_Min = 10; % time interval in min
%         DivStartDate = '2015/08/13'; DivStartTime = '15:10:00';  % nan: use top of file
%         DivEndDate = '2015/10/16'; DivEndTime = '16:40:00';  % nan: use end of file
% 
%     elseif strcmp(DivLabel, 'PZ-Bank')
%         PVC_Elev = 429.336 * 100; % m -> cm [level transit 10/17 survey]
%         SCDiver_fil = 'C:\Users\Amanda\Desktop\Research\Diver\2015_10_16\CSV_edit\PZB_151016download_data.csv';
% %         ManualDate = '2015/07/10'; ManualTime = '15:30:00'; PVC_DepthToWater = 47.68; % cm
%         ManualDate = '2015/10/16'; ManualTime = '12:00:00'; PVC_DepthToWater = 50.1; % cm
%         Div_Int_Min = 10; % time interval in min
%         DivStartDate = '2015/08/13'; DivStartTime = '14:30:00'; % nan: use start of file
%         DivEndDate = '2015/10/16'; DivEndTime = '12:00:00';  % nan: use end of file
% 
%     elseif strcmp(DivLabel, 'PZ-E')
%         PVC_Elev = 429.477 * 100; % m -> cm [level transit]
%         SCDiver_fil = 'C:\Users\Amanda\Desktop\Research\Diver\2015_10_16\CSV_edit\PZE_151016download_data.csv';
%         ManualDate = '2015/10/16'; ManualTime = '14:50:00'; PVC_DepthToWater = 101.1; % cm
%         Div_Int_Min = 10; % time interval in min
%         DivStartDate = '2015/08/13'; DivStartTime = '18:50:00'; % nan: use start of file
%         DivEndDate = '2015/10/16'; DivEndTime = '14:50:00';  % nan: use end of file

    if strcmp(DivLabel, 'A2')
        PVC_Elev = 431.638 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2016_data\2016_05_30\CSV_edit\A2_160530download_data.csv';
%         ManualDate = '2015/07/10'; ManualTime = '16:30:00'; PVC_DepthToWater = 8.82*12*2.54; % cm, corresp to end of y-stick venting
        ManualDate = '2016/05/30'; ManualTime = '19:00:00'; PVC_DepthToWater = 8.25*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2015/10/17'; DivStartTime = '17:00:00'; % nan: use start of file
        DivEndDate = '2016/05/30'; DivEndTime = '19:00:00';  % nan: use end of file
   %     DiverElev = 427.102150 * 100;  

    elseif strcmp(DivLabel, 'B1')
        PVC_Elev = 431.083 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2016_data\2016_05_30\CSV_edit\B1_160530downlaod_data.csv'; % clipped out some 7/10 data (diver removed temporarily?)
%         ManualDate = '2015/07/10'; ManualTime = '11:20:00'; PVC_DepthToWater = 7.04*12*2.54; % cm, corresp to end of y-stick venting
        ManualDate = '2016/05/30'; ManualTime = '19:00:00'; PVC_DepthToWater = 6.51*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2015/10/17'; DivStartTime = '17:00:00'; % nan: use start of file
        DivEndDate = '2016/05/30'; DivEndTime = '19:00:00';  % nan: use end of file
  %      DiverElev =  428.339752 * 100; 
    elseif strcmp(DivLabel, 'C1')
        PVC_Elev = 431.348 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2016_data\2016_05_30\CSV_edit\C1_160530download_data.csv'; % clipped out some 7/10 data (diver removed temporarily?)
%         ManualDate = '2015/07/10'; ManualTime = '11:30:00'; PVC_DepthToWater = 7.32*12*2.54; % cm, corresp to end of y-stick venting
        ManualDate = '2016/05/30'; ManualTime = '19:00:00'; PVC_DepthToWater = 6.52*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2015/10/17'; DivStartTime = '17:00:00'; % nan: use start of file
        DivEndDate = '2016/05/30'; DivEndTime = '19:00:00';  % nan: use end of file
    %    DiverElev =  428.647704 * 100;
    elseif strcmp(DivLabel, 'D1')
        PVC_Elev = 432.476 * 100; % m -> cm [level transit]
        SCDiver_fil = 'C:\SecondCreekGit\2016_data\2016_05_30\CSV_edit\D1_160530download_data.csv'; % clipped out some 7/10 data (diver removed temporarily?)
%         ManualDate = '2015/07/10'; ManualTime = '12:10:00'; PVC_DepthToWater = 10.68*12*2.54; % cm
        ManualDate = '2016/05/30'; ManualTime = '19:15:00'; PVC_DepthToWater = 4.69*12*2.54; % cm     %Depth  to water was 9, changed to reflect the 2016 manual data
%         ManualDate = '2015/08/12'; ManualTime = '19:20:00'; PVC_DepthToWater = 9.98*12*2.54; % cm
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2015/10/17'; DivStartTime = '17:00:00'; % nan: use start of file
        DivEndDate = '2016/05/30'; DivEndTime = '19:15:00';  % nan: use end of file
      %  DiverElev =  431.046488 * 100;

    elseif strcmp(DivLabel, 'E1')
        PVC_Elev = 429.903 * 100; % m -> cm [level transit 10/17]
        SCDiver_fil = 'C:\SecondCreekGit\2016_data\2016_05_30\CSV_edit\E1_160530download_data.csv'; 
%         ManualDate = '2015/07/10'; ManualTime = '16:40:00'; PVC_DepthToWater = 5.36*12*2.54; % cm, corresp to end of y-stick venting
        ManualDate = '2016/05/30'; ManualTime = '19:30:00'; PVC_DepthToWater = 4.69*12*2.54; % cm, corresp to end of y-stick venting
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2015/10/17'; DivStartTime = '17:00:00'; % nan: use start of file
        DivEndDate = '2016/05/30'; DivEndTime = '19:30:00';  % nan: use end of file
      %  DiverElev =  427.854568 * 100;

    else
        fprintf('No data file for %s; exiting... \n', date_label);
        return
    end

    % *********************

    SCBaro_fil = 'C:\SecondCreekGit\2016_data\2016_05_30\CSV_edit\A2Baro_160530download_data.csv';
    Baro_Int_Min = 15; % time interval in min
        
end


% =========================
% 10/01/16
% =========================

if strcmp(date_label, '161005')           
% date_label = '161005';

    DivEndDate = nan; DivEndTime = nan;  % nan: use end of file
    if strcmp(DivLabel, 'SG-1_1st_Position_patricks calculated elevation')  %split dis up, moved on august first
       
        PVC_Elev = 429.092 * 100; % m -> cm [total station transit 10/01/16]
        SCDiver_fil = 'C:\SecondCreekGit\DATA\2016_head_data\2016_10_02\CSV_edit\sg1_4_161005161403_H2366FirstPlacement.csv'; 
%         ManualDate = '2015/06/25'; ManualTime = '16:30:00'; PVC_DepthToWater = 75; % cm
%         ManualDate = '2015/07/10'; ManualTime = '09:30:00'; PVC_DepthToWater = 88.7; % cm
        ManualDate = '2016/05/31'; ManualTime = '09:45:00'; PVC_DepthToWater = 62.4; % cm 
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2016/05/31'; DivStartTime = '09:45:00';  % nan: use top of file
        DivEndDate = '2016/07/25'; DivEndTime = '17:00:00';  % nan: use end of file
        DiverElev =  428.757 * 100;

    elseif strcmp(DivLabel, 'SG-1_2nd_Position')  %split dis up, moved on august first
       
        PVC_Elev = 428.818 * 100; % m -> cm [total station transit 10/01/16]
        SCDiver_fil = 'C:\SecondCreekGit\2016_data\2016_10_02\CSV_edit\sg1_4_161005161403_H2366SecondPlacement.csv';
%         ManualDate = '2015/06/25'; ManualTime = '16:30:00'; PVC_DepthToWater = 75; % cm
%         ManualDate = '2015/07/10'; ManualTime = '09:30:00'; PVC_DepthToWater = 88.7; % cm
        ManualDate = '2016/10/01'; ManualTime = '14:30:00'; PVC_DepthToWater = -3.9; % cm 
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2016/08/01'; DivStartTime = '15:00:00';  % nan: use top of file
        DivEndDate = '2016/09/30'; DivEndTime = '14:30:00';  % nan: use end of file
     %      DiverElev =  428.111420*100;
    % *********************

    elseif strcmp(DivLabel, 'PZ-In') 
        PVC_Elev = 429.098 * 100; % m -> cm [total station transit 10/01/16]
           SCDiver_fil = 'C:\SecondCreekGit\2017 Summer data dump\Edited txt files\MON_M3583\1_171026105654_M3583.csv'
       ManualDate = '2016/10/01'; ManualTime = '13:00:00'; PVC_DepthToWater = 22.7; % cm
%         ManualDate = '2016/05/31'; ManualTime = '09:00:00'; PVC_DepthToWater = 56.37; % cm

        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2016/06/01'; DivStartTime = '15:00:00';  % nan: use top of file
        DivEndDate = '2016/10/01'; DivEndTime = '13:00:00';  % nan: use end of file
      %  DiverElev =  428.087250*100;
    elseif strcmp(DivLabel, 'PZ-Out')
        PVC_Elev = 429.12 * 100; % m -> cm [total station transit 10/02/16]
        SCDiver_fil = 'C:\SecondCreekGit\2016_data\2016_10_02\CSV_edit\pzo_1_161005162522_J3542.CSV';
 %      ManualDate = '2016/05/31'; ManualTime = '09:15:00'; PVC_DepthToWater = 55.7; % cm (DO NOT TRUST BC FLOODED AND BUBBLES WHEN CAP REMOVED)  

        ManualDate = '2016/10/01'; ManualTime = '15:45:00'; PVC_DepthToWater = 24.8; % cm (DO NOT TRUST BC FLOODED AND BUBBLES WHEN CAP REMOVED)  
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2016/06/14'; DivStartTime = '12:15:00';  % nan: use top of file
        DivEndDate = '2016/10/01'; DivEndTime = '15:45:00';  % nan: use end of file
   %     DiverElev =  428.139830 *100;


    elseif strcmp(DivLabel, 'PZ-Bank')
        PVC_Elev = 429.336 * 100; % m -> cm [total station transit 10/02/16]
        SCDiver_fil = 'C:\SecondCreekGit\2016_data\2016_10_02\CSV_edit\pzb_5_161005162131_J3507.CSV';

        ManualDate = '2016/10/02'; ManualTime = '12:45:00'; PVC_DepthToWater = 30.6; % cm
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2016/05/31'; DivStartTime = '11:30:00';  % nan: use top of file
        DivEndDate = '2016/10/02'; DivEndTime = '12:45:00';  % nan: use end of file
      %  DiverElev = 429.399170 *100;
    elseif strcmp(DivLabel, 'PZ-E')
        PVC_Elev = 429.538 * 100; % m -> cm [total station transit 10/02/16]
        SCDiver_fil = 'C:\SecondCreekGit\2016_data\2016_10_02\CSV_edit\pze_7_161005155935_M9447.CSV';

        ManualDate = '2016/10/01'; ManualTime = '14:00:00'; PVC_DepthToWater = 65; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2016/05/31'; DivStartTime = '09:00:00';  % nan: use top of file
        DivEndDate = '2016/10/01'; DivEndTime = '14:20:00';  % nan: use end of file
     %   DiverElev = 428.509250 *100;
    elseif strcmp(DivLabel, 'PZ-CW')
        PVC_Elev = 429.212 * 100; % m -> cm [total station transit 10/01/16 and 10/02/16]
        SCDiver_fil = 'C:\SecondCreekGit\2016_data\2016_10_02\CSV_edit\pzcw_8_161005160252_M9440.CSV';

        ManualDate = '2016/10/01'; ManualTime = '14:00:00'; PVC_DepthToWater = 33.6; % cm
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2016/06/04'; DivStartTime = '03:30:00';  % nan: use top of file
        DivEndDate = '2016/10/01'; DivEndTime = '14:00:00';  % nan: use end of file
      %  DiverElev = 427.338500*100;
    elseif strcmp(DivLabel, 'PZ-CC')
        PVC_Elev = 429.558 * 100; % m -> cm [total station transit averaged 10/01/16 and 10/02/16]
        SCDiver_fil = 'C:\SecondCreekGit\2016_data\2016_10_02\CSV_edit\pzcc_3_161005155030_M9438.CSV';

        ManualDate = '2016/10/01'; ManualTime = '13:00:00'; PVC_DepthToWater = 68.1; % cm
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2016/05/31'; DivStartTime = '09:30:00';  % nan: use top of file
        DivEndDate = '2016/10/01'; DivEndTime = '14:00:00';  % nan: use end of file
      %   DiverElev = 427.631000*100;
    elseif strcmp(DivLabel, 'PZ-CE')
        PVC_Elev = 429.342 * 100; % m -> cm [total station transit averaged 10/01/16 and 10/02/16]
        SCDiver_fil = 'C:\SecondCreekGit\2016_data\2016_10_02\CSV_edit\pzce_2_161005155637_M9506.CSV';

       ManualDate = '2016/10/01'; ManualTime = '14:15:00'; PVC_DepthToWater = 49.4; % cm
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2016/05/31'; DivStartTime = '09:30:00';  % nan: use top of file
        DivEndDate = '2016/09/30'; DivEndTime = '14:15:00';  % nan: use end of file
      %   DiverElev =  427.418500 *100;
%
%     elseif strcmp(DivLabel, 'A2')
%         PVC_Elev = 431.638 * 100; % m -> cm [level transit]
%         SCDiver_fil = 'C:\Users\Amanda\Desktop\Research\Diver\2016_05_30\CSV_edit\A2_160530download_data.csv';
% %         ManualDate = '2015/07/10'; ManualTime = '16:30:00'; PVC_DepthToWater = 8.82*12*2.54; % cm, corresp to end of y-stick venting
%         ManualDate = '2016/05/30'; ManualTime = '19:00:00'; PVC_DepthToWater = 8.25*12*2.54; % cm, corresp to end of y-stick venting
%         Div_Int_Min = 15; % time interval in min
%         DivStartDate = '2015/10/17'; DivStartTime = '17:00:00'; % nan: use start of file
%         DivEndDate = '2016/05/30'; DivEndTime = '19:00:00';  % nan: use end of file
% 
%     elseif strcmp(DivLabel, 'B1')
%         PVC_Elev = 431.083 * 100; % m -> cm [level transit]
%         SCDiver_fil = 'C:\Users\Amanda\Desktop\Research\Diver\2016_05_30\CSV_edit\B1_160530downlaod_data.csv'; % clipped out some 7/10 data (diver removed temporarily?)
% %         ManualDate = '2015/07/10'; ManualTime = '11:20:00'; PVC_DepthToWater = 7.04*12*2.54; % cm, corresp to end of y-stick venting
%         ManualDate = '2016/05/30'; ManualTime = '19:00:00'; PVC_DepthToWater = 6.51*12*2.54; % cm, corresp to end of y-stick venting
%         Div_Int_Min = 15; % time interval in min
%         DivStartDate = '2015/10/17'; DivStartTime = '17:00:00'; % nan: use start of file
%         DivEndDate = '2016/05/30'; DivEndTime = '19:00:00';  % nan: use end of file
% 
%     elseif strcmp(DivLabel, 'C1')
%         PVC_Elev = 431.348 * 100; % m -> cm [level transit]
%         SCDiver_fil = 'C:\Users\Amanda\Desktop\Research\Diver\2016_05_30\CSV_edit\C1_160530download_data.csv'; % clipped out some 7/10 data (diver removed temporarily?)
% %         ManualDate = '2015/07/10'; ManualTime = '11:30:00'; PVC_DepthToWater = 7.32*12*2.54; % cm, corresp to end of y-stick venting
%         ManualDate = '2016/05/30'; ManualTime = '19:00:00'; PVC_DepthToWater = 6.52*12*2.54; % cm, corresp to end of y-stick venting
%         Div_Int_Min = 15; % time interval in min
%         DivStartDate = '2015/10/17'; DivStartTime = '17:00:00'; % nan: use start of file
%         DivEndDate = '2016/05/30'; DivEndTime = '19:00:00';  % nan: use end of file
% 
%     elseif strcmp(DivLabel, 'D1')
%         PVC_Elev = 432.476 * 100; % m -> cm [level transit]
%         SCDiver_fil = 'C:\Users\Amanda\Desktop\Research\Diver\2016_05_30\CSV_edit\D1_160530download_data.csv'; % clipped out some 7/10 data (diver removed temporarily?)
% %         ManualDate = '2015/07/10'; ManualTime = '12:10:00'; PVC_DepthToWater = 10.68*12*2.54; % cm
%         ManualDate = '2016/05/30'; ManualTime = '19:15:00'; PVC_DepthToWater = 9*12*2.54; % cm
% %         ManualDate = '2015/08/12'; ManualTime = '19:20:00'; PVC_DepthToWater = 9.98*12*2.54; % cm
%         Div_Int_Min = 15; % time interval in min
%         DivStartDate = '2015/10/17'; DivStartTime = '17:00:00'; % nan: use start of file
%         DivEndDate = '2016/05/30'; DivEndTime = '19:15:00';  % nan: use end of file
% 
%     elseif strcmp(DivLabel, 'E1')
%         PVC_Elev = 429.903 * 100; % m -> cm [level transit 10/17]
%         SCDiver_fil = 'C:\Users\Amanda\Desktop\Research\Diver\2016_05_30\CSV_edit\E1_160530download_data.csv'; 
% %         ManualDate = '2015/07/10'; ManualTime = '16:40:00'; PVC_DepthToWater = 5.36*12*2.54; % cm, corresp to end of y-stick venting
%         ManualDate = '2016/05/30'; ManualTime = '19:30:00'; PVC_DepthToWater = 4.69*12*2.54; % cm, corresp to end of y-stick venting
%         Div_Int_Min = 15; % time interval in min
%         DivStartDate = '2015/10/17'; DivStartTime = '17:00:00'; % nan: use start of file
%         DivEndDate = '2016/05/30'; DivEndTime = '19:30:00';  % nan: use end of file
    else
        fprintf('No data file for %s; exiting... \n', date_label);
        return
    end

    % *********************

    SCBaro_fil = 'C:\SecondCreekGit\DATA\2016_head_data\2016_10_02\CSV_edit\a2_baro_161005161148_M9484.csv';
    
    

    Baro_Int_Min = 15; % time interval in min
        
end
%% ========================================================================

% read files
fid = fopen(SCDiver_fil, 'r');
DDiv = textscan(fid, '%s%s%f%f', 'Delimiter', {' ', ','});
fclose(fid);

fid = fopen(SCBaro_fil, 'r');
DBar = textscan(fid, '%s%s%f%f', 'Delimiter', {' ', ','});
fclose(fid);

% get matching dates
if isnan(DivStartDate)
    Div_ind1 = 1;
else
    Div_ind1 = find(strcmp(DDiv{1}, DivStartDate) & strcmp(DDiv{2}, DivStartTime));
end
while(1)
    Bar_ind1 = find(strcmp(DDiv{1}(Div_ind1), DBar{1}) & strcmp(DDiv{2}(Div_ind1), DBar{2}),1);
    if isempty(Bar_ind1)
        Bar_ind1 = 1;
        Div_ind1 = find(strcmp(DBar{1}(Bar_ind1), DDiv{1}) & strcmp(DBar{2}(Bar_ind1), DDiv{2}),1);
    end
    if isempty(Div_ind1)
        Div_ind1 = Div_ind1 + 1; % try another time
        if Div_ind1 == 0                
            fprintf('Error, do Diver and Baro have same time interval (1)? exiting...\n');
            return
        end
    else
        break
    end
end

if isnan(DivEndDate)
    Div_ind2_0 = length(DDiv{1});
else
    Div_ind2_0 = find(strcmp(DDiv{1}, DivEndDate) & strcmp(DDiv{2}, DivEndTime));
end
count = 0;
while(1)
     Div_ind2 = length(DDiv{1}) - count;
    Div_ind2 = Div_ind2_0 - count;
    Bar_ind2 = find(strcmp(DDiv{1}(Div_ind2), DBar{1}) & strcmp(DDiv{2}(Div_ind2), DBar{2}),1);
    if isempty(Bar_ind2)
        Bar_ind2 = length(DBar{1}) - count;
        Div_ind2 = find(strcmp(DBar{1}(Bar_ind2), DDiv{1}) & strcmp(DBar{2}(Bar_ind2), DDiv{2}),1);
    end
    if ~isempty(Div_ind2)
        break,
    else
        if Div_ind2 == 0
            fprintf('Error, do Diver and Baro have same time interval (2)? exiting...\n');
            return
        end
    end
    count = count + 1;
end

DivDate = DDiv{1}(Div_ind1:Div_ind2); % 
DivTime = DDiv{2}(Div_ind1:Div_ind2); % 
DivPress = DDiv{3}(Div_ind1:Div_ind2); % cm
DivTemp = DDiv{4}(Div_ind1:Div_ind2); % C
BarPress = DBar{3}(Bar_ind1:Bar_ind2); % cm
BarTemp = DBar{4}(Bar_ind1:Bar_ind2); % C

% correct for mismatched time interval, interp BarTemp
Bar_time_orig = [0:Baro_Int_Min:Baro_Int_Min*(length(BarPress)-1)]';
Bar_time_new = [0:Div_Int_Min:Div_Int_Min*(length(DivPress)-1)]';
BarPress = interp1(Bar_time_orig, BarPress, Bar_time_new);
BarTemp = interp1(Bar_time_orig, BarTemp, Bar_time_new);

% time
DivDateTime = [cell2mat(DivDate), repmat(' ', size(DivDate,1), 1), cell2mat(DivTime)];
DivDateTime_num = datenum(DivDateTime);

% correct atmos pressure
DivPress_compensated = DivPress - BarPress;  % cm

% plot

time_d = [0:length(DivPress_compensated)-1] * Div_Int_Min / (60*24);

subplot(2,1,1),
% plot(time_d, DivPress), title('Diver press [cm]');
% xlabel('time [d]');
plot(DivDateTime_num, DivPress), title('Diver press [cm]');
datetick('x', 6);

subplot(2,1,2),
plot(DivDateTime_num, BarPress), title('Baro press [cm]');
datetick('x', 6);


% get DiverDepth (down from top of PVC) and DiverElev [cm]
ind_end = find(strcmp(ManualDate, DivDate) & strcmp(ManualTime, DivTime));

DiverDepth = PVC_DepthToWater + DivPress_compensated(ind_end);     %unnecessary now that depths are mannualy assigned 2/7/17
DiverElev = PVC_Elev - DiverDepth; % cm


% general filename
a  = ManualDate([1:4, 6:7, 9:10]);
b = ManualTime([1:2, 4:5]);
filename0 = [DivLabel, '_', date_label, '_Calib', a, '_', b];

figure(2)
% subplot(3,1,3),
plot(DivDateTime_num, DivPress_compensated), 
title(DivLabel);
ylabel('Compensated Press [cm]');
datetick('x', 6);
figname = [filename0, '_CompPress.tiff'];
print('-dtiff', figname);

filname = [filename0, '_CalibResult.txt'];
for ii = 1:2
    if ii == 1,
        fid = 1;
    elseif ii == 2
        fid = fopen(filname, 'wt');
    end
    fprintf(fid, '----------------------------------------------\n');
    fprintf(fid, '%s on %s, %s: \n', DivLabel, ManualDate, ManualTime);
    fprintf(fid, '   Manual Depth to Water: %10.6f m (%g ft)\n', PVC_DepthToWater/100, PVC_DepthToWater/2.54/12);
    fprintf(fid, '   TOC Elev: %10.6f m (%g ft)\n', PVC_Elev/100, PVC_Elev/2.54/12);
    fprintf(fid, '   Diver Elev: %10.6f m (%g ft)\n', DiverElev/100, DiverElev/2.54/12);
    fprintf(fid, '   Diver TotHead: %10.6f m (%g ft)\n', (DiverElev+DivPress_compensated(ind_end))/100, (DiverElev+DivPress_compensated(ind_end))/2.54/12);
    fprintf(fid, '----------------------------------------------\n\n');
end
fclose(fid);

% get TotHead
TotHead = DivPress_compensated + DiverElev; % cm
figure(3)
% subplot(3,1,3),
plot(DivDateTime_num, TotHead/100), 
title(DivLabel);
ylabel('TotHead [m asl]');
datetick('x', 6);
xtickv = get(gca,'XTick');
xlimv = get(gca,'XLim');
figname = [filename0 '_TotHead.tiff'];
print('-dtiff', figname);

filname = [filename0, '_TotHead.txt'];
for ii = 2:2
    if ii == 1,
        fid = 1;
    elseif ii == 2
        fid = fopen(filname, 'wt');
    end
    a = cell2mat(DivDate); b = cell2mat(DivTime);
    fprintf(fid, '----------------------------------------------\n');
    fprintf(fid, '%s TotHead [m]: \n', DivLabel);
    for jj = 1: length(DivPress_compensated)
        fprintf(fid, '    %s %s %10.6f \n', a(jj,:), b(jj,:)', (DiverElev+DivPress_compensated(jj))/100);
    end
    fprintf(fid, '----------------------------------------------\n\n');
end
fclose(fid);

filname = [filename0, '_results'];
DivTotHead = DiverElev+DivPress_compensated; % cm
save(filname, 'DivLabel', 'DivDateTime', 'DivPress_compensated', 'DivTotHead', 'DivTemp');

%% ------------------------------------------------------------------------
% PLOT PRECIP DATA
% 
% infile = 'C:\Users\Amanda\Desktop\Research\Scripts\diver\Weather_EmbarrassMN_150501_151016.csv';
% 
% fid = fopen(infile, 'r');
% for ii = 1: 8, line = fgets(fid); end  % remove header lines
% % return
% D = textscan(fid, '%s%s%s%s%s%s', 'Delimiter', {' ', ','});
% fclose(fid);
% 
% 
% fprintf('Setting trace to 0, missing data to nan...\n');
% 
% for loop = 1:5
%     a = D{loop+1};
%     b = nan(length(a),1);
%     for ii = 1: length(a)
%         if strcmp(D{1}{ii}, 'Sum:')
%             N = ii-1;
%             break
%         end
%         if strcmp(a{ii}, 'T')
%             b(ii) = 0;
%         elseif ~strcmp(a{ii}, 'M')
%             b(ii) = str2double(a{ii});
%         end    
%     end
%     switch loop
%         case 1, precip_in = b(1:N);
%         case 2, snowfall_in = b(1:N);
%         case 3, snowdepth_in = b(1:N);
%         case 4, maxT_F = b(1:N);
%         case 5, minT_in = b(1:N);
%     end
% end
% datestr_v = D{1}(1:N);
% 
% datenum_v = datenum(datestr_v);
% 
% figure(1), orient landscape
% subplot(3,1,1)
% plot(datenum_v, precip_in), 
% title('Daily precip (in)');
% datetick('x',6);
% set(gca,'XTick', xtickv, 'XLim', xlimv);
