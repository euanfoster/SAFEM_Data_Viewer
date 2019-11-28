function  [SH, Tors, Long, Flex] = fn_transpose_data(SH_table, Long_table, Tors_table, Flex_table)

%SUMMARY
%   Removes duplicate solutions from SAFEM CODE
%   Each Frequency bin is a new sheet containing the following columns
%   A being the eigenvalue, B being the eneryg velocity of the weld,
%   C beig the weld Power, D being the external power, E being the filter
%   G being the weld classification and H being the Order
%USAGE
%	refined_sols = fn_refined_sols(filename, range)
%AUTHOR
%	Euan Foster (2019)
%OUTPUTS
% A struct where the indexing correspond to a Frequency bin containing
% only unique eigen values and related parameters (i.e. it removes
% duplicate solutions)
%INPUTS
%   filename    -   Name of the excel spread sheet
%   sheetname   -   A string array that contains the name of each sheet.
%   range       -   Range over which the data in each sheet is to be read
%   freq        -   An array of all Frequency bins.
%NOTE
% sheetname and freq should be the same size of array
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SH = struct('Frequency',[],'WaveNumber',[],'Attenuation',[],...
    'PhaseVel',[],'WaveLength',[],'EnergyVelocityAll',[],'EnergyVelocityWeld',...
    [],'Order',[]);

count = 1;
for i = 0:max(SH_table.Order)
    
    SH(count).Order =  SH_table(SH_table.Order == i,:).Order(1);
    SH(count).Frequency = SH_table(SH_table.Order == i,:).Frequency;
    SH(count).PhaseVel = SH_table(SH_table.Order == i,:).PhaseVel;
    SH(count).WaveNumber = SH_table(SH_table.Order == i,:).WaveNumber;
    SH(count).WaveLength = SH_table(SH_table.Order == i,:).WaveLength;
    SH(count).Attenuation = SH_table(SH_table.Order == i,:).Attenuation;
    SH(count).EnergyVelocityAll = SH_table(SH_table.Order == i,:).EnergyVelocityAll;
    SH(count).EnergyVelocityWeld = SH_table(SH_table.Order == i,:).EnergyVelocityWeld;
    
    count = count + 1;
end

%Initialising Struct - indexed on solutions found at each Frequency
Long = struct('Frequency',[],'WaveNumber',[],'Attenuation',[],...
    'PhaseVel',[],'WaveLength',[],'EnergyVelocityAll',[],'EnergyVelocityWeld',...
    [],'Order',[]);

count = 1;
for i = 0:max(Long_table.Order)
    
    Long(count).Order =  Long_table(Long_table.Order == i,:).Order(1);
    Long(count).Frequency = Long_table(Long_table.Order == i,:).Frequency;
    Long(count).PhaseVel = Long_table(Long_table.Order == i,:).PhaseVel;
    Long(count).WaveNumber = Long_table(Long_table.Order == i,:).WaveNumber;
    Long(count).WaveLength = Long_table(Long_table.Order == i,:).WaveLength;
    Long(count).Attenuation = Long_table(Long_table.Order == i,:).Attenuation;
    Long(count).EnergyVelocityAll = Long_table(Long_table.Order == i,:).EnergyVelocityAll;
    Long(count).EnergyVelocityWeld = Long_table(Long_table.Order == i,:).EnergyVelocityWeld;
    
    count = count + 1;
end

%Initialising Struct - indexed on solutions found at each Frequency
Flex = struct('Frequency',[],'WaveNumber',[],'Attenuation',[],...
    'PhaseVel',[],'WaveLength',[],'EnergyVelocityAll',[],'EnergyVelocityWeld',...
    [],'Order',[]);


count = 1;
for i = 0:max(Flex_table.Order)

    Flex(count).Order =  Flex_table(Flex_table.Order == i,:).Order(1);
    Flex(count).Frequency = Flex_table(Flex_table.Order == i,:).Frequency;
    Flex(count).PhaseVel = Flex_table(Flex_table.Order == i,:).PhaseVel;
    Flex(count).WaveNumber = Flex_table(Flex_table.Order == i,:).WaveNumber;
    Flex(count).WaveLength = Flex_table(Flex_table.Order == i,:).WaveLength;
    Flex(count).Attenuation = Flex_table(Flex_table.Order == i,:).Attenuation;
    Flex(count).EnergyVelocityAll = Flex_table(Flex_table.Order == i,:).EnergyVelocityAll;
    Flex(count).EnergyVelocityWeld = Flex_table(Flex_table.Order == i,:).EnergyVelocityWeld;
    
    count = count + 1;
end

%Initialising Struct - indexed on solutions found at each Frequency
Tors = struct('Frequency',[],'WaveNumber',[],'Attenuation',[],...
    'PhaseVel',[],'WaveLength',[],'EnergyVelocityAll',[],'EnergyVelocityWeld',...
    [],'Order',[]);


count = 1;
for i = 0:max(Tors_table.Order)

    Tors(count).Order =  Tors_table(Tors_table.Order == i,:).Order(1);
    Tors(count).Frequency = Tors_table(Tors_table.Order == i,:).Frequency;
    Tors(count).PhaseVel = Tors_table(Tors_table.Order == i,:).PhaseVel;
    Tors(count).WaveNumber = Tors_table(Tors_table.Order == i,:).WaveNumber;
    Tors(count).WaveLength = Tors_table(Tors_table.Order == i,:).WaveLength;
    Tors(count).Attenuation = Tors_table(Tors_table.Order == i,:).Attenuation;
    Tors(count).EnergyVelocityAll = Tors_table(Tors_table.Order == i,:).EnergyVelocityAll;
    Tors(count).EnergyVelocityWeld = Tors_table(Tors_table.Order == i,:).EnergyVelocityWeld;
    
    count = count + 1;
end


end
