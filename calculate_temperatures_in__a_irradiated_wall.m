dx=0.01; %Equi-spaced
alto = 1.0;
ancho = 15.0;
alto = floor(alto/dx);
ancho = floor(ancho/dx);
l = 0; % Counter from scratch
G = zeros(ancho,alto);
for i = 1: ancho
 for j = 1: alto
 l = l + 1;
 G(i,j) = l;
 end
end
%figure; spy(G)
% Equations system
N=l; %Total of unknown 
A=sparse(N,N);
B=zeros(N,1);
To = 20;
Tinf = 10;
h = 15;
H = 260;
K = 2.6;
for i = 1:ancho
 for j = 1: alto
 l = G(i,j);
 if(i>1 && i<ancho && j>1 && j<alto)
 A(l,G(i,j))=-4;
 A(l,G(i+1,j))=1;
 A(l,G(i-1,j))=1;
 A(l,G(i,j+1))=1;
 A(l,G(i,j-1))=1;
 continue;
 elseif(j==alto)
 A(l,l)=1;
 B(l)=To;
 continue;
 elseif(j==1)
18
 if(i==1)
 A(l,G(i,j))=-4;
 A(l,G(i+1,j))=2;
 A(l,G(i,j+1))=2;
 B(l)=0;
 continue;
 elseif(i==ancho)
 A(l,G(i,j))=-4;
 A(l,G(i-1,j))=2;
 A(l,G(i,j+1))=2;
 B(l)=0;
 continue;
 else
 A(l,G(i,j))=-4;
 A(l,G(i-1,j))=1;
 A(l,G(i+1,j))=1;
 A(l,G(i,j+1))=2;
 B(l)=0;
 continue;
 end
 elseif(i==1)
 A(l,G(i,j))=-4;
 A(l,G(i+1,j))=2;
 A(l,G(i,j-1))=1;
 A(l,G(i,j+1))=1;
 B(l)=-2*H*dx/K;
 continue;
 elseif(i==ancho)
 A(l,G(i,j))=-(h*dx+2*K);
 A(l,G(i,j+1))=K/2;
 A(l,G(i-1,j))=K;
 A(l,G(i,j-1))=K/2;
 B(l)=-h*Tinf*dx;
 continue;
 end
 end
end
%spy(A)
%% System solution
U=A\B;
%figure; spy(U)
M1=G*NaN;
for i=1:ancho
for j=1:alto
19
l=G(i,j);
if l>0
M1(i,j)=U(l);
end
end
end
M=M1';