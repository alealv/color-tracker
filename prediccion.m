function X = prediccion(X, A)   
% Predicci�n de posici�n, velocidad y aceleraci�n supuesta cte

X = A * X;

    % x = x' + vx' * dt + 1/2 * dt^2 * ax';
    % y = y' + vy' * dt + 1/2 * dt^2 * ay';
    % vx = vx' + ax' *dt;
    % vy = vy' + ay' *dt;
    % ax = ax';
    % ay = ay';

end
