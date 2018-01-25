function y = gammaFunc(x, x0, l, h)
  %% x0 -> centre
  %% l -> largeur
  %% h -> hauteur

  X = x - x0;

  F = X.*X < l.*l;

  y.v = F .* (h .* exp(-1 ./ (l.*l - X.*X)));
  y.d1 = F .* (-2 .* X ./ (l.*l-X.*X).^2 .* y.v);
end
