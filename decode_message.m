function [finalMessage] = decode_message(TIME_UNIT,SAMPLE_RATE, amplitude)
%
%

DIT_DURATION  = TIME_UNIT*2; %size of dit (.)
DAH_DURATION  = TIME_UNIT*4; %size of dash (-)
ILI_DURATION1 = TIME_UNIT*1; % intra-Letter interval
ILI_DURATION2 = TIME_UNIT*2; % inter-Letter interval

dit  = ones (1, SAMPLE_RATE*DIT_DURATION); %length of dit
dah  = ones (1, SAMPLE_RATE*DAH_DURATION); %length of dah
ili1 = zeros(1, SAMPLE_RATE*ILI_DURATION1); %length of ili1
ili2 = zeros(1, SAMPLE_RATE*ILI_DURATION2); %length of ili2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Setting variables which will be used for the iteration later
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
high = 0;
low = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Defining the strings needed to decode the message
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1 = '.';
s2 = '-';
str = '';
message = ' ';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using a for loop to iterate though each index of the signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:length(amplitude)
    
%if amplitude at index j(j being a number between 1 and the length of
%amplitude) is higher or equal to 8 increment high by 1
    if(amplitude(j) >= 0.8)
        high = high + 1;
        
%if amplitude at index j(j being a number between 1 and the length of
%amplitude) is lower than or equal to 0.2 increment low by 1
    elseif(amplitude(j) <= 0.2)
        low = low +1; 
    end
    
 %if low is equal to the number of elements in ili2 variable, print
 %string str(which is the morse code from the encoder) convert the message
 %and empty all strings
    if(low == numel(ili2))
        %print the morse code to the user
        fprintf('%s', str);
        % convert str to letters and store in tempstr
        tempstr = codeToLetter(str);
        %using string concatenation to merge the currennt content of 
        %variable message with the content of variable tempstr
        message = strcat(message, tempstr);
        %resetting variables ready to be used for next iteration
        str = ' '; 
        tempstr = ' ';
        low = 0;    
 %if low is equal to the number of elements in ili1 variable, check to see
 %if high is eqaul to the number of elements in dah or dit and use string
 %concatenation to copy the correct sub-character ("." or "-") to str
    elseif(low == numel(ili1))
        if(high == numel(dah)) %if high is equal to the number of elements in vector dah
            %using string concatenation to merge the currennt content of 
            %variable s2 (which is "-") with the content of variable str
            str = strcat(str, s2); 
            %reset the variables ready to be used for next iteration
            high = 0;
            low = 0;
        elseif(high == numel(dit)) % %if high is equal to the number of elements in vector dit
            %using string concatenation to merge the currennt content of 
            %variable s1 (which is ".") with the content of variable str
            str = strcat(str, s1);
            %reset the variables ready to be used for next iteration
            high = 0;
            low = 0;
        end            
    end
end

%replace any "??" with spaces.
finalMessage = replace(message, '??', ' ');

end
