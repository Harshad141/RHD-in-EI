%can embeed 12288 bits
%3 bits per block

clc;
clear all;
close all;


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

%F=uint8(randi([0,1],[1,2*NB]));
I1=imread('F.dib');
I1=rgb2gray(I1);
I1=imresize(I1,[128,96]);
F=imbinarize(I1);
F=reshape(F,[1,12288]);
%rng is a key given to create a pseudo random matrix M0 and M1

rng(100);
%M0 and M1 are pseudo-random matrix of size RxC
M0=uint8(randi(255,[R,C]));
rng(200);
M1=uint8(randi(255,[R,C]));
rng(300);
M2=uint8(randi(255,[R,C]));

%n=fix(size(M,1)/2)
%M0=M(1:512,:,:);
%M1=M(513:1024,:,:);
%M1=imdivide(M,2);
%n = ceil(numel(M)/2);
%M0=M(1:512);
%M1=M(513:1024);
%rng(200);
%M1=uint8(randi(255,[R,C]));

K=1;
E=uint8(zeros(R,C));

for i=1:B:R
    for j=1:B:C
        L=I((i:i+B-1),(j:j+B-1));
        L0=M0((i:i+B-1),(j:j+B-1));
        L1=M1((i:i+B-1),(j:j+B-1));
        L2=M2((i:i+B-1),(j:j+B-1));
        B0=F(1,K);
        B1=F(1,(K+1));
        B2=F(1,(K+2));
        K=K+3;
        %Multi level encryption (XOR) coming up
        
        L3=bitxor(L0,L1);
        L4=bitxor(L1,L2);
        L5=bitxor(L,L0);
        
        if B0==0 && B1==0 && B2==0
            LE=L5;
        elseif B0==0 && B1==0 && B2==1
            LE=bitxor(L,L1);
        elseif B0==0 && B1==1 && B2==0
            LE=bitxor(L1,L2);
        elseif B0==0 && B1==1 && B2==1
            LE=L3;
        elseif B0==1 && B1==0 && B2==0
            LE=bitxor(L,L3);
        elseif B0==1 && B1==0 && B2==1
            LE=bitxor(L,L4);
        elseif B0==1 && B1==1 && B2==0
            LE=bitxor(L0,L4);
        else 
            LE=bitxor(L5,L4);
        end
        
       E((i:i+B-1),(j:j+B-1))=LE;
       
    end
end
imshow(E);
imhist(E);
