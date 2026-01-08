function load_puzzle_from_file(fig, filename)
% LOAD_PUZZLE_FROM_FILE  loads a Sudoku puzzle from a .txt file.
%
% The file should contain 9 lines, each with 9 digits (0-9) separated by spaces.
% 0 represents an empty cell.

if nargin < 2 || isempty(filename)
    update_status(fig, 'Status: no filename provided');
    return;
end
if ~exist(filename, 'file')
    update_status(fig, sprintf('Status: file not found: %s', filename));
    return;
end

fid = fopen(filename, 'r');
puzzle = zeros(9, 9);
lineNum = 1;
while ~feof(fid) && lineNum <= 9
    line = fgetl(fid);
    if ischar(line)
        numbers = sscanf(line, '%d');
        if length(numbers) >= 9
            puzzle(lineNum, :) = numbers(1:9);
        end
    end
    lineNum = lineNum + 1;
end
fclose(fid);

% validate puzzle (should be 9x9, values 0-9)
if ~isequal(size(puzzle), [9 9])
    update_status(fig, 'Status: invalid puzzle format (must be 9x9)');
    return;
end
if any(puzzle(:) < 0) || any(puzzle(:) > 9)
    update_status(fig, 'Status: invalid values (must be 0-9)');
    return;
end

% load puzzle
cellHandles = getappdata(fig, 'cellHandles');
if isempty(cellHandles)
    update_status(fig, 'Status: GUI not initialized');
    return;
end

for r = 1:9
    for c = 1:9
        h = cellHandles(r, c);
        if puzzle(r, c) == 0
            set(h, 'String', '', 'Enable', 'on');
        else
            set(h, 'String', num2str(puzzle(r, c)), 'Enable', 'inactive');
        end
    end
end

% try to solve the puzzle to get full solution
[solvedG, ok] = solve_iterative(puzzle);
if ok
    setappdata(fig, 'fullGrid', solvedG);
else
    setappdata(fig, 'fullGrid', zeros(9));
    setappdata(fig, 'gameActive', false);
    cellHandles = getappdata(fig, 'cellHandles');
    set(cellHandles, 'Enable', 'off');
    update_status(fig, 'ERROR: This puzzle has no solution! Game Stopped.');
    return;
end

setappdata(fig, 'puzzle', puzzle);
setappdata(fig, 'moves', 0);
setappdata(fig, 'mistakes', 0);
setappdata(fig, 'gameActive', true);

apply_theme(fig);
update_status(fig, sprintf('Status: loaded puzzle from %s', filename));

set_buttons_enabled(fig, 'on')
end