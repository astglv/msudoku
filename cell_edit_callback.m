function cell_edit_callback(hCell, ~)
% CELL_EDIT_CALLBACK Spracovanie manuálneho zadania čísla do bunky
fig = gcf;
s = strtrim(get(hCell, 'String'));

if isempty(s)
    update_status(fig, 'Bunka vymazaná');
    return;
end

val = str2double(s);
if isnan(val) || val < 1 || val > 9 || val ~= floor(val)
    set(hCell, 'String', '');
    update_status(fig, 'Chyba: Zadajte celé číslo 1-9');
else
    m = getappdata(fig, 'moves') + 1;
    setappdata(fig, 'moves', m);
    mh = getappdata(fig, 'movesHandle');
    if ishandle(mh), set(mh, 'String', sprintf('Moves: %d', m)); end
    update_status(fig, sprintf('Zadané číslo %d', val));
end
end
