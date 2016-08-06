function varargout = soundplayer(varargin)
% SOUNDPLAYER MATLAB code for soundplayer.fig
%      SOUNDPLAYER, by itself, creates a new SOUNDPLAYER or raises the existing
%      singleton*.
%
%      H = SOUNDPLAYER returns the handle to a new SOUNDPLAYER or the handle to
%      the existing singleton*.
%
%      SOUNDPLAYER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOUNDPLAYER.M with the given input arguments.
%
%      SOUNDPLAYER('Property','Value',...) creates a new SOUNDPLAYER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before soundplayer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to soundplayer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help soundplayer

% Last Modified by GUIDE v2.5 05-Jul-2013 13:47:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @soundplayer_OpeningFcn, ...
                   'gui_OutputFcn',  @soundplayer_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before soundplayer is made visible.
function soundplayer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to soundplayer (see VARARGIN)

% Choose default command line output for soundplayer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes soundplayer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = soundplayer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','green');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
freq1=str2num(get(handles.edit1,'string'));
dur=str2num(get(handles.edit2,'string'));
freq2=str2num(get(handles.edit3,'string'));
fs=20000; %sampling rate
t=linspace(0,dur,(dur*fs)); %create time vector of duration "dur"
ramplength=0.1; %ramp length in seconds
rampt=ones(1,(fs*ramplength)); %reates ramp time vector
onramp=linspace(0,1,length(rampt)); %ramp amplitude vector
offramp=linspace(1,0,length(rampt));
w1=0.5*sin(t*2*pi*freq1);%sinewave
w1(1:length(onramp))=onramp.*w1(1:length(onramp));
w1((length(w1)-length(offramp)+1):length(w1))=offramp.*(w1((length(w1)-length(offramp)+1):length(w1)));
w2=0.5*sin(t*2*pi*freq2);%sinewave
w2(1:length(onramp))=onramp.*w2(1:length(onramp));
w2((length(w2)-length(offramp)+1):length(w2))=offramp.*(w2((length(w2)-length(offramp)+1):length(w2)));
ww=(w1+w2);
save('2sinewaves', 'ww')
sound(ww,fs);  %Play sound at sampling rate Fs
figure;
plot(t,w1,'m'); %plot wave 1 
hold on;
plot(t,w2,'b'); %plot wave 2
plot(t,ww,'k'); %plot combined wave
if gcd(freq1,freq2)>1
    xend=(ramplength+(2/gcd(freq1,freq2)));
axis ([ramplength, xend, (min(ww-0.1)), (max(ww)+0.1)])
else
    xend=dur+0.05
    axis ([0, xend, (min(ww-0.1)), (max(ww)+0.1)])
%make axis twice the length of the GCD of freq1 and freq2 unless the GCD is less than 2
end
xlabel('Time (s)')
ylabel('Amplitude')
title('Sine Wave')
save('2sine', 'ww')
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
[x,fs,nbits]=wavread('MAECLF1N_001.wav');
dur=length(x)/fs;
r=str2num(get(handles.edit5,'string'));
for n=1:r
sound(x,fs,nbits)
pause(dur);
end



% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
display 'Sound player closed.'
close(handles.figure1);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
apple=(get(handles.edit6,'string'));
save('userinput', 'apple')


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
fs=60000; %sampling frequency
shift=500; %shift between noise onsets
s=[1:(shift)];
dur=str2num(get(handles.edit2,'string'));
t=linspace(0,dur,(dur*fs));
unos=ones(1,length(s));
noize=rand(1,length(t));
s1=[noize,unos,unos,unos,unos];
s2=[unos,noize,unos,unos,unos];
s3=[unos,unos,noize,unos,unos];
s4=[unos,unos,unos,noize,unos];
s5=[unos,unos,unos,unos,noize];
ripp=s1.*s2.*s3.*s4.*s5;
sound(ripp,fs)
figure;
plot(ripp)


% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
