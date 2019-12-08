% Name:                  De'Shaunna Scott
% Due Date:              4/29/19
% Description:           CMSC 455 Homework 5 - FFT 
% Program Language:      MATLAB

% Start fresh everytime program is ran
clc;
clear;

% Use of fft_wav function for homework 5
fft_wav('cat.wav','mod_cat.wav');

[y,Fs] = audioread('cat.wav');
sound(y,Fs);
pause(2.5);  % waits for first sound to finish
[y,Fs] = audioread('mod_cat.wav');
sound(y,Fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function used to process and modify signal
% Some code taken from Dr. Jon Squire

function fft_wav(input_name, output_name)
  format compact
  if nargin<2
    output_name='junkm.wav';
  end
  if nargin<1
    input_name='cat.wav';
  end
  
  fprintf('reading wave file: %s \n\n',input_name);
  
  % Changed to audioread because wavread has been removed from matlab
  [y,Fs] = audioread(input_name);
  
  fprintf('Fs sample frequency in Hz: %d\n',Fs);
  fprintf('number of samples: %d\n',size(y));
  fprintf('maximum value in y: %f\n',max(y));
  fprintf('minimum value in y %f\n\n',min(y));
  
  % Take fft to get the frequency spectrum
  z=fft(y);
  n=length(z);
  plot(1:n,abs(z));
  grid on;
  axis tight;
  xlabel('Frequency bin');
  ylabel('Amplitude');
  title(['Raw FFT of input ' input_name]);
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%% MY CODE STARTS HERE %%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % modify spectrum in  z  as desired
  z(1:(n/8)) = 0; % Gets rid of the first n/8 frequencies of audio
  
  % Lowers the pitch of the audio.
  Fs = Fs ./ 1.5;   % Makes it sound lower
  
  % Plots the modified frequency spectrum
  figure;
  plot(1:n,abs(z));
  grid on;
  axis tight;
  xlabel('Frequency bin');
  ylabel('Amplitude');
  title(['Modified FFT of input ' input_name]);
  
  % Take inverse transform, and turn it into audio file
  yz = ifft(z);
  audiowrite(output_name, yz, Fs);
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%% MY CODE ENDS HERE   %%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
end % fft_wav.m