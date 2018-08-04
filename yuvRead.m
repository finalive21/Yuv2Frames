function [y, u, v] = yuvRead(vid, width, height, nFrame)

% YUVREAD returns the Y, U and V components of a video in separate
% matrices. Luma channel (Y) contains grayscale images for each frame. 
% Chroma channels (U & V) have a lower sampling rate than the luma channel.
% 
% YUVREAD is able to read any common intermediate format with 4:2:0 
% chroma subsampling. You just need to enter the correct width and height
% information for the specific format:
% 
% 
% Format        Video Resolution (width x height)
% -----------------------------------------------
% SQCIF             128 × 96
% QCIF              176 × 144
% SCIF              256 x 192
% SIF(525)          352 x 240
% CIF/SIF(625)      352 × 288
% 4SIF(525)         704 x 480
% 4CIF/4SIF(625)	704 × 576
% 16CIF             1408 × 1152
% DCIF              528 × 384 
% 
% 
% Inputs:
%           vid 	:	Input video sequence in YUV format
%           width 	:   Frame width
%           hight 	:   Frame hight
%           nFrame 	:   Number of frames
% 
% Outputs:
% 
% (C)	Mohammad Haghighat, University of Miami
%       haghighat@ieee.org


fid = fopen(vid,'r');           % Open the video file
stream = fread(fid,'*uchar');    % Read the video file
length = 1.5 * width * height;  % Length of a single frame

y = uint8(zeros(height,   width,   nFrame));
u = uint8(zeros(height/2, width/2, nFrame));
v = uint8(zeros(height/2, width/2, nFrame));

for iFrame = 1:nFrame
    
    frame = stream((iFrame-1)*length+1:iFrame*length);
    
    % Y component of the frame
    yImage = reshape(frame(1:width*height), width, height)';
    % U component of the frame
    uImage = reshape(frame(width*height+1:1.25*width*height), width/2, height/2)';
    % V component of the frame
    vImage = reshape(frame(1.25*width*height+1:1.5*width*height), width/2, height/2)';
    
    y(:,:,iFrame) = uint8(yImage);
    u(:,:,iFrame) = uint8(uImage);
    v(:,:,iFrame) = uint8(vImage);

end
