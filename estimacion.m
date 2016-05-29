function [ E ] = estimacion(X)

% Estimación del vector estados del objeto trackeado

    E = mean(X,2);
    
end

