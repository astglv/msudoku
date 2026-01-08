function [grid, invalidMask] = read_grid_from_handles(cellHandles)
% READ_GRID_FROM_HANDLES  Extracts numeric values from the UI grid.

grid = zeros(9);
% invalidMask - typos that aren't numbers(true)
invalidMask = false(9);

for i = 1:numel(cellHandles)
    str = strtrim(get(cellHandles(i),'String'));
    if isempty(str)
        grid(i) = 0;
        continue;
    end

    value = str2double(str);
    % Check if input is a valid Sudoku digit (1-9)
    if isnan(value) || value < 1 || value > 9 || value ~= floor(value)
        grid(i) = 0;
        invalidMask(idx) = true;
    else
        grid(i) = value;
    end
end

end