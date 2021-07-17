clear all;
close all;
clc;
%origional image=I
I=imread('man.tiff');
I=imresize(I,[512,512]);
[R,C,Z]=size(I);
if Z==3
    I=rgb2gray(I);
end
%division of I into blocks B of size BxB
B=8;
%NB=number of blocks
NB=floor(R/B)*floor(C/B);
%F=fingureprint image (Binary)
F=uint8(randi([0,1],[1,2*NB]));
%rng is a key given to create a pseudo random matrix M0 and M1
rng(100);
%M0 and M1 are pseudo-random matrix of size RxC
M0=uint8(randi(255,[R,C]));
rng(200);
M1=uint8(randi(255,[R,C]));
K=1;
 E=uint8(zeros(R,C));
for i=1:B:R
    for j=1:B:C
        L=I((i:i+B-1),(j:j+B-1));
        L0=M0((i:i+B-1),(j:j+B-1));
        L1=M1((i:i+B-1),(j:j+B-1));
        B0=F(1,K);
        B1=F(1, (K+1));
        K=K+2;
       
        %Multi level encryption (XOR) coming up
        L3=bitxor(L0,L1);
        if B0==0 && B1==0
            LE=L3  ;
        elseif B0==0 && B1==1
            LE=bitxor(L,L0);
        elseif B0==1 && B1==0
            LE=bitxor(L,L1);
        else 
            LE=bitxor(L,L3);
        end
       E((i:i+B-1),(j:j+B-1))=LE;
    end
end
imshow(E);
