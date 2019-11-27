close all
clear all

%Read in Data
T = readtable('Results.xlsx');

%% Remove Duplicate Results
comp = strcmp(T.WaveClassification,'None');
T = T(comp == 0,:);

%Converting Columns to numeric values
T.Order = str2double(T.Order);
T.EigenValue = str2double(T.EigenValue);
%% Removing Duplicate solutions
eigen = round(T.EigenValue,3);
x = unique(eigen);                  %finding uniques values in m array only

%Logging all indexes of the first unique value
indx = zeros(length(x),1);
for i = 1:size(indx,1)
   indx(i,1) =  find( eigen(:,1) == x(i,1),1,'first');
end
%Sorting the index array in ascending order
indx = sort(indx);

T = T(indx,:);

%% Creata Mode Map & other variables
key_set = {'Shear Horizontal','Longitudinal','Flexural','Torsional'};
value_set = [0 1 2 3];
mode_map = containers.Map(key_set,value_set);

ModeMap = zeros(size(T,1),1);
PhaseVel = zeros(size(T,1),1);
Attenuation = zeros(size(T,1),1);
WaveNumber = zeros(size(T,1),1);
WaveLength = zeros(size(T,1),1);

for ii = 1:size(T,1)
    ModeMap(ii) = mode_map(T.WaveClassification{ii});
    WaveNumber(ii) = real(T.EigenValue(ii));
    Attenuation(ii) = abs(imag(T.EigenValue(ii)));
    PhaseVel(ii) = 2*pi*T.Frequency(ii)/WaveNumber(ii);
    WaveLength(ii) = 2*pi/WaveNumber(ii);
end

T_wavemode = addvars(T,ModeMap,PhaseVel, Attenuation, WaveNumber, WaveLength);
%clear ModeMap PhaseVel Attenuation WaveNumber WaveLength
%% Subdividing table into individual tables 
SH_table = T_wavemode(T_wavemode.ModeMap==0,:);
Long_table = T_wavemode(T_wavemode.ModeMap==1,:);
Flex_table = T_wavemode(T_wavemode.ModeMap==2,:);
Tors_table = T_wavemode(T_wavemode.ModeMap==3,:);

%% Transposing data into structs based on classification
[SH, Tors, Long, Flex] = fn_transpose_data(SH_table, Long_table, Tors_table, Flex_table);

%% Graphing Dispersion
%Plotting Frequency V Phase Vel
figure(01)
%%Shear Horizontal
for i = 1:length(SH)  
    [p,~,mu] = polyfit(SH(i).Frequency,SH(i).PhaseVel, 20);
    f = polyval(p,SH(i).Frequency,[],mu);
    hold on
    plot(SH(i).Frequency/1e3,f,'-d','LineWidth',2)
end
%Longitudinal
for i = 1:length(Long)
    [p,~,mu] = polyfit(Long(i).Frequency,Long(i).PhaseVel, 20);
    f = polyval(p,Long(i).Frequency,[],mu);
    hold on
    plot(Long(i).Frequency/1e3,f,'-d','LineWidth',2)
end
%Flexural
for i = 1:length(Flex)
    [p,~,mu] = polyfit(Flex(i).Frequency,Flex(i).PhaseVel, 20);
    f = polyval(p,Flex(i).Frequency,[],mu);
    hold on
    plot(Flex(i).Frequency/1e3,f,'-d','LineWidth',2)
end
%Torsional
for i = 1:length(Tors)
    [p,~,mu] = polyfit(Tors(i).Frequency,Tors(i).PhaseVel, 20);
    f = polyval(p,Tors(i).Frequency,[],mu);
    hold on
    plot(Tors(i).Frequency/1e3,f,'-d','LineWidth',2)
end
xlabel('Frequency (KHz)')
ylabel('Phase Velocity (m/s)')
ylim ([2750, 11000])
legend('SH0', 'SH1', 'SH2', 'L0', 'L1' , 'F0', 'F1', 'T0', 'T1')