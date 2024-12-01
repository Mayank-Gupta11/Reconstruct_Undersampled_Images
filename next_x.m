function x=next_x(x_in,xp,alpha, l,m)
    x=x_in+1;
    i=0;
    disp("GD");
    while (norm(x-x_in)>0.0000000001 && i<1000)
        x=x_in;
        % tp=(A'*(A*x_in-y));
        x_in=x_in-alpha*l*grad_tot_var(x_in-xp,m)-(1-alpha)*l*grad_tot_var(x_in,m);
        % x_in=x_in-(alpha*l*grad_tot_var(x_in-xp,m)+(1-alpha)*l*grad_tot_var(x_in,m))./total_var(x_in, 0.0001, m)-0.5*l*tp./norm(A*xp)^2;
        
        i=i+1;
        % if (mod(i,100)==0)
        % 
        %     disp(i);
        % end
    end
    
end