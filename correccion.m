function [ X ] = correccion( X, resolucion )
% Corrige los valores de las posiciones de las particulas por 
% si se fueron de la imagen

    Alto  = resolucion(2); % Alto de la pantalla
    Ancho = resolucion(1); % Ancho de la pantalla

    % Redondeamos los x e y de las particulas para que correspondan al
    % valor de un �ndice del frame
    X = round(X);
    
    X = X'; %Hago la transpuesta porque es m�s facil para manejar el indice

    % Me fijo que ningun valor de las part�culas se vaya del Frame
    indx = X(:,1)<1 | X(:,1)>Ancho;
    indy = X(:,2)<1 | X(:,2)>Alto;    
    ind = indx | indy;

    % Si est�n afuera, las reinicializamos
    X(ind) = randi(Ancho,size(X(ind),1),1);
    X(ind,2) = randi(Alto,size(X(ind),1),1);
    X(ind,3:6) = zeros (size(X(ind),1),4);
    
    X = X'; % La vuelvo a la posici�n original

end

