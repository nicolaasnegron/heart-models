function varargout = GUI_Heart2(varargin)
% GUI_HEART2 MATLAB code for GUI_Heart2.fig
%      GUI_HEART2, by itself, creates a new GUI_HEART2 or raises the existing
%      singleton*.
%
%      H = GUI_HEART2 returns the handle to a new GUI_HEART2 or the handle to
%      the existing singleton*.
%
%      GUI_HEART2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_HEART2.M with the given input arguments.
%
%      GUI_HEART2('Property','Value',...) creates a new GUI_HEART2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Heart2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Heart2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Heart2

% Last Modified by GUIDE v2.5 05-Dec-2014 10:39:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Heart2_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Heart2_OutputFcn, ...
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


% --- Executes just before GUI_Heart2 is made visible.
function GUI_Heart2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Heart2 (see VARARGIN)

% Choose default command line output for GUI_Heart2
handles.output = hObject;
handles.Folder_Name = 'Enter Image Title';
handles.stack = varargin;
handles.BW = varargin;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Heart2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Heart2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function Folder_Name_Callback(hObject, eventdata, handles)
% hObject    handle to Folder_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Folder_Name as text
%        str2double(get(hObject,'String')) returns contents of Folder_Name as a double
handles.Folder_Name = get(hObject, 'String');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Folder_Name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Folder_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.Folder_Name = get(hObject, 'String');
guidata(hObject,handles);

% --- Executes on button press in Initialize.
function Initialize_Callback(hObject, eventdata, handles)
% hObject    handle to Initialize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.stack = initialize(handles.Folder_Name);
guidata(hObject, handles);

% --- Executes on button press in Register.
function Register_Callback(hObject, eventdata, handles)
% hObject    handle to Register (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Segment.
function Segment_Callback(hObject, eventdata, handles)
% hObject    handle to Segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%stack2 = zeros(512,512,Images,'uint16');
handles.stack = segmentation(handles.stack);

axes(handles.axes4);
imagesc(handles.stack(:,:,1));
colormap 'gray'
axis off

axes(handles.axes5);
imagesc(handles.stack(:,:,idivide(size(handles.stack,3),int32(2))));
colormap 'gray'
axis off

axes(handles.axes6);
imagesc(handles.stack(:,:,size(handles.stack,3)));
colormap 'gray'
axis off


guidata(hObject,handles);

% --- Executes on button press in Threshold.
function Threshold_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.stack = thresholding(handles.stack,handles.threshold_max,handles.threshold_min);

axes(handles.axes7);
imagesc(handles.stack(:,:,1));
colormap 'gray'
axis off

axes(handles.axes8);
imagesc(handles.stack(:,:,idivide(size(handles.stack,3),int32(2))));
colormap 'gray'
axis off

axes(handles.axes9);
imagesc(handles.stack(:,:,size(handles.stack,3)));
colormap 'gray'
axis off

guidata(hObject,handles);

function Cutoff_Callback(hObject, eventdata, handles)
% hObject    handle to Cutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cutoff as text
%        str2double(get(hObject,'String')) returns contents of Cutoff as a double
cutoff_value = get(hObject, 'String');
handles.cutoff = str2double(cutoff_value);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Cutoff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
cutoff_value = get(hObject, 'String');
handles.cutoff = str2double(cutoff_value);
guidata(hObject,handles);


function Max_Thresh_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max_Thresh as text
%        str2double(get(hObject,'String')) returns contents of Max_Thresh as a double
max_thresh_value = get(hObject, 'String');
handles.threshold_max = str2double(max_thresh_value);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Max_Thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_Thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
max_thresh_value = get(hObject, 'String');
handles.threshold_max = str2double(max_thresh_value);
guidata(hObject,handles);


function Min_Thresh_Callback(hObject, eventdata, handles)
% hObject    handle to Min_Thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Min_Thresh as text
%        str2double(get(hObject,'String')) returns contents of Min_Thresh as a double
min_thresh_value = get(hObject, 'String');
handles.threshold_min = str2double(min_thresh_value);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Min_Thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Min_Thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
min_thresh_value = get(hObject, 'String');
handles.threshold_min = str2double(min_thresh_value);
guidata(hObject,handles);

% --- Executes on button press in Display_Stack.
function Display_Stack_Callback(hObject, eventdata, handles)
% hObject    handle to Display_Stack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%stack = initialize(handles.Folder_Name);
stack3 = handles.stack;
figure, imshow3D(stack3);
handles.stack = stack3;
guidata(hObject, handles);

% --- Executes on button press in Convert_Files.
function Convert_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Convert_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Convert_Files
FileChanger(handles.Folder_Name);
guidata(hObject, handles);


% --- Executes on button press in Create_Mask.
function Create_Mask_Callback(hObject, eventdata, handles)
% hObject    handle to Create_Mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stack = handles.stack;
Images = size(stack,3);
axes(handles.axes1);
imagesc(stack(:,:,1));
colormap 'gray'
axis off

axes(handles.axes3);
imagesc(stack(:,:,Images));
colormap 'gray'
axis off

axes(handles.axes2);
imagesc(stack(:,:,(Images/2)));
colormap 'gray'
axis off

handles.h = imfreehand(gca,'Closed','true'); %allows the user to draw a freehand ROI
handles.BW = createMask(handles.h);
axes(handles.axes5);
handles.z = imagesc(double(stack(:,:,(Images/2))).*double(handles.BW));
axis off
axes(handles.axes6);
handles.q = imagesc(double(stack(:,:,(Images))).*double(handles.BW));
axis off
axes(handles.axes4);
handles.y = imagesc(double(stack(:,:,1)).*double(handles.BW));
colormap 'gray'
axis off

guidata(hObject, handles);


% --- Executes on button press in Apply_Mask.
function Apply_Mask_Callback(hObject, eventdata, handles)
% hObject    handle to Apply_Mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.stack = maskisolation(handles.stack,handles.BW);
figure, imshow3D(handles.stack);
guidata(hObject, handles);


% --- Executes on button press in Image_Selection.
function Image_Selection_Callback(hObject, eventdata, handles)
% hObject    handle to Image_Selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.stack = imageselection(handles.stack, handles.End_Image, handles.Start_Image);
guidata(hObject, handles);


function End_Image_Callback(hObject, eventdata, handles)
% hObject    handle to End_Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_Image as text
%        str2double(get(hObject,'String')) returns contents of End_Image as a double
end_image = get(hObject, 'String');
handles.End_Image = str2double(end_image);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function End_Image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end_image = get(hObject, 'String');
handles.End_Image = str2double(end_image);
guidata(hObject,handles);


function Start_Image_Callback(hObject, eventdata, handles)
% hObject    handle to Start_Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_Image as text
%        str2double(get(hObject,'String')) returns contents of Start_Image as a double
%start_image = get(hObject, 'String');
handles.Start_Image = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Start_Image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
start_image = get(hObject, 'String');
handles.Start_Image = str2double(start_image);
guidata(hObject,handles);


% --- Executes on button press in Export_Stack.
function Export_Stack_Callback(hObject, eventdata, handles)
% hObject    handle to Export_Stack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
javaaddpath '/Applications/MATLAB_R2013a_Student.app/java/ij.jar'
javaaddpath '/Applications/MATLAB_R2013a_Student.app/java/mij.jar'
MIJ.start()
MIJ.createImage(handles.stack)
