%Funcion para calcular la primera parte de la tarea

a=input('cota1? ');
b=input('cota2? ');
while b-a > 0.01 %Aproximación Iterativa por Método del Valor medio/Bisección
    c=(a+b)/2;
    if (a+5.02-a*cosh(25/a))*(c+5.02-c*cosh(25/c))<0
        b=c;
    else
        a=c;
    end
end
disp('valor c de la catenaria');disp((a+b)/2);     %valor c de la catenaria
disp('valor de la tensión horizontal');disp(100*(a+b)/2);     %valor de la tension horizontal
disp('valor de la tensión en b');disp(100*5.02);      %valor de la tension en b
disp('valor de la carga sobre el extremo derecho del cable(osea "A")');  disp(100*(a+b)*0.5*sinh(25/((a+b)*0.5)));     %valor de la carga sobre el extremo derecho del cable(osea "A")
%algoritmo para resolver el enrejado en base al metodo de los nodos
h=input('Cantidad de variables?');
A=zeros(h,h);Y=cell(1,h);b=zeros(h,1);
disp('nombre todas las fuerzas incluidas las resistencias');
for i=(1:h)%En esta parte se busca crear un vector con todos los nombres de las fuerzas incluidas las resistencias
    Y{1,i}=input('nombre de la fuerza','s');
    
end
for i=(1:2:h)%En esta parte se busca crear la matriz cuadrada A junto con un vector de fuerzas externas "b"
    n=input('nodo?');
    e=input('Magnitud de la fuerza externa sobre este nodo?');
    o=input('Ángulo de la fuerza externa');
    b(2*n-1,1)=-e*cos(o);b(2*n,1)=-e*sin(o);%Se colocan las proyecciones horizontales y verticales de la fuerza externa en el vector "b"
    while true
        d=input('nombre de la fuerza?','s');
        if strcmp(d,'terminé')==1%Se coloca la palabra "termine" para decirle al programa que se han terminado las fuerzas para ese nodo
        break
        end
        j=1;
        while true
            if strcmp(d,Y{1,j})==1
                break
            end
            j=j+1;%Mini programa que busca el lugar de la fuerza segun las columnas de la matriz."j" es el lugar
        end
        f=input('Coloque la proyeccion Horizontal de la barra');
        g=input('Coloque la preyeccion Vertical de la barra');
        A(2*n-1,j)=f/sqrt(f*f+g*g);%Se coloca el indice de la proyeccion horizontal de la fuerza sobre la barra en la matriz "A" 
        A(2*n,j)=g/sqrt(f*f+g*g);%Se coloca el indice de la proyeccion vertical de la fuerza sobre la barra en la matriz "A" 
    end
end
R=inv(A)*b;%R es el vector con las magnitudes de todas las fuerzas

P=cell(1,h);Q=zeros(h,1);nv=1;w=1;
while R(w,1)~=min(R)%Mini programa que busca encontrar la posicion de la fuerza minima en R
    w=w+1;
end
while nv<=h%En vista que profesor dijo que el programa deberia dar las barras mas requeridas esta este programa que ordena de mayor a menor las fuerzas y su nombre
    a=max(max(R),abs(min(R)));i=1;
    while R(i,1)~=a
        i=i+1;
    end
    Q(nv,1)=a;P{1,nv}=Y{1,i};R(i,1)=min(R);nv=nv+1;
end
P{1,h}=Y{1,w};

for i=(1:h)%Se muestra el nombre de cada fuerza con su respectivo valor
    disp(P{1,i})
    disp(Q(i,1))
end
disp('cambiar las fuerzas externas')
for i=(1:2:h)%En esta parte se busca crear la matriz cuadrada A junto con un vector de fuerzas externas "b"
    n=input('nodo?');
    e=input('Magnitud de la fuerza externa nueva sobre este nodo?');
    o=input('Ángulo de la fuerza externa nueva');
    b(2*n-1,1)=-e*cos(o);b(2*n,1)=-e*sin(o);
end
R=inv(A)*b;%R es el vector con las magnitudes de todas las fuerzas

P=cell(1,h);Q=zeros(h,1);nv=1;w=1;
while R(w,1)~=min(R)%Mini programa que busca encontrar la posicion de la fuerza minima en R
    w=w+1;
end
while nv<=h%En vista que profesor dijo que el programa deberia dar las barras mas requeridas esta este programa que ordena de mayor a menor las fuerzas y su nombre
    a=max(max(R),abs(min(R)));i=1;
    while R(i,1)~=a
        i=i+1;
    end
    Q(nv,1)=a;P{1,nv}=Y{1,i};R(i,1)=min(R);nv=nv+1;
end
P{1,h}=Y{1,w};

for i=(1:h)%Se muestra el nombre de cada fuerza con su respectivo valor
    disp(P{1,i})
    disp(Q(i,1))
end