function W = evaluacion (desvio_color, color_trackeo, X, Frame) %#codegen
% Función de evaluación vectorizada

    Alto  = size(Frame,1); % Alto de la pantalla
    Ancho = size(Frame,2); % Ancho de la pantalla

    N = size(X,2); % Numero de particulas

    desvio_color = repmat(desvio_color',1,N);       % La hago del largo de las particulas por la funcion "GAUSSIANA"

    color_track_YUV = rgb_a_yuv(color_trackeo);     % Convierto a YUV
    color_track_YUV = repmat(color_track_YUV,1,N);  % La hago del largo de las particulas por la funcion "GAUSSIANA"

    ind = sub2ind([Alto Ancho], X(2,:), X(1,:));    % indexo linearmente la matriz Frame

    R = Frame(ind);                                 % Tomo los colores Rojos de las partículas
    G = Frame(ind+Alto*Ancho);                      % Tomo los colores Verdes de las partículas
    B = Frame(ind+Alto*Ancho*2);                    % Tomo los colores Azules de las partículas

    % Lo casteo porque sino tira un error que no entiendo
    R = cast(R, 'double');
    G = cast(G, 'double');
    B = cast(B, 'double');

    color_med = cat(1, R, G, B);
    color_med_YUV = rgb_a_yuv(color_med);                                % Paso el color medido de RGB a YUV
    pesos_yuv = gaussiana (color_med_YUV, color_track_YUV ,desvio_color ); % Calculo los pesos de las particulas según el color
    W = prod(pesos_yuv);       % Multiplico los pesos de cada color y lo guardo en la matriz Peso

end