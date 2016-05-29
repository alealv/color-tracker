function [Area, Cont] = mostrar_contorno(X, ind)
% Calcula el contorno del objeto trackeado

    if (size(X(:,ind),2)>10)
        % Graficar contorno    
        
        [Area, Cont] = contorno_convexhull(X(:,ind)); % Por convexhull
        
        %contorno_gaussiana(cov ((X(1:2,ind)')), mean(X(1:2,ind),2),...
         %   'conf', 0.8, 'style', 'b'); % Por elipse de gaussiana
        
         %contorno_hist ( X(:,ind), resolucion ); % Por histograma
    
    else
        % Si no hay suficientes puntos, daría error
        Area = size(X,2);
        Cont = 1;
    end

    % El if está por que si me quedan solo 2 puntos, no puedo calcular el área
end