function [fx] = puretone(x,y)
fs=16000; %sampling rate
dur=y; %number of seconds
t=linspace(0,dur,(dur*fs)); %create time vector of duration "dur"
w=sin(t*2*pi*x);%sinewave
sound(w,fs);  %# Play sound at sampling rate Fs
plot(t,w); %plot wave
