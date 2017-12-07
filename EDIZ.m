% Implementation of paper: "EDIZ: An Error Diffusion Image Zooming Scheme"
% Code by: Soroush Saryazdi

clc
clear all
close all

% ---------------------------
% ------- DEFINITIONS -------
% ---------------------------
% I_in = input image
% n = zooming factor
% I_zout = zoom out image
% I_Rec = reconstructed image (zoom I_zout to have same size of input image)
% e = reconstruction error (I_in - I_Rec)
% Ee = estimated error when zooming (zoomed reconstruction error)
% I_in_zoom = result of normal zoom of input image (I_in)
% I_out = result of EDIZ (add estimated error to normal zoom: I_in_zoom + Ee)

% ---------------------------
% -------- Code Start -------
% ---------------------------

% ~~~~~ Initials ~~~~~
I_in=im2double(imread('livingroom.tif'));
Method = 'lanczos3'; % Zooming method, other options: 'box', 'cubic'
n = 2; % Zooming factor
[ImX ImY ImZ] = size(I_in); % size of image

% ~~~~~ zoom-out-zoom-in ~~~~~
I_zout = imresize(I_in,round([ImX/n ImY/n]),Method); % Zoom out
I_Rec = imresize(I_zout,[ImX ImY],Method);

% ~~~~~ Estimated error calculation ~~~~~
e = I_in - I_Rec;
Ee = imresize(e,n*[ImX ImY],Method);

% ~~~~~ Zooming ~~~~~
I_in_zoom = imresize(I_in,n*[ImX ImY],Method); % result of normal zoom
I_out = I_in_zoom + Ee; % result of EDIZ

% ~~~~~ Show Results ~~~~~
% input image
imshow(I_in)
title('Original image')
% normal zoom result
figure
imshow(I_in_zoom)
title(strcat({'Normal'},{' '},{Method}))
% EDIZ result
figure
imshow(I_out)
title('EDIZ')