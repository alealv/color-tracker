function [ E ] = estimacion(X)

% Estimaci�n del vector estados del objeto trackeado

    E = mean(X,2);
    
end

