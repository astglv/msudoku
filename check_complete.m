function ok = check_complete(G)
% CHECK_COMPLETE  Validates that the grid is a complete Sudoku solution.
reference = 1:9;

%'ok' returns true only if the grid is completely full AND correct by the rules
for i = 1:9
    if ~isequal(sort(G(i,:)), reference)
        ok = false;
        return;
    end
end

for j = 1:9
    if ~isequal(sort(G(:,j))', reference)
        ok = false;
        return;
    end
end

for r0 = 1:3:7
    for c0 = 1:3:7
        block = G(r0:r0+2, c0:c0+2);
        if ~isequal(sort(block(:))', reference)
            ok = false;
            return;
        end
    end
end

ok = true;
end


