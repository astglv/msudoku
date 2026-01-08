function highlight_cells(cellHandles, mask, color)
% HIGHLIGHT_CELLS  Sets the background color for cells specified by mask.

if nargin < 3
    color = [1 0.8 0.8];
end
if any(mask(:))
    set(cellHandles(mask), 'BackgroundColor', color);
end
end