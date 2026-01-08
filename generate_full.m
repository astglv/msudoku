function G = generate_full()
% GENERATE_FULL  Creates a random, valid, fully solved Sudoku grid.

% create base grid
pattern = @(r,c) mod(3*mod(r,3) + floor(r/3) + c, 9) + 1;
G = zeros(9,9);
for r = 0:8
    for c = 0:8
        G(r+1,c+1) = pattern(r,c);
    end
end

% shuffle digits
digitPerm = randperm(9);
G = reshape(digitPerm(G(:)), 9, 9);

% shuffle rows within each 3-row band
for band = 0:2
    rows = band*3 + (1:3);
    G(rows,:) = G(rows(randperm(3)),:);
end

% shuffle columns within each 3-column stack
for stack = 0:2
    cols = stack*3 + (1:3);
    G(:,cols) = G(:,cols(randperm(3)));
end

% shuffle the three horizontal bands (3-row blocks)
bandPerm = randperm(3);
rowOrder = [];
for k = 1:3
    rowOrder = [rowOrder, (bandPerm(k)-1)*3 + (1:3)];
end
G = G(rowOrder,:);

% shuffle the three vertical stacks (3-column blocks)
stackPerm = randperm(3);
colOrder = [];
for k = 1:3
    colOrder = [colOrder, (stackPerm(k)-1)*3 + (1:3)];
end
G = G(:,colOrder);

end