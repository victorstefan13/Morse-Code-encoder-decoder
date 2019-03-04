function [] = play_message(amplitude,SAMPLE_RATE)

dt = 1/SAMPLE_RATE; %get the time for one sample
freq=900; %setting the frequency at 900 
time = dt:dt:length(amplitude)/SAMPLE_RATE;%gets length of the message
signal = sin(2*pi*freq*time); %producing the sine signal to play

for j = 1:length(amplitude)   
    %x at the index of j is equal to amplitude at the index j 
    %times signal at the index j
    x(j) = amplitude(j)*signal(j);
end
sound(x, (3.5*SAMPLE_RATE)); % play the sine wave and times it by 3.5 to speed it up.

%plot the figure with time vs amplitude. 
figure; 
plot(time, amplitude, 'r', 'LineWidth', 2); 
xlabel('Time (s)'); 
ylabel('Amplitude'); ylim([0 1.5]);
title('Morse Pulse Wave', 'FontSize', 14);

end

