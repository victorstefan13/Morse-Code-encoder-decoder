function [TIME_UNIT] = get_time(amplitude,SAMPLE_RATE) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start the iterator at 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i = 1; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%while amplitude is not equal to 0 increment i by 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while (amplitude(i) ~= 0)
    i = i + 1;
end

i = i - 1; %take away 1 from i 

%if i is higher or equal to 5120
if (i >= 5120) 
    %time unit is equal to i divided by sample rate times 4
    TIME_UNIT = i / (SAMPLE_RATE*4); 
else
    %time unit is equal to i divided by sample rate times 2
    TIME_UNIT = i / (SAMPLE_RATE*2);
    
end
end

