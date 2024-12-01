
function [R,theta] = radon_matrix(N1,N2,Np)
% returns the matrix form of Radon transform  
% 
% Inputs
% ------
% N1,N2 : size of input x
% Np : no. of equi-angular spaced projections (integer)
%
% Output
% -----
% returns R (matrix) and theta (vector of angles)
%
% Info
% ------
% R = radonMtx(N1,N2,theta);
% R is a matrix such that for input x of size (N1,N2), multiplication 
% by R is equivalent to computing the Radon transform of x, i.e., 
% y = R*x(:) = radon(x,theta);
%
% It also saves the matrix R as a mat file in the format radon_N1_N2_Np.mat


    N = N1*N2;
    
    % create the angle vector
    % theta = (0:Np-1)*180/Np;
    theta = sort(rand(1,Np)*180);
    
    
    % get the size of R
    e1 = zeros(N1,N2); e1(1) = 1;
    r1 = radon(e1,theta(1));
    M  = size(r1,1);
    R  = zeros(M*Np,N);
    
    clearvars r1 e1;
    
    for k=1:Np
        for i=1:N
            ei = zeros(N1,N2); ei(i) = 1;
            ri = radon(ei,theta(k));
            R(1+(k-1)*M:k*M,i) = ri;
        end
    end
end




