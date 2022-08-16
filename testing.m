function varargout = testing(varargin)

% TESTING MATLAB code for testing.fig
%      TESTING, by itself, creates a new TESTING or raises the existing
%      singleton*.
%
%      H = TESTING returns the handle to a new TESTING or the handle to
%      the existing singleton*.
%
%      TESTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTING.M with the given input arguments.
%
%      TESTING('Property','Value',...) creates a new TESTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testing

% Last Modified by GUIDE v2.5 13-Apr-2022 02:55:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testing_OpeningFcn, ...
                   'gui_OutputFcn',  @testing_OutputFcn, ...
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


% --- Executes just before testing is made visible.
function testing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testing (see VARARGIN)

% Choose default command line output for testing
handles.output = hObject;
axes(handles.axes1);
imshow('blank.jpg');
axis off;
% Update handles structure
guidata(hObject, handles);

% ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
% %import background
% bg = imread('blan.jpg') ;
% imagesc(bg);
% 
% set(ah, 'handlevisibility', 'off', 'visible', 'off');

% UIWAIT makes testing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.vid = videoinput('winvideo' , 1, 'YUY2_640X480');
flushdata(handles.vid);
%preview(handles.vid);
guidata(hObject, handles);

% --- Executes on button press in face.
function face_Callback(hObject, eventdata, handles)
% hObject    handle to face (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.vid = videoinput('winvideo' , 1, 'YUY2_640X480');
flushdata(handles.vid);
triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
 handles.vid.Timeout = 20;
start(handles.vid);
facedetector = vision.CascadeObjectDetector; 
while(1)
    
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(facedetector, handles.im);
hello = insertObjectAnnotation(handles.im,'rectangle',bbox,'Face');
imshow(hello);

end
guidata(hObject, handles);


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
flushdata(handles.vid);
stop(handles.vid);
delete(handles.vid);
guidata(hObject, handles);


% --- Executes on button press in eyes.
function eyes_Callback(hObject, eventdata, handles)
% hObject    handle to eyes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flushdata(handles.vid);
triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
 handles.vid.Timeout = 20;
start(handles.vid);
bodyDetector = vision.CascadeObjectDetector('EyePairBig');
while(1)
bodyDetector.MinSize = [11 45]; 
%bodyDetector.ScaleFactor = 1.05;                                                 
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(bodyDetector, handles.im);
hello = insertObjectAnnotation(handles.im,'rectangle',bbox,'EYE');
imshow(hello);
end
guidata(hObject, handles);


% --- Executes on button press in upperbody.
function upperbody_Callback(hObject, eventdata, handles)
% hObject    handle to upperbody (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flushdata(handles.vid);
triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
 handles.vid.Timeout = 20;
start(handles.vid);
bodyDetector = vision.CascadeObjectDetector('UpperBody');
while(1)
bodyDetector.MinSize = [60 60]; 
bodyDetector.ScaleFactor = 1.05;                                                 
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(bodyDetector, handles.im);
hello = insertObjectAnnotation(handles.im,'rectangle',bbox,'UpperBody');
imshow(hello);
end
guidata(hObject, handles);


% --- Executes on button press in nose.
function nose_Callback(hObject, eventdata, handles)
% hObject    handle to nose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flushdata(handles.vid);
triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
 handles.vid.Timeout = 20;
start(handles.vid);

bodyDetector = vision.CascadeObjectDetector('Nose');

while(1)
%bodyDetector.MinSize = [11 45]; 
%bodyDetector.ScaleFactor = 1.05;                                                 
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(bodyDetector, handles.im);
hello = insertObjectAnnotation(handles.im,'rectangle',bbox,'Nose');
imshow(hello);
end
guidata(hObject, handles);


% --- Executes on button press in mouth.
function mouth_Callback(hObject, eventdata, handles)
% hObject    handle to mouth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flushdata(handles.vid);
triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
 handles.vid.Timeout = 20;
start(handles.vid);
bodyDetector = vision.CascadeObjectDetector('Mouth','MergeThreshold',16);

while(1)
%bodyDetector.MinSize = [11 45]; 
%bodyDetector.ScaleFactor = 1.05;                                                 
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(bodyDetector, handles.im);
hello = insertObjectAnnotation(handles.im,'rectangle',bbox,'MOUTH');
imshow(hello);
end
guidata(hObject, handles);


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
flushdata(handles.vid);
stop(handles.vid);
delete(handles.vid);
clear handles.vid ;
closereq();
guidata(hObject, handles);


% --- Executes on button press in blur.
function blur_Callback(hObject, eventdata, handles)
% hObject    handle to blur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flushdata(handles.vid);
triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
 handles.vid.Timeout = 20;
start(handles.vid);
faceDetector = vision.CascadeObjectDetector;
while true
    %e=c.snapshot;
    %msa=e;
    trigger(handles.vid); 
    handles.im = getdata(handles.vid, 1);
    msa=handles.im;
    bboxes =step(faceDetector,handles.im);
     if(sum(sum(bboxes))~=0)
         es=imcrop(handles.im,bboxes);
         a=fspecial('average',[25 25]);
         ls=imfilter(es,a);
         handles.im(bboxes(2):bboxes(2)+bboxes(4),bboxes(1):bboxes(1)+bboxes(3),:)=ls;
        imshowpair(msa,handles.im,'montage');
     else
         imshowpair(handles.im,handles.im,'montage');
     end
     pause(0.1);
end
guidata(hObject, handles);
