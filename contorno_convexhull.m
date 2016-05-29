function [Sup, Cont] = contorno_convexhull( X )
% Devuelve los puntos del contorno y despues se grafica en gui.m

    xx=X(1,:);
    
    yy=X(2,:);
    
    Cont = convhull(xx,yy);    

%     Esta funcion devuelve el centro de masa en x e y, el perimetro y el
%     area
%     
%     [ geom, iner, cpmo ] = polygeom( xx(Cont),yy(Cont) );
%     area = geom(1);
%     %x_cen = geom(2);
%     %y_cen = geom(3);
%     perimeter = geom(4);
%     
%     disp( [ 'Características del Contorno ' ] )
%     disp( ['Area       Perimetro' ] )
%     disp( [ area       perimeter ] )

%   Polyarea devuelve solo el area
    Sup = polyarea(xx(Cont),yy(Cont));
    
% --------------COMENTAR PARA VERSION CON GUI---------------%
    hold on;
    plot(xx(Cont),yy(Cont),'w-','LineWidth',2);
    hold off;
% ----------------------------------------------------------%    
    
    
end

