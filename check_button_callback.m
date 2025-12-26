function check_button_callback(~, ~)
% CHECK_BUTTON_CALLBACK Kontroluje chyby v mriežke
fig = gcf;
h = getappdata(fig, 'cellHandles');
[G, inv] = read_grid_from_handles(h);

apply_theme(fig);

conflicts = false(9);
for r = 1:9
    for c = 1:9
        v = G(r,c); if v == 0, continue; end
        G(r,c) = 0;
        if ~can_place(G, r, c, v), conflicts(r,c) = true; end
        G(r,c) = v;
    end
end

bad = inv | conflicts;
if any(bad(:))
    highlight_cells(h, bad);
    m = getappdata(fig, 'mistakes') + 1;
    setappdata(fig, 'mistakes', m);
    set(getappdata(fig,'mistakesHandle'), 'String', sprintf('Mistakes: %d/5', m));
else
    update_status(fig, 'Všetko je v poriadku!');
end
end
