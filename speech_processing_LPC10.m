%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This program implements the FS1015-LPC10 standard for speech processing
%The program implements the Encoder and the Decoder of the standard
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The Encoder extract the parameters of speech(analysis filter cofficients,pitch and gain)
%from speech frames(180 samples) with overlaping between frames of 80 samples

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The decoder reconstruct the speech using the extracted parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Note:The program records voice for 4 seconds and Apply processing on it
%The program plays the voice after recording then it plays it after processing


clear;

frame_size=180;
frame_overlap=80;
no_of_cofficients=10;

%record 4 seconds of speech and play it again
Sampling_frequency=8000;
speech_signal=wavrecord(4*Sampling_frequency,Sampling_frequency,'double');
wavplay(speech_signal,Sampling_frequency);

%preemphasis filter
s_preemph=preemphasis(speech_signal);   

%Calculate number of frames
N_frame=floor((length(speech_signal)-frame_overlap)/(frame_size-frame_overlap));

%initialize the synthesis speech
speech_synthesis=zeros(0,0);

% For each frame calculate the gain,pitch,coffiecients
for n=1:N_frame
    
    
    %segmentation and overlapping
    frame=segmentation(s_preemph,n,frame_size,frame_overlap);
    
    %window
    s_window=windowing(frame,frame_size);
    
    %Calculate the autocorrelation cofficients
    R=autocorr(s_window,no_of_cofficients);
    
    %Calculate the filter cofficients and the gain using levinson durbin 
    [filter_cofficients G]=levinson(R);
    
    %Calculate the pitch frequency 
     pitch(n)=0;
     [pitch(n)]=pitching(s_window,Sampling_frequency);
  
     %Decoder
     
     %Generate the innovation
     u=excitation(pitch(n),G,frame_size,frame_overlap);

     %Apply the excitation to synthesis filter
     speech_synthesis=[speech_synthesis synthesisfilter(u,filter_cofficients,frame_size,frame_overlap)];
 
end

%play the synthesis speech
wavplay(speech_synthesis,Sampling_frequency);
