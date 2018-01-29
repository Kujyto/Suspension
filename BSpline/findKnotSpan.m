function i = findKnotSpan(u,p,U)
    k = numel(U)-1;
    n = k-p-1;
    if u == U(n+1 +1)
        i = n;
        return
    end
    l = p +1;
    h = n+1 +1;
    i = floor((l+h)/2);
    while u < U(i) || u >= U(i+1)
        if u < U(i)
            h = i;
        else
            l = i;
        end
        i = floor((l+h)/2);
    end
    i = i-1;
end