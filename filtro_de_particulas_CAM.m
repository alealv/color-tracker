clc
clear all;
close all;

pkg load image-acquisition
pkg load image

%addpath ./funciones_viejas; %funciones de backup (no utilizadas en esta versi�n)

%% Variables
  
dt = 1; % [frame] Cada cuantos frames hago la predicci�n

N_particulas = 2000;
N_part_max = 10000;

desvio_color = [0.4 0.1 0.1]; % [escala de color] Desvio estandar de la
                                % medicion del color 
                                
desvio_pos = 5;  % [pixels] Desvio estandar de la estimacion de la posicion

color_trackeo = [0; 0; 255]; % [RGB] Valor del color a trackear

K = 0.7;     % Factor de multiplicaci�n de media para graficar

W_th = 0.00001;   % Valor m�nimo del peso medio, debajo de este crea part�culas nuevas

m = 'R';
%R: Roulette wheel selection
%S: Stochastic universal sampling

exit = 0;   % flag de salida del GUI

%% Modelo de movimiento

A = [1 0 dt 0  0.5*dt^2    0    ;
     0 1 0  dt    0     0.5*dt^2;
     0 0 1  0     dt       0    ;
     0 0 0  1     0        dt   ;
     0 0 0  0     1        0    ;
     0 0 0  0     0        1]   ;   
 
% x = x' + vx' * dt + 1/2 * dt^2 * ax';
% y = y' + vy' * dt + 1/2 * dt^2 * ay';
% vx = vx' + ax' *dt;
% vy = vy' + ay' *dt;
% ax = ax';
% ay = ay';

% Suponemos aceleraci�n constante entre frame y frame


%% Vector de Estados del objeto trackeado

E = zeros(size(A,1),1); % vector de estado del objeto trackeado

% E = [x; y; vx; vy; ax; ay];

%% Cargamos el video

%----- CHEQUEAR CONFIGURACIONES CON IMAQTOOL -----%


% Comentar la linea si usan YUV
% video = videoinput('winvideo', 1, 'RGB24_640x480');

% Comentar las 2 lineas si usan RGB
%video = videoinput('winvideo', 1, 'YUY2_640x480');
video = videoinput("v4l2", "/dev/video0");

%video.ReturnedColorspace = 'rgb';
set(video, "VideoFormat", "RGB24");


video.FramesPerTrigger = Inf;
resolucion = get(video, "VideoResolution");


%-------------------------------------------------%

%% Inicializaci�n de Interfaz Gr�fica
% gui();

%% Inicializaci�n de Particulas
X = crear_particulas([1 1], resolucion, N_particulas); % Ancho x Alto

%% Inicializaci�n de Video
start(video)

%% Generaciones

while(exit == 0)
    
    % Obtenemos un frame
%    Frame = getdata(video, 1); % Alto x Ancho x 3(RGB)
    Frame = getsnapshot(video); % Alto x Ancho x 3(RGB)
    
    % Calculamos los pesos de cada particula
    W = evaluacion(desvio_color, color_trackeo, X(1:2, :), Frame);
   
    % Graficamos las particulas                   
    [X, ind] = mostrar_particulas(X, W, Frame, resolucion, K, W_th);
    
    % Graficamos el contorno y calculamos el �rea       
    [Area, Cont] = mostrar_contorno(X, ind);

    
% --------------NO COMENTAR PARA VERSION CON GUI------------%     
%     % Actualizo los valores de la gui
%     [N_part_nuevas, color_trackeo, ...
%         desvio_color, K, desvio_pos, ...
%                 dt, exit] = gui(Frame, X, ind, Cont, Area);
% ----------------------------------------------------------%               
            

% --------------COMENTAR PARA VERSION CON GUI---------------%
    % Variamos el n�mero de particulas en funci�n del �rea
    [X, W] = variar_N_particulas(X, W, Area, N_part_max, resolucion);
% ----------------------------------------------------------%
     
    % Selecci�n
    X = seleccion(X, W, m);
    
    % Estimaci�n del vector de estados del objeto trackeado
    E = estimacion(X)
    N_p = size(X,2)
    
    % Predicci�n para el proximo frame
    X = prediccion(X, A);    
    
    % Mutaci�n
    X = mutacion(X, desvio_pos, dt);     
    
    % Correcci�n por si alguna particula no tiene valor entero en x e y
    % o por si queda fuera del frame
    X = correccion (X, resolucion);

    
% --------------NO COMENTAR PARA VERSION CON GUI------------%   
%     % Actualizo numero de part�culas si las cambie en la GUI
%     if (N_part_nuevas ~= N_particulas)
%         [X, W] = variar_N_particulas(X, W, N_part_nuevas, N_part_max, resolucion);
%     end
% ----------------------------------------------------------%    
    
    % Limpiar datos
%    flushdata(video);

end

%% Cierre de video y limpieza de memoria
% Limpiar datos


%-EJECUTAR ESTOS COMANDOS SI PONEN CONTROL-C EN LA LINEA DE COMANDOS-%

close(figure(1));
%flushdata(video);           
stop(video)
%delete(video)
%clear video