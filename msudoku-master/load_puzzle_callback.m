function load_puzzle_callback(~, ~)
% LOAD_PUZZLE_CALLBACK Otvorí dialóg na výber súboru
fig = gcf;
[filename, pathname] = uigetfile('*.txt', 'Vybrať Sudoku súbor');
if ~isequal(filename, 0)
    update_status(fig, ['Vybraný súbor: ', filename]);
end
end
