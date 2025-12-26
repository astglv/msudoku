function generate_button_callback(~, level)
% GENERATE_BUTTON_CALLBACK Generuje novú hru podľa obtiažnosti
fig = gcf;
fullG = generate_full();

switch lower(level)
    case 'easy', b = 30;
    case 'medium', b = 40;
    case 'hard', b = 50;
end

puz = make_puzzle(fullG, b);
h = getappdata(fig, 'cellHandles');

for i = 1:81
    if puz(i) == 0
        set(h(i), 'String', '', 'Enable', 'on');
    else
        set(h(i), 'String', num2str(puz(i)), 'Enable', 'inactive');
    end
end

setappdata(fig, 'fullGrid', fullG);
setappdata(fig, 'moves', 0);
setappdata(fig, 'mistakes', 0);
set(getappdata(fig,'movesHandle'), 'String', 'Moves: 0');
set(getappdata(fig,'mistakesHandle'), 'String', 'Mistakes: 0/5');

apply_theme(fig);
update_status(fig, ['Nová hra: ', level]);
end
