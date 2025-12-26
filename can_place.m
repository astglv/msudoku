function ok = can_place(G, r, c, val)
% CAN_PLACE Kontrola, či je možné umiestniť číslo na danú pozíciu
% Kontroluje riadok, stĺpec a príslušný 3x3 štvorec.
ok = true;
if val < 1 || val > 9, ok = false; return; end

% Kontrola riadku a stĺpca
if any(G(r,:) == val), ok = false; return; end
if any(G(:,c) == val), ok = false; return; end

% Kontrola 3x3 bloku
r0 = floor((r-1)/3)*3 + 1;
c0 = floor((c-1)/3)*3 + 1;
block = G(r0:r0+2, c0:c0+2);
if any(block(:) == val), ok = false; return; end
end
