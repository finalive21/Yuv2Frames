%% 
clc;
clear all;
close all;

%05/08/18

%creo una estructura llamada frames con 3 campos, teniendo anidada otra estructura en el
%campo 3 correspondiente a las dimensiones
field1 = 'name';
field2 = 'frame';
field3 = 'dim';

%creo una estructura anidada vacia con campos ya definidos
field3_1 = 'width';
field3_2 = 'height';
value3 = struct(field3_1,{},field3_2,{});

%creo una estructura vacia con campos ya definidos
frames = struct(field1,{},field2,{},field3,value3);

%extraigo frames de la componente Luma (Y) del video con formato YUV 4:2:0

videoSequence = 'akiyo_qcif.yuv';
width  = 176;
height = 144;
nFrame = 300;

% Lectura de la secuencia de video
[Y,U,V] = yuvRead(videoSequence, width, height ,nFrame); 

%en Y se encuentran una cantidad de cuadros 'nFrame' en escala de grises

%a cada elemento de la estructura le asignare datos en los campos
%correspondientes
for i=1:nFrame
    frames(i).name = ['Frame ' num2str(i)];
    frames(i).frame = Y(:,:,i);
    frames(i).dim.width = width;
    frames(i).dim.height = height;
end

