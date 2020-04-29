close all
clear all

%Read in Data
T = readtable('Results.xlsx');

%% Remove Duplicate Results
comp = strcmp(T.WaveClassification,'None');
T = T(comp == 0,:);

%Converting Columns to numeric values
%T.Order = str2double(T.Order);
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
count = 1;
for i = 1:length(SH)
    order = 20;
    
    
    [p,~,mu] = polyfit(SH(i).Frequency,SH(i).PhaseVel, order);
    f = polyval(p,SH(i).Frequency,[],mu);
    f = smooth(f,5);
    hold on
    plot(SH(i).Frequency/1e3,f,'-d','LineWidth',2)
    
    leg{count} = strcat('SH',num2str(SH(i).Order));
    count = count + 1;
end

xlabel('Frequency (KHz)')
ylabel('Phase Velocity (m/s)')
ylim ([2750, 11000])
legend(leg)

%Plotting Frequency V Energy Vel
figure(02)

count = 1;
for i = 1:length(SH)
    order = 20;
    
    if i == 5
        order = 10;
    end
    
    [p,~,mu] = polyfit(SH(i).Frequency,SH(i).EnergyVelocityWeld, order);
    f = polyval(p,SH(i).Frequency,[],mu);
    if i == 1 || i == 2 || i == 4
        f = smooth(f,10);
    end
    hold on
    plot(SH(i).Frequency/1e3,f,'-d','LineWidth',2)
    
    leg{count} = strcat('SH',num2str(SH(i).Order));
    count = count + 1;
end

xlabel('Frequency (KHz)')
ylabel('Energy Velocity (m/s)')
ylim ([0, 4000])
legend(leg)

figure(03)
%Plotting Frequency V Attenuation
count = 1;
for i = 1:length(SH)
    order = 20;
    
    if length(SH(i).Frequency) < 40
        order  = length(SH(i).Frequency);
    end
    [p,~,mu] = polyfit(SH(i).Frequency,SH(i).Attenuation, order);
    f = polyval(p,SH(i).Frequency,[],mu);
    hold on
    plot(SH(i).Frequency/1e3,f,'-d','LineWidth',2)
    
    leg{count} = strcat('SH',num2str(SH(i).Order));
    count = count + 1;
end

xlabel('Frequency (KHz)')
ylabel('Attenuation (Np/m)')
ylim ([-0.5, 4])
legend(leg)
