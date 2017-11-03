function [X] = seleccion(X, W, m)
% Seleccion (sampling) de part�culas

%Normalizamos de forma que el total sea 1 y calculamos los pesos acumulados

Q = W / sum(W, 2); % Normalizaci�n
R = cumsum(Q, 2);  % Suma acumulada

% Generamos N n�meros aleatorios con distribuci�n uniforme para seleccionar
% las part�culas

N = size(X, 2);

if m == 'R'
    T = rand(1, N); %Roulette wheel selection
else
    T = 0:1/N:1-1/N; %Stochastic universal sampling
end

% Selecci�n

[~, I] = histc(T, R); % Devuelve en I los indices de las part�culas 
                      % seleccionadas
X = X(:, I + 1);      % Copio la info de las particulas seleccionadas con 
                      % con reposici�n

end