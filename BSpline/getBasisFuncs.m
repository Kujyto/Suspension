function N = getBasisFuncs(u,p,U,i)
    left = zeros(1,p+1);
    right = zeros(1,p+1);
    N = zeros(1,p+1);
    N(1) = 1;
    for j=1:p
        left(j+1) = u - U(i+1-j +1);
        right(j+1) = U(i+j +1) - u;
        s = 0;
        for r=0:j-1
            temp = N(r +1) / (right(r+1 + 1) + left(j-r +1));
            N(r +1) = s + right(r+1 +1) * temp;
            s = left(j-r +1) * temp;
        end
        N(j +1) = s;
    end
end