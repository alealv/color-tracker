function X = crear_particulas(inicio, fin, N_particulas)
% Asigna valores aleatorios a la posicion, ceros a la velocidad y
% aceleracion, dentro de la resolucion de la imagen

x = randi([inicio(1) fin(1)], 1, N_particulas);
y = randi([inicio(2) fin(2)], 1, N_particulas);
v = zeros(2, N_particulas);
a = zeros(2, N_particulas);
X = [x; 
     y; 
     v; 
     a]; % 6 x N_particulas
 
end