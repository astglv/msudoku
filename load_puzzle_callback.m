function load_puzzle_callback(src,~)
% LOAD_PUZZLE_CALLBACK  opens file dialog to load puzzle from .txt file.

fig = gcf;
[filename, pathname] = uigetfile('*.txt', 'Select a puzzle file');
if isequal(filename, 0) || isequal(pathname, 0)
    update_status(fig, 'Status: file selection cancelled');
    return;
end

fullPath = fullfile(pathname, filename);
load_puzzle_from_file(fig, fullPath);
end