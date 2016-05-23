function varargout = pcd(varargin)
% PCD MATLAB code for pcd.fig
%      PCD, by itself, creates a new PCD or raises the existing
%      singleton*.
%
%      H = PCD returns the handle to a new PCD or the handle to
%      the existing singleton*.
%
%      PCD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PCD.M with the given input arguments.
%
%      PCD('Property','Value',...) creates a new PCD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pcd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pcd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pcd

% Last Modified by GUIDE v2.5 06-Mar-2015 17:46:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pcd_OpeningFcn, ...
                   'gui_OutputFcn',  @pcd_OutputFcn, ...
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


% --- Executes just before pcd is made visible.
function pcd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pcd (see VARARGIN)

% Choose default command line output for pcd
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pcd wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = pcd_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I Ir Iz F;
Ir = I; Iz = I; F = I;
set(handles.ket,'string','');
set(handles.sizeDC,'string','');
set(handles.xValue,'string','');
set(handles.yValue,'string','');
set(handles.sizeValue,'string','');


% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I Ir Iz F;
handles.output = hObject;
[filename, pathname] = uigetfile({'*.jpg'; '*.png'},'Select Image File');
I = imread([pathname,filename]);
Ir = I; Iz = I; F = I;
imshow(I,'Parent',handles.axes1);


% --- Executes on button press in sampling.
function sampling_Callback(hObject, eventdata, handles)
% hObject    handle to sampling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
set(handles.ket,'string','Sampling Image');
x = size(I);
z = get(handles.slider,'Value');
A = I(1:z:x(1), 1:z:x(2), :);
set(handles.sizeDC,'string',z);
imshow(A,'Parent',handles.axes2);


% --- Executes on button press in kuantisasi.
function kuantisasi_Callback(hObject, eventdata, handles)
% hObject    handle to kuantisasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
set(handles.ket,'string','Kuantisasi');
x = size(I);
z = get(handles.slider,'Value');
A = zeros(x);
for k=1:3
    for i=1:x(1)
        for j=1:x(2)
            A(i,j,k)=double(I(i,j,k)/z);
        end
    end
end
set(handles.sizeDC,'string',z);
imshow(A,'Parent',handles.axes2);


% --- Executes on button press in zoomin.
function zoomin_Callback(hObject, eventdata, handles)
% hObject    handle to zoomin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Iz;
x = size(Iz);
m = 1; n = 1;
for i = 1:1:x(1)
	for j = 1:1:x(2)
        A(m,n,:) = Iz(i,j,:);
        A(m+1,n,:) = Iz(i,j,:);
        A(m,n+1,:) = Iz(i,j,:);
        A(m+1,n+1,:) = Iz(i,j,:);
        n = n+2;       
    end
    m = m+2; n = 1;
end
figure(1); imshow(A);
Iz = A;

% --- Executes on button press in zoomout.
function zoomout_Callback(hObject, eventdata, handles)
% hObject    handle to zoomout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Iz;
x = size(Iz);
for i = 1:2:x(1)
    for j = 1:2:x(2)
        A((i+1)/2, (j+1)/2, :) = Iz(i,j,:);
    end
end
figure(1); imshow(A);
Iz = A;


% --- Executes on button press in rotate.
function rotate_Callback(hObject, eventdata, handles)
% hObject    handle to rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Ir;
set(handles.ket,'string','Rotate');
x = size(Ir);
k = x(1);
for i = 1:x(1)
    A(:,k,:) = Ir(i,:,:);
    k = k-1;
end
imshow(A,'Parent',handles.axes2);
Ir = A;


% --- Executes on button press in flip_vertikal.
function flip_vertikal_Callback(hObject, eventdata, handles)
% hObject    handle to flip_vertikal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global F;
set(handles.ket,'string','Flip Vertikal');
x = size(F);
k = x(1);
for i = 1:x(1)
   A(k,:,:) = F(i,:,:); 
   k = k-1;
end
imshow(A,'Parent',handles.axes2);
F = A;

% --- Executes on button press in flip_horizontal.
function flip_horizontal_Callback(hObject, eventdata, handles)
% hObject    handle to flip_horizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global F;
set(handles.ket,'string','Flip Vertikal');
x = size(F);
k = x(2);
for i = 1:x(2)
   A(:,k,:) = F(:,i,:); 
   k = k-1;
end
imshow(A,'Parent',handles.axes2);
F = A;


% --- Executes on button press in warping.
function warping_Callback(hObject, eventdata, handles)
% hObject    handle to warping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
set(handles.ket,'string','Warping');
tform = maketform('affine', [1 0 0; .5 1 0; 0 0 1]);
A = imtransform(I, tform);
imshow(A,'Parent',handles.axes2);


% --- Executes on button press in crop.
function crop_Callback(hObject, eventdata, handles)
% hObject    handle to crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
set(handles.ket,'string','Crop');
x = str2num(get(handles.xValue,'String'));
y = str2num(get(handles.yValue,'String'));
z = str2num(get(handles.sizeValue,'String'));

A = I(x:z,y:z,:);
imshow(A,'Parent',handles.axes2);
figure(1); imshow(A);


% --- Executes on button press in histogramRGB.
function histogramRGB_Callback(hObject, eventdata, handles)
% hObject    handle to histogramRGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
red = I(:, :, 1);
green = I(:, :, 2);
blue = I(:, :, 3);

figure('position', [100 100 1200 400]);
[countR grayR] = imhist(red);
subplot(1,3,1);
bar(countR,'r');
title('Hist.Red');
% xlim([0 grayR(end)]);

[countG grayG] = imhist(green);
subplot(1,3, 2);
bar(countG,'g');
title('Hist.Green');
% xlim([0 grayG(end)]);

[countB grayB] = imhist(blue);
subplot(1,3,3);
bar(countB,'b');
title('Hist.Blue');
% xlim([0 grayB(end)]);


% --- Executes on button press in equalisasi.
function equalisasi_Callback(hObject, eventdata, handles)
% hObject    handle to equalisasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
set(handles.ket,'string','Grayscale Image');
Ig = rgb2gray(I);
eqi = histeq(Ig);
imshow(Ig,'Parent',handles.axes2);

figure('position', [100 100 1000 400]);
subplot(1,2,1);
imhist(Ig);
title('Hist.Original');

subplot(1,2,2);
imhist(eqi);
title('Hist.Equalisasi');


function ket_Callback(hObject, eventdata, handles)
% hObject    handle to ket (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ket as text
%        str2double(get(hObject,'String')) returns contents of ket as a double


% --- Executes during object creation, after setting all properties.
function ket_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ket (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function sizeDC_Callback(hObject, eventdata, handles)
% hObject    handle to sizeDC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sizeDC as text
%        str2double(get(hObject,'String')) returns contents of sizeDC as a double


% --- Executes during object creation, after setting all properties.
function sizeDC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sizeDC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function xValue_Callback(hObject, eventdata, handles)
% hObject    handle to xValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xValue as text
%        str2double(get(hObject,'String')) returns contents of xValue as a double


% --- Executes during object creation, after setting all properties.
function xValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function yValue_Callback(hObject, eventdata, handles)
% hObject    handle to yValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yValue as text
%        str2double(get(hObject,'String')) returns contents of yValue as a double


% --- Executes during object creation, after setting all properties.
function yValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function sizeValue_Callback(hObject, eventdata, handles)
% hObject    handle to sizeValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sizeValue as text
%        str2double(get(hObject,'String')) returns contents of sizeValue as a double


% --- Executes during object creation, after setting all properties.
function sizeValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sizeValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
