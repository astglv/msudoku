function [grid, invalidMask] = read_grid_from_handles(cellHandles)
% READ_GRID_FROM_HANDLES Načíta hodnoty z GUI editovacích polí
grid = zeros(9);
invalidMask = false(9);
for i = 1:81
    str = strtrim(get(cellHandles(i), 'String'));
    if isempty(str)
        grid(i) = 0;
        continue;
    end
    val = str2double(str);
    if isnan(val) || val < 1 || val > 9 || val ~= floor(val)
        invalidMask(i) = true;
    else
        grid(i) = val;
    end
end
end
