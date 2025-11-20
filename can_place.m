function ok = can_place(G, r, c, val)

%'ok' tells the game if a specific move is allowed by the rules of Sudoku.
%The function checks rows, columns, and 3x3 blocks.
%True (1): No conflicts found
%False (0): A conflict exists

ok = true;
if val < 1 || val > 9
    ok = false; return;
end
for j = 1:9
    if G(r,j) == val
        ok = false; return;
    end
end
for i = 1:9
    if G(i,c) == val
        ok = false; return;
    end
end
r0 = floor((r-1)/3)*3 + 1;
c0 = floor((c-1)/3)*3 + 1;
for i = r0:(r0+2)
    for j = c0:(c0+2)
        if G(i,j) == val
            ok = false; return;
        end
    end
end
end

