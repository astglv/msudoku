function highlight_cells(cellHandles, mask, color)
% HIGHLIGHT_CELLS  Sets the background color for cells specified by mask.
if nargin < 3
    color = [1 0.8 0.8];
end

idx = find(mask);
for k = 1:numel(idx)
    set(cellHandles(idx(k)),'BackgroundColor',color);
end
end


