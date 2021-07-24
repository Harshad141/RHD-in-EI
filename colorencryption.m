%can embeed 12288 bits
%3 bits per block
clc;
clear all;
close all;
I=imread('color.jpg');
I=imresize(I,[512,512]);
[R,C,Z]=size(I);
Red=I(:,:,1);
Green=I(:,:,2);
Blue=I(:,:,3);
%division of I into blocks B of size BxB
B=8;
%NB=number of blocks
NB=floor(R/B)*floor(C/B);
%F=fingureprint image (Binary)
%I1=imread('F.dib');
%I1=rgb2gray(I1);
%I1=imresize(I1,[128,96]);
%F=imbinarize(I1);
%F=reshape(F,[1,12288]);
F=uint8(randi([0,1],[1,12*NB]));
rng(100);
M0=uint8(randi(255,[R,C]));
rng(200);
M1=uint8(randi(255,[R,C]));
rng(300);
M2=uint8(randi(255,[R,C]));
K=1;
%Red
E0=uint8(zeros(R,C));
for i=1:B:R
    for j=1:B:C
        L=Red((i:i+B-1),(j:j+B-1));
        L0=M0((i:i+B-1),(j:j+B-1));
        L1=M1((i:i+B-1),(j:j+B-1));
        L2=M2((i:i+B-1),(j:j+B-1));
        B0=F(1,K);
        B1=F(1,(K+1));
        B2=F(1,(K+2));
        K=K+3; 
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
       E0((i:i+B-1),(j:j+B-1))=LE;
    end
end

%Green
%F1=uint8(randi([0,1],[1,2*NB]));
E1=uint8(zeros(R,C));
for i=1:B:R
    for j=1:B:C
        L=Green((i:i+B-1),(j:j+B-1));
        L0=M0((i:i+B-1),(j:j+B-1));
        L1=M1((i:i+B-1),(j:j+B-1));
        L2=M2((i:i+B-1),(j:j+B-1));
        B0=F(1,K);
        B1=F(1,(K+1));
        B2=F(1,(K+2));
        K=K+3; 
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
       E1((i:i+B-1),(j:j+B-1))=LE;
    end
end
E1=uint8(zeros(R,C));
for i=1:B:R
    for j=1:B:C
        L=Green((i:i+B-1),(j:j+B-1));
        L0=M0((i:i+B-1),(j:j+B-1));
        L1=M1((i:i+B-1),(j:j+B-1));
        L2=M2((i:i+B-1),(j:j+B-1));
        B0=F(1,K);
        B1=F(1,(K+1));
        B2=F(1,(K+2));
        K=K+3; 
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
       E1((i:i+B-1),(j:j+B-1))=LE;
    end
end


%Blue
E2=uint8(zeros(R,C));
for i=1:B:R
    for j=1:B:C
        L=Green((i:i+B-1),(j:j+B-1));
        L0=M0((i:i+B-1),(j:j+B-1));
        L1=M1((i:i+B-1),(j:j+B-1));
        L2=M2((i:i+B-1),(j:j+B-1));
        B0=F(1,K);
        B1=F(1,(K+1));
        B2=F(1,(K+2));
        K=K+3; 
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
       E2((i:i+B-1),(j:j+B-1))=LE;
    end
end
subplot(2,2,1); image(E0);
subplot(2,2,2); image(E1);
subplot(2,2,3); image(E2);
