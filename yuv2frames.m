clear all;
clc all;
close all;

%% Extraer frames de un formato de video YUV 4:2:0

clc; clear; close all;

%Los videos se encuentran en formato YUV 4:2:0

%Se introduce la informacion del video
videoSequence = 'akiyo_qcif.yuv';
width  = 176;
height = 144;
nFrame = 300;


% Lectura de la secuencia de video
[Y,U,V] = yuvRead(videoSequence, width, height ,nFrame); 


% Se escogen los frames deseados
%Los valores son tomados como ejemplo

frame_first = 5;
frame_last = 300;


%Como nos interesa el componente relacionado con la luminancia, se
%trabajara sobre la variable Y


figure;
j=1;
for i=frame_first:5:frame_last
    subplot(6,10,j), imshow(Y(:,:,i)), title(['frame' num2str(i)]);
    j=j+1;
    
end

%Guardo un frame de la capa de luminancia
imwrite(Y(:,:,70),'my_frame.png');

%Cantidad de frames a mostrar en el subplot= (final-inicial)/razon + 1

