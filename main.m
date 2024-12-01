x=im2double(imread('./Dataset/Study2_Rest/data001.png'));
x1=im2double(imread('./Dataset/Study2_Rest/data002.png'));
x2=im2double(imread('./Dataset/Study2_Rest/data003.png'));
x3=im2double(imread('./Dataset/Study2_Rest/data004.png'));
x4=im2double(imread('./Dataset/Study2_Rest/data005.png'));
x5=im2double(imread('./Dataset/Study2_Rest/data006.png'));
x6=im2double(imread('./Dataset/Study2_Rest/data007.png'));
x7=im2double(imread('./Dataset/Study2_Rest/data008.png'));
x8=im2double(imread('./Dataset/Study2_Rest/data009.png'));
x9=im2double(imread('./Dataset/Study2_Rest/data010.png'));
% x=x(1:192,1:192);
% x1=x1(1:192,1:192);
% x2=x2(1:192,1:192);
% x3=x3(1:192,1:192);
% x4=x4(1:192,1:192);
% x5=x5(1:192,1:192);
% x6=x6(1:192,1:192);
% x7=x7(1:192,1:192);
% x8=x8(1:192,1:192);
% x9=x9(1:192,1:192);
[m,n]=size(x);

num_proj=40;
%%
disp('Start making A');

[A,theta]=radon_matrix(m,n,num_proj);
disp('A made');
A=sparse(A);

disp('Start making A');

[A1,theta1]=radon_matrix(m,n,num_proj);
disp('A made');
A1=sparse(A1);



disp('Start making A');
[A2,theta2]=radon_matrix(m,n,num_proj);
disp('A made');
A2=sparse(A2);


disp('Start making A');
[A3,theta3]=radon_matrix(m,n,num_proj);
disp('A made');
A3=sparse(A3);

disp('Start making A');
[A4,theta4]=radon_matrix(m,n,num_proj);
disp('A made');
A4=sparse(A4);

disp('Start making A');
[A5,theta5]=radon_matrix(m,n,num_proj);
disp('A made');
A5=sparse(A5);

disp('Start making A');
[A6,theta6]=radon_matrix(m,n,num_proj);
disp('A made');
A6=sparse(A6);

disp('Start making A');
[A7,theta7]=radon_matrix(m,n,num_proj);
disp('A made');
A7=sparse(A7);

disp('Start making A');
[A8,theta8]=radon_matrix(m,n,num_proj);
disp('A made');
A8=sparse(A8);

disp('Start making A');
[A9,theta9]=radon_matrix(m,n,num_proj);
disp('A made');
A9=sparse(A9);

%%


save("Matrix_A.mat", "A", "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "theta", "theta1", "theta2", "theta3", "theta4", "theta5", "theta6", "theta7", "theta8", "theta9");


%%
load("Matrix_A.mat");

%%
x=x(:);
x1=x1(:);
x2=x2(:);
x3=x3(:);
x4=x4(:);
x5=x5(:);
x6=x6(:);
x7=x7(:);
x8=x8(:);
x9=x9(:);

A=full(A);
y=A*x;

A1=full(A1);
y1=A1*x1;
clear A1;

A2=full(A2);
y2=A2*x2;
clear A2;

A3=full(A3);
y3=A3*x3;
clear A3;

A4=full(A4);
y4=A4*x4;
clear A4;

A5=full(A5);
y5=A5*x5;
clear A5;

A6=full(A6);
y6=A6*x6;
clear A6;

A7=full(A7);
y7=A7*x7;
clear A7;

A8=full(A8);
y8=A8*x8;
clear A8;

A9=full(A9);
y9=A9*x9;
clear A9;


%%
x_prev=ones(size(x));
% x_next=zeros(size(x));
xp=iradon([reshape(y,[],num_proj),reshape(y1,[],num_proj),reshape(y2,[],num_proj),reshape(y3,[],num_proj),reshape(y4,[],num_proj),reshape(y5,[],num_proj),reshape(y6,[],num_proj),reshape(y7,[],num_proj),reshape(y8,[],num_proj),reshape(y9,[],num_proj)],[theta,theta1,theta2,theta3,theta4,theta5,theta6,theta7,theta8,theta9],m,n);
xp=xp(33:224,:);
imshow(xp);
%%
xp=xp(:);
xp=xp-min(xp,[],'all');
xp=xp/max(xp,[], 'all');
l_art=1;
l_gd=10;
x_next=xp;
while norm(A*x_next-y)>90
    tp=x_prev;
    x_prev=x_next;
    if norm(A*x_next-y)>norm(A*tp-y)
        % if l_gd<=1e-10
        %     l_gd=0.01;
        % end
        if l_art<1
            l_art=l_art*10;
        end
        % x_next=tp;
        
        l_gd=l_gd/10;
        disp("L GD changed to")
        disp(l_gd);


    end
    

    %%%% ART step %%%%
    x_next=ART_update(A,y,x_next,l_art);
    % x_next=(x_next-min(min(x_next,[], 'all'),0));
    % x_next=x_next/max(max(x_next,[], 'all'),1);
    % % disp(norm(-x));
    disp(norm(A*x_next-y));
    

    tp=x_prev;
    x_prev=x_next;
    if norm(A*x_next-y)>norm(A*tp-y)
        % l_art=0.01;z
        % if l_art<=1e-10
        %     l_art=0.01;
        % end
        if l_gd<1
            l_gd=l_gd*10;
        end
        % x_next=tp;
        l_art=l_art/10;
        disp("L ART changed to")
        disp(l_art);


    end
    



    %%%% Constrained steepest descent %%%%
    x_next=next_x(x_next, xp,0.9,l_gd,m);
    % disp(norm(x_next-min(x_next,[], 'all')-x));
    % x_next=(x_next-min(min(x_next,[], 'all'),0));
    % x_next=x_next/max(max(x_next,[], 'all'),1);
    disp(norm(A*x_next-y));


    figure;
    imshow(reshape(x_next,m,n));


end