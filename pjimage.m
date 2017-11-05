function varargout = pjimage(varargin)
% PJIMAGE MATLAB code for pjimage.fig
%      PJIMAGE, by itself, creates a new PJIMAGE or raises the existing
%      singleton*.
%
%      H = PJIMAGE returns the handle to a new PJIMAGE or the handle to
%      the existing singleton*.
%
%      PJIMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PJIMAGE.M with the given input arguments.
%
%      PJIMAGE('Property','Value',...) creates a new PJIMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pjimage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pjimage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pjimage

% Last Modified by GUIDE v2.5 01-Oct-2017 14:57:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pjimage_OpeningFcn, ...
                   'gui_OutputFcn',  @pjimage_OutputFcn, ...
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


% --- Executes just before pjimage is made visible.
function pjimage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pjimage (see VARARGIN)

% Choose default command line output for pjimage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pjimage wait for user response (see UIRESUME)
% uiwait(handles.figure_pjimage);
setappdata(handles.figure_pjimage, 'img_src', 0);
set(handles.m_processing, 'Enable', 'off');
setappdata(handles.figure_pjimage, 'bSave', false);
setappdata(handles.figure_pjimage, 'bChanged', false);


% --- Outputs from this function are returned to the command line.
function varargout = pjimage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function m_file_Callback(hObject, eventdata, handles)
% hObject    handle to m_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_file_open_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile(...
    {'*.bmp; *.jpg; *.png; *.jpeg', 'Image Files (*.bmp. *.jpg, *.png, *.jpeg)';...
    '*.*', 'All Files(*.*)'}, ...
    'Pick an image');
if isequal(filename, 0) || isequal(pathname, 0)
    return;
end
axes(handles.axes_src); % use axes command to set to target object
fpath=[pathname, filename];
img_src = imread(fpath);
imshow(img_src);
setappdata(handles.figure_pjimage, 'img_src', img_src);
set(handles.m_processing, 'Enable', 'on');

% --------------------------------------------------------------------
function m_file_sace_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_sace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uiputfile({'*.bmp','BMP files'; '*.jpg','JPG files'}, 'Put an Image');
if isequal(filename,0) || isequal(pathname, 0)
    return;
else
    fpath=fullfile(pathname, filename);
end
img_src=getappdata(handles.figure_pjimage, 'img_src');
imwrite(img_src, fpath);

% --------------------------------------------------------------------
function m_file_exit_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bChanged=getappdata(handles.figure_pjimage, 'bChanged');
bSave=getappdata(handles.figure_pjimage, 'bSave');
if bChanged==true && bSave==false
    btnName=questdlg('Save or not?', 'note', 'save', 'not save', 'save');
    switch btnName
        case 'save'
            feval(@axes_dst_menu_save_Callback, handles.axes_dst_menu_save, eventdata, handles);
        case 'not save'
    end
end
h=findobj('Tag', 'figure_im2bw');
if ~isempty(h)
    close(h);
end
close(findobj('Tag', 'figure_pjimage'));


% --------------------------------------------------------------------
function m_processing_Callback(hObject, eventdata, handles)
% hObject    handle to m_processing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = imbw_args;
setappdata(handles.figure_pjimage, 'bChanged', true);


% --------------------------------------------------------------------
function axes_dst_menu_save_Callback(hObject, eventdata, handles)
% hObject    handle to axes_dst_menu_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uiputfile({'*bmp', 'BMP files'; '*.jpg','JPG files'}, 'Pick an Image');
if isequal(filename, 0) || isequal(pathname, 0)
    return;
else
    fpath=fullfile(pathname, filename);
end
img_dst=getimage(handles.axes_dst);
imwrite(img_dst, fpath);
setappdata(handles.figure_pjimage, 'bSave', true);

% --------------------------------------------------------------------
function axes_dst_menu_Callback(hObject, eventdata, handles)
% hObject    handle to axes_dst_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
