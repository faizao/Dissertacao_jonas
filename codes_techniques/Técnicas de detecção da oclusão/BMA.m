function [vet,vet2] = deteccao_blocos(teste)
[lin,qtde_imgs] = size(teste);
dim = sqrt(lin);

teste = detector_oclusao_limiar(teste);
dim_mascara = 2; % J� que a imagem � 128x128 � interessante colocar uma mascara m�ltipla de 2,4,8,16,32 e 64.

vet = [];
vet2 = [];
for im =1: qtde_imgs
    
    imagem = teste(:,im);
    imagem = reshapeIm(imagem);
    
    for i=1:dim_mascara:dim
        
        for k=1:dim_mascara:dim
            mascara = imagem(i:i+dim_mascara-1,k:k+dim_mascara-1); % fun��o para pegar a m�scara
            [l,c] = size(mascara);
            tamMascara = l*c; %Pegar a quantidade pixels existentes
            
            pixelsOcluidos = find(mascara == 0); % Olhar quais pixels est�o oclu�dos
            [l,c] = size(pixelsOcluidos);
            tamPixelsOcluidos = l*c; %Olhando o percentual de pixels oclu�dos
            
            percentual = (tamPixelsOcluidos*100)/tamMascara; %Percentual de pixels oclu�dos
            
            if percentual >= 25 %Se o percentual de pixels oclu�dos for maior que 25% deixo todo o bloco preto.
                imagem(i:i+dim_mascara-1,k:k+dim_mascara-1) = 0;
            end
            
        end
    end
    
    bin = imagem > 0;
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'dilate');
    bin = bwmorph(bin,'dilate');
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'erode');
    bin = bwmorph(bin,'dilate');
    bin = bwmorph(bin,'dilate');
    bin = bwmorph(bin,'dilate');
    vet2 = [vet2,bin(:)];
    p = bin == 0;
    imagem(p) = 0;
    vet = [vet,imagem(:)];
end

vet = double(vet);


end




