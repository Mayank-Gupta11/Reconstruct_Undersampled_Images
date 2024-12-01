function grad_tv=grad_tot_var(x,M)

    grad_tv=zeros(size(x));
    x=padarray(x,M, 0);
    for i=M+1:size(x,1)-M
        grad_tv(i,1)=-(x(i+1)+x(i+M)-2*x(i))/sqrt((x(i+1)-x(i))^2+(x(i+M)-x(i))^2+1e-4)+(x(i)-x(i-1))/sqrt((x(i)-x(i-1))^2+(x(i-1+M)-x(i-1))^2+1e-4)+(x(i)-x(i-M))/sqrt((x(i-M+1)-x(i-M))^2+(x(i)-x(i-M))^2+1e-4);
    
    end
    grad_tv=grad_tv(M+1:size(grad_tv,1));
end