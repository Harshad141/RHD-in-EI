%can embeed 8192 bits
%2 bits per block
clc;
clear all;
close all;
I=imread('color.jpg');
I=imresize(I,[512,512]);
[R,C,Z]=size(I);

rng(100);
M0=uint8(randi(255,[R,C]));
rng(200);
M1=uint8(randi(255,[R,C]));
rng(300);
M2=uint8(randi(255,[R,C]));
rng(400);
M3=uint8(randi(255,[R,C]));


%
Ired=imread('F1.dib');
Ired=rgb2gray(Ired);
Ired=imresize(Ired,[128,64]);
F1=imbinarize(Ired);
F1=reshape(F1,[1,8192]);

Igreen=imread('F2.dib');
Igreen=rgb2gray(Igreen);
Igreen=imresize(Igreen,[128,64]);
F2=imbinarize(Igreen);
F2=reshape(F2,[1,8192]);

Iblue=imread('F3.dib');
Iblue=rgb2gray(Iblue);
Iblue=imresize(Iblue,[128,64]);
F3=imbinarize(Iblue);
F3=reshape(F3,[1,8192]);

%
Red=I(:,:,1);
BR=8;
NBR=floor(R/BR)*floor(C/BR);
E1=uint8(zeros(R,C));
K=1;
for i=1:BR:R
    for j=1:BR:C
        L=Red((i:i+BR-1),(j:j+BR-1));
        L0=M0((i:i+BR-1),(j:j+BR-1));
        L1=M1((i:i+BR-1),(j:j+BR-1));
        L2=M2((i:i+BR-1),(j:j+BR-1));
        L3=M3((i:i+BR-1),(j:j+BR-1));
        BR0=F1(1,K);
        BR1=F1(1,(K+1));
        K=K+2;
        if BR0==0 && BR1==0
            LER=bitxor(L,L0); 
        elseif BR0==0 && BR1==1
            LER=bitxor(L,L1);
        elseif BR0==1 && BR1==0
            LER=bitxor(L,L2);
        else 
            LER=bitxor(L,L3);
        end
        E1((i:i+BR-1),(j:j+BR-1))=LER;
       
    end
end

%
Green=I(:,:,2);
BG=8;
NBG=floor(R/BG)*floor(C/BG);
E2=uint8(zeros(R,C));
H=1
for i=1:BG:R
    for j=1:BG:C
        L=Green((i:i+BG-1),(j:j+BG-1));
        L0=M0((i:i+BG-1),(j:j+BG-1));
        L1=M1((i:i+BG-1),(j:j+BG-1));
        L2=M2((i:i+BG-1),(j:j+BG-1));
        L3=M3((i:i+BG-1),(j:j+BG-1));
        BG0=F2(1,H);
        BG1=F2(1,(H+1));
        H=H+2;
         if BG0==0 && BG1==0
            LEG=bitxor(L,L0); 
        elseif BG0==0 && BG1==1
            LEG=bitxor(L,L1);
        elseif BG0==1 && BG1==0
            LEG=bitxor(L,L2);
        else 
            LEG=bitxor(L,L3);
        end
        E2((i:i+BG-1),(j:j+BG-1))=LEG;
       
    end
end

%
Blue=I(:,:,3);
BB=8;
NBB=floor(R/BB)*floor(C/BB);
S=1
E3=uint8(zeros(R,C));
for i=1:BB:R
    for j=1:BB:C
        L=Blue((i:i+BB-1),(j:j+BB-1));
        L0=M0((i:i+BB-1),(j:j+BB-1));
        L1=M1((i:i+BB-1),(j:j+BB-1));
        L2=M2((i:i+BB-1),(j:j+BB-1));
        L3=M3((i:i+BB-1),(j:j+BB-1));
        BB0=F3(1,S);
        BB1=F3(1,(S+1));
        S=S+2;
         if BB0==0 && BB1==0
            LEB=bitxor(L,L0); 
        elseif BB0==0 && BB1==1
            LEB=bitxor(L,L1);
        elseif BB0==1 && BB1==0
            LEB=bitxor(L,L2);
        else 
            LEB=bitxor(L,L3);
        end
        E3((i:i+BB-1),(j:j+BB-1))=LEB;
       
    end
end

E=cat(3,E1,E2,E3);
imhist(E);
subplot(2,2,1); image(E);
subplot(2,2,2); image(E1);
subplot(2,2,3); image(E2);
subplot(2,2,4); image(E3);



