function [grid, invalidMask] = read_grid_from_handles(cellHandles)
% READ_GRID_FROM_HANDLES  Extracts numeric values from the UI grid.
if ~isequal(size(cellHandles),[9 9])
    error('cellHandles must be a 9x9 matrix.');
end

grid = zeros(9);
% invalidMask - typos that aren't numbers(true)
invalidMask = false(9);

for idx = 1:numel(cellHandles)
    str = strtrim(get(cellHandles(idx),'String'));
    if isempty(str)
        grid(idx) = 0;
        continue;
    end

    value = str2double(str);
    if isnan(value) || value < 1 || value > 9 || value ~= floor(value)
        grid(idx) = 0;
        invalidMask(idx) = true;
    else
        grid(idx) = value;
    end
end
end


