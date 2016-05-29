function [ yuv ] = rgb_a_yuv( rgb )
% Funcion que convierte una matriz RGB a una YUV

    rgb_d = double(rgb); % convierto a double
    rgb_n = rgb_d./255;  % normalizo para que queden valores de 0 a 1
    
    CONV = [ 0.299       0.587      0.114;
            -0.14713    -0.28886    0.436;
             0.615      -0.51499   -0.10001];
    yuv = CONV * rgb_n;
    
end

