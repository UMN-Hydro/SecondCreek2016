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
% date_label = '161005';
date_label = '2017';
% - Choose one transducer
% DivLabel = 'PZCC';
 DivLabel = 'PZCE';
% DivLabel = 'PZCW';
% DivLabel = 'PZEZ';
% DivLabel = 'PZIZ';
% DivLabel = 'PZPE';
% DivLabel = 'PZPW';
% DivLabel = 'SG-2';
% DivLabel = 'SG-1';

% =========================
% 10/01/16
% =========================

if strcmp(date_label, '2017')           
% date_label = '161005';



   if strcmp(DivLabel, 'PZCC') 
        here = 'made it in'
        PVC_Elev = 429.494 * 100; % m -> cm [total station transit 10/01/16]
        SCDiver_fil = 'C:\SecondCreekGit\2017 Summer data dump\Edited txt files\ready for SCDive\PZCC_171026105654_M3583.csv';
%         ManualDate = '2015/06/25'; ManualTime = '16:30:00'; PVC_DepthToWater = 75; % cm
%         ManualDate = '2015/07/10'; ManualTime = '09:30:00'; PVC_DepthToWater = 88.7; % cm
        ManualDate = '2017/06/09'; ManualTime = '14:00:00'; PVC_DepthToWater = 97.2; % cm 
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2017/05/25'; DivStartTime = '14:50:00';  % nan: use top of file
        DivEndDate = '2017/10/21'; DivEndTime = '11:10:00';  % nan: use end of file
     %      DiverElev =  428.111420*100;
    % *********************

    elseif strcmp(DivLabel, 'PZCE') 
        PVC_Elev = 429.176 * 100; % m -> cm [total station transit 10/01/16]
        SCDiver_fil = 'C:\SecondCreekGit\2017 Summer data dump\Edited txt files\ready for SCDive\PZCE_171026103152_M9447.csv';
        ManualDate = '2017/06/09'; ManualTime = '13:00:00'; PVC_DepthToWater = 66.3; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2017/05/25'; DivStartTime = '15:00:00';  % nan: use top of file
        DivEndDate = '2017/10/21'; DivEndTime = '11:00:00';  % nan: use end of file
      %  DiverElev =  428.087250*100;
    
    elseif strcmp(DivLabel, 'PZCW')
        PVC_Elev =429.464* 100; % m -> cm [total station transit 10/02/16]
        SCDiver_fil = 'C:\SecondCreekGit\2017 Summer data dump\Edited txt files\ready for SCDive\PZCW_171026104348_M9506.csv';
 %      ManualDate = '2016/05/31'; ManualTime = '09:15:00'; PVC_DepthToWater = 55.7; % cm (DO NOT TRUST BC FLOODED AND BUBBLES WHEN CAP REMOVED)  
        ManualDate = '2017/06/09'; ManualTime = '14:00:00'; PVC_DepthToWater = 92.6; % cm (ED)  
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2017/05/25'; DivStartTime = '14:45:00';  % nan: use top of file
        DivEndDate = '2017/10/21'; DivEndTime = '11:00:00';  % nan: use end of file
   %     DiverElev =  428.139830 *100;


    elseif strcmp(DivLabel, 'PZEZ')
        PVC_Elev = 429.424 * 100; % m -> cm [total station transit 10/02/16]
        SCDiver_fil = 'C:\SecondCreekGit\2017 Summer data dump\Edited txt files\ready for SCDive\PZEZ_171026102257_M9484.csv';
        ManualDate = '2017/06/09'; ManualTime = '14:00:00'; PVC_DepthToWater = 90.5; % cm
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2017/05/25'; DivStartTime = '17:30:00';  % nan: use top of file
        DivEndDate = '2017/10/21'; DivEndTime = '11:15:00';  % nan: use end of file
      %  DiverElev = 429.399170 *100;
  
    elseif strcmp(DivLabel, 'PZIZ')
        PVC_Elev = 429.624* 100; % m -> cm [total station transit 10/02/16]
        SCDiver_fil = 'C:\SecondCreekGit\2017 Summer data dump\Edited txt files\ready for SCDive\PZI2_171026103639_M9438.csv';
        ManualDate = '2017/06/09'; ManualTime = '14:30:00'; PVC_DepthToWater = 114.4; % cm
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2017/05/25'; DivStartTime = '17:45:00';  % nan: use top of file
        DivEndDate = '2017/10/21'; DivEndTime = '10:30:00';  % nan: use end of file
     %   DiverElev = 428.509250 *100;
  
    elseif strcmp(DivLabel, 'PZPE')
        PVC_Elev = 429.528; % m -> cm [total station transit 10/01/16 and 10/02/16]
        SCDiver_fil = 'C:\SecondCreekGit\2017 Summer data dump\Edited txt files\ready for SCDive\pzpe_171026110611_H2366.csv';
        ManualDate = '2017/06/09'; ManualTime = '13:45:00'; PVC_DepthToWater = 89.9; % cm
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2017/06/09'; DivStartTime = '12:30:00';  % nan: use top of file
        DivEndDate = '2017/10/21'; DivEndTime = '12:150:00';  % nan: use end of file
      %  DiverElev = 427.338500*100;
 
    elseif strcmp(DivLabel, 'PZPW')
        PVC_Elev = 429.828 * 100; % m -> cm [total station transit averaged 10/01/16 and 10/02/16]
        SCDiver_fil = 'C:\SecondCreekGit\2017 Summer data dump\Edited txt files\ready for SCDive\pzpw_171026105158_M9440.csv';
        ManualDate = '2017/06/09'; ManualTime = '14:30:00'; PVC_DepthToWater = 125; % cm
        Div_Int_Min = 15; % time interval in min
        DivStartDate = '2017/06/09'; DivStartTime = '12:15:00';  % nan: use top of file
        DivEndDate = '2017/10/21'; DivEndTime = '11:45:00';  % nan: use end of file
      %   DiverElev = 427.631000*100;
  
    elseif strcmp(DivLabel, 'SG-2')
        PVC_Elev = 429.484 * 100; % m -> cm [total station transit averaged 10/01/16 and 10/02/16]
        SCDiver_fil = 'C:\SecondCreekGit\2017 Summer data dump\Edited txt files\ready for SCDive\SG_171026111310_M9505.csv';
        ManualDate = '2017/06/09'; ManualTime = '15:00:00'; PVC_DepthToWater = 100.2; % cm
        Div_Int_Min = 10; % time interval in min
        DivStartDate = '2017/05/25'; DivStartTime = '15:40:00';  % nan: use top of file
        DivEndDate = '2017/10/211'; DivEndTime = '12:00:00';  % nan: use end of file
      %   DiverElev = 427.631000*100;
    
    
    
    
    
    
    

    else
        fprintf('No data file for %s; exiting... \n', date_label);
        return
    end

    % *********************

    SCBaro_fil = 'C:\SecondCreekGit\2017 Summer data dump\atmospheric_pressure.csv';
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
stuck = 0
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
       
        stuck= stuck + 1
       
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
