function highlight_cells(h, mask)
% HIGHLIGHT_CELLS Zvýrazní bunky s chybou (ružová farba)
idx = find(mask);
for k = 1:numel(idx)
    set(h(idx(k)), 'BackgroundColor', [1 0.7 0.7]);
end
end
