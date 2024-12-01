function x = ART_update(A,b,x, lambda)
    % Number of projections
    [x1,y]=size(A);
    % x=zeros(y,1);
    m = 1;
    x_new=x+100;
    disp("ART");
    % Iterate through each projection
    while m<4000
        x_new=x;
        % Calculate correction term
        i=mod(m,x1)+1;
        r = b(i) - dot(transpose(A(i,:)), x);

        % Update x
        x = x + lambda * (r / (norm(A(i,:))^2+0.0001)) * transpose(A(i,:));
        m=m+1;
    end
end

