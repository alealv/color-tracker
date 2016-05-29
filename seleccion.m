function [X] = seleccion(X, W, m)
% Seleccion (sampling) de partículas

%Normalizamos de forma que el total sea 1 y calculamos los pesos acumulados

Q = W / sum(W, 2); % Normalización
R = cumsum(Q, 2);  % Suma acumulada

% Generamos N números aleatorios con distribución uniforme para seleccionar
% las partículas

N = size(X, 2);

if m == 'R'
    T = rand(1, N); %Roulette wheel selection
else
    T = 0:1/N:1-1/N; %Stochastic universal sampling
end

% Selección

[~, I] = histc(T, R); % Devuelve en I los indices de las partículas 
                      % seleccionadas
X = X(:, I + 1);      % Copio la info de las particulas seleccionadas con 
                      % con reposición

end