function yrs = reconstruir_face(E,imagem)
w = E'*imagem(:); %Realizo a reconstru��o de toda a amostra
yrs = E*w;
end
