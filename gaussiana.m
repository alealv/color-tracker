function [ out ] = gaussiana(x, mu, sigma)

% Funcion gaussiana normalizada (maximo = 1)

    out = exp( -(x-mu).^2 ./ (2*sigma.^2) );

end

