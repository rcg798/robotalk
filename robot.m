function varargout = robot(varargin)
% ROBOT M-file for robot.fig
%      ROBOT, by itself, creates a new ROBOT or raises the existing
%      singleton*.
%
%      H = ROBOT returns the handle to a new ROBOT or the handle to
%      the existing singleton*.
%
%      ROBOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROBOT.M with the given input arguments.
%
%      ROBOT('Property','Value',...) creates a new ROBOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before robot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to robot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help robot

% Last Modified by GUIDE v2.5 09-Jul-2013 23:42:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @robot_OpeningFcn, ...
                   'gui_OutputFcn',  @robot_OutputFcn, ...
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


% --- Executes just before robot is made visible.
function robot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to robot (see VARARGIN)

% Choose default command line output for robot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes robot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = robot_OutputFcn(hObject, eventdata, handles) 
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

%get pitch
%pitch=handles.pitch;

%get the string
input=get(handles.edit1,'string');

%find out how long it is
input_length=length(input);

%list alphabet and other entries
alph_cell=[' ';'a';'b';'c';'d';'e';'f';'g';'h';'i';'j';'k';'l';'m';'n';'o';...
    'p';'q';'r';'s';'t';'u';'v';'w';'x';'y';'z';'?';'.';',';'!';';';'0';'2';...
    '4';'6';'8'];
alph_cell2=[' ';'A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';...
    'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z';']';':';'[';'/';'\';'1';'3';'5';'7';'9'];
alph_cell_length=length(alph_cell);

%loop thru input, assign value for each letter
for j=1:input_length   %for each letter in the string
    match=0;
    for k=1:alph_cell_length   %try matching in alphabetical order
        if input(j)==alph_cell(k)
            y(j)=(log(k)*300); %when it matches lowercase, even #s
            match=1;
        elseif input(j)==alph_cell2(k)
            y(j)=(log(k)*250); %when it matches uppercase, odd #s
            match=1;
        end
    end
    if match==0 
        y(j)=1000;
    end
end

handles.numbers=y;
handles.input_length=input_length;
%disp(handles.numbers);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

input_length=handles.input_length;
y=handles.numbers;

for j=1:input_length   %for each letter in the string
    freq1=y(j);
    dur=0.05; %duration
    fs=40000; %sampling rate
    t=linspace(0,dur,(dur*fs)); %create time vector of duration "dur"
	ramplength=0.005; %ramp length in seconds
	rampt=ones(1,(fs*ramplength)); %creates ramp time vector
	onramp=linspace(0,1,length(rampt)); %ramp amplitude vector
	offramp=linspace(1,0,length(rampt));
    w1=0.5*sin(t*2*pi*freq1);%sinewave
	w1(1:length(onramp))=onramp.*w1(1:length(onramp)); %????
	w1((length(w1)-length(offramp)+1):length(w1))=offramp.*(w1((length(w1)-length(offramp)+1):length(w1)));
    sound(w1,fs);  %Play sound at sampling rate Fs
end
