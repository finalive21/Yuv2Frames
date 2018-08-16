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
field4 = 'quad';

%creo una estructura anidada vacia con campos ya definidos
field3_1 = 'x';
field3_2 = 'y';
value3 = struct(field3_1,{},field3_2,{});

%creo una estructura para el particionamiento
field4_1 = 'd1';
field4_2 = 'd2';
field4_3 = 'd3';
field4_4 = 'd4';
value4 = struct(field4_1,{},field4_2,{},field4_3,{},field4_4,{});

%creo una estructura vacia con campos ya definidos
frames = struct(field1,{},field2,{},field3,value3,field4,value4);

%extraigo frames de la componente Luma (Y) del video con formato YUV 4:2:0

videoSequence = 'akiyo_qcif.yuv';
width  = 176;
height = 144;
nFrame = 100;

% Lectura de la secuencia de video
[Y,U,V] = yuvRead(videoSequence, width, height ,nFrame); 

%en Y se encuentran una cantidad de cuadros 'nFrame' que se percibe escala de grises



%a cada elemento de la estructura le asignare datos en los campos
%correspondientes
for n=1:nFrame
    frames(n).name = ['Frame ' num2str(n)];
    %frames(n).frame = Y(:,:,n);
    
    %ajusto la resolucion de tal manera que sea potencia de 2 en ambas
    %dimensiones
    A=imresize(Y(:,:,n),[512 512]);
    frames(n).frame = A;
    frames(n).dim.x = width;
    frames(n).dim.y = height;
    
    % Codigo del particionamiento usando qtdecomp


    
    %hallo el arbol de particionmaiento
    qA=qtdecomp(A,0.20,[8 64]);

    %se procede a hallar los parametros de la sparse matrix
    %la siguiente sentencia se encarga de asignar coordenadas a los vectores columna i y j,
    %que referencia a un valor s, para todo elemento de qA no nulo(diferente de 0)
    [i,j,s] = find(qA);
    
    depth = [64 32 16 8];
    
    for m = depth
        valor = length(find(s==m));
        d=zeros(valor,2);
        for p = 1:valor
            aux = find(s==m);
            d(p,:) = [i(aux(p)) j(aux(p))];
        end
        
        if (m==64)
            frames(n).quad.d1 = d;
        elseif (m==32)
            frames(n).quad.d2 = d;
        elseif (m==16)
            frames(n).quad.d3 = d;
        else
            frames(n).quad.d4 = d;
        end   
    end
end





