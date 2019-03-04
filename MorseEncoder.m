%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title  : Pulse Morse Encoder
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;close all;clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Program Constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tempInt  = randi([16 24], 1, 1); % creating a tempory integer to store a random value between 16 and 24
SAMPLE_RATE   = 8000;
TIME_UNIT     = tempInt/100; % time is equal to the tempory integer divided by 100
DIT_DURATION  = TIME_UNIT*2;
DAH_DURATION  = TIME_UNIT*4;
ILI_DURATION1 = TIME_UNIT*1; % intra-Letter interval
ILI_DURATION2 = TIME_UNIT*2; % inter-Letter interval
IWI_DURATION  = TIME_UNIT*4; % inter-Word interval

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create Pulse Components for Stitching Together
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dit  = ones (1, SAMPLE_RATE*DIT_DURATION);
dah  = ones (1, SAMPLE_RATE*DAH_DURATION);
ili1 = zeros(1, SAMPLE_RATE*ILI_DURATION1);
ili2 = zeros(1, SAMPLE_RATE*ILI_DURATION2);
iwi  = zeros(1, SAMPLE_RATE*IWI_DURATION);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ask User for Message 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

textToEncode    = input('Enter Text to Encode: ', 's'); % Get User Input

textToEncode    = upper(textToEncode); % Make UPPER CASE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Loop: Encode Message (Build Pulse Wave)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

outputPulse     = [];
messageDuration = 0;

currentCharacter = 1;


while(textToEncode(currentCharacter) == ' ')
                
  currentCharacter = currentCharacter + 1;

end


for newCurrentCharacter=currentCharacter:length(textToEncode)
   if(textToEncode(newCurrentCharacter)>='A' && textToEncode(newCurrentCharacter)<='Z')
        currentCode = letterToCode(textToEncode(newCurrentCharacter));
        fprintf(1, textToEncode(newCurrentCharacter));
        for currentCodePosition=1:length(currentCode)
            if(currentCode(currentCodePosition)=='.')
                outputPulse = [outputPulse dit ili1];
                messageDuration = messageDuration + DIT_DURATION + ILI_DURATION1;
                fprintf(1, '.');
            else
                outputPulse = [outputPulse dah ili1];
                messageDuration = messageDuration + DAH_DURATION + ILI_DURATION1;
                fprintf(1, '-');
            end
        end
        outputPulse = [outputPulse ili2];
        messageDuration = messageDuration + ILI_DURATION2;
    else
        outputPulse = [outputPulse iwi];
        messageDuration = messageDuration + IWI_DURATION;
        fprintf(1, '\n');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Store Encoded Pulse Wave to Disk
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

audiowrite('encodedMessage.wav', outputPulse, SAMPLE_RATE);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot a Graph Showing hte Encoded Pulse Wave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;

t = 0:1/SAMPLE_RATE:messageDuration;
plot(t(1:length(outputPulse)), outputPulse, 'r', 'LineWidth', 2);
ylabel('Amplitude', 'FontSize', 14);
xlabel('Time (s)', 'FontSize', 14);
ylim([0 1.5]);
xlim([0 messageDuration]);
title('Morse Pulse Wave', 'FontSize', 14);
%wavwrite(outputPulse, SAMPLE_RATE, 8, 'encodedMessage.wav');
