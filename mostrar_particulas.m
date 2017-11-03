function [X, ind] = mostrar_particulas(X, W, Frame, resolucion, K, W_th)
% Calcula que part�culas se deben mostrar, o si hay que hacer una nueva
% poblaci�n


% --------------COMENTAR PARA VERSION CON GUI---------------%
    % Grafico la imagen
    figure(1)
    image(Frame)
    title('+++ Mostrando Particulas +++')
% ----------------------------------------------------------%


    %Me fijo que part�culas tengo que graficar
    Media = mean(W);  
    ind = W > Media*K; % Grafica las part�culas que son mayores a Media*K

    if(Media < W_th)
        % Si la mayoria de los pesos es baja creo una nueva poblaci�n
        X = crear_particulas([1 1], resolucion, size(X,2)); % Ancho x Alto     
    end

    
% --------------COMENTAR PARA VERSION CON GUI---------------%
    % Grafico las part�culas
    hold on
    plot(X(1,ind), X(2,ind), 'g.')        
    hold off
    drawnow
% ----------------------------------------------------------%

end