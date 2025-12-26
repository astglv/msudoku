function G = generate_full()
% GENERATE_FULL Generuje kompletne vyplnenú a platnú mriežku Sudoku
% Používa matematický vzorec a následné premiešanie čísiel a riadkov.
pattern = @(r,c) mod(3*mod(r,3) + floor(r/3) + c, 9) + 1;
G = zeros(9);
for r = 0:8
    for c = 0:8
        G(r+1,c+1) = pattern(r,c);
    end
end

% Náhodné premiešanie číslic 1-9
p = randperm(9);
G = reshape(p(G(:)), 9, 9);

% Náhodné premiešanie riadkov a stĺpcov v rámci 3x3 blokov
for b = 0:2
    idx = b*3 + (1:3);
    G(idx,:) = G(idx(randperm(3)),:);
    G(:,idx) = G(:,idx(randperm(3)));
end
end
