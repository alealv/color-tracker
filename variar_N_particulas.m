function [X, W] = variar_N_particulas(X, W, Area, N_part_max, resolucion)
% Variacion del número de partículas en función del área

    N_part_ant = size(X,2); % N° partículas anteriores
    
    Area = round(Area); % Area
    
    if (Area > N_part_ant) % Si el área es mayor, creamos partículas

        if(Area>N_part_max) 
            Area = N_part_max; % Límite máximo
        end
        
        %Para generarlas dentro de donde ya localizacmos al objeto
        Xmin = min(X(1,:));
        Ymin = min(X(2,:));
        Xmax = max(X(1,:));
        Ymax = max(X(2,:));
        X_nuevas = crear_particulas([Xmin Ymin], [Xmax Ymax], (Area - N_part_ant));
        
        %Para generarlas en todo el frame       
        %X_nuevas = crear_particulas([1 1], resolucion, Area - N_part_ant); % Ancho x Alto
        
        X = [X X_nuevas];
        W_nuevos = zeros(1,Area-N_part_ant);
        W = [W W_nuevos];

    elseif (Area < N_part_ant) % Si el área es mayor, eliminamos partículas
    
        [~, W_ind] = sort(W,2,'descend');
        W_ind = W_ind(1:Area);
        W = W(W_ind);
        X = X(:,W_ind);        
    
    end
end