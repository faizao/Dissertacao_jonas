function SRC()
addpath(genpath(pwd));
addpath(genpath('C:\Users\jonas\Google Drive\libs\Grafos'));
[conj.treinamento,conj.teste,conj.nomes,conj.numClass] = leituraArquivo(2,'true');
[trainLabel,~] = gerar_rotulos(conj);%Gerando r�tulos
[mascara, mask] = pegarMascara(conj.teste);
qtde_imagens = size(mascara,2);

for i =1: qtde_imagens
    fprintf('\n imagem: %i',i);
    
    [new_tr,new_ts] = gerar_treinamento_oclusao(mascara(:,i),conj.treinamento); %crio um novo treinamento, s� envolvendo os pixels n�o oclu�dos
    imagem = conj.teste(:,i);

    treinamento = sparse_representation(new_ts, new_tr,conj.treinamento,imagem,trainLabel,mask(:,i));%resolvendo codifica��o Esparsa
    
    imagemRec = FRECPCA(treinamento,imagem);

    
    %imagemRec= gerar_grafo(Lfull,GL,GU,mask(:,i));
    
    cd ('C:\Users\jonas\Desktop\conjuntos Yale\SRC_Rec_PCA');
    imwrite(reshapeIm(imagemRec),conj.nomes{i});
    cd ..;

    
end



end

