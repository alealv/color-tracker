function X = mutacion(X, desvio_pos, dt)
% Mutaci�n de las part�culas

    N = size(X, 2);        % Numero de particulas
    
    % Calculo los desvios de velocidad y aceleraci�n
    %   delta_v = delta_x/delta_t;
    %   delta_a = 2*delta_x/delta_t^2;
    
    desvio_vel = desvio_pos / dt;  % [pixels] Desvio estandar de la estimacion de la velocidad
    desvio_acel = 2*desvio_pos / dt^2; % [pixels] Desvio estandar de la estimacion de la aceleraci�n

    desvio = [desvio_pos;
              desvio_pos;
              desvio_vel;
              desvio_vel;
              desvio_acel;
              desvio_acel];
    
    X = X + diag(desvio) * randn(size(X,1),N); % Mutacion de las particulas
    
    % Para la mutaci�n utilizamos una funci�n gaussiana con mu = 0 y
    % desvio = desvio_pos/vel/acel
   
end
