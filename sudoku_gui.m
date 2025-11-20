function sudoku_gui(showIntro, loadPuzzleFile)
% SUDOKU_GUI  Initializes the Sudoku GUI layout and shared state.
%
% Input parameters:
%   showIntro - (optional) logical, if true shows game introduction (default: true)
%   loadPuzzleFile - (optional) string, path to .txt file to load puzzle from (default: '')

% Default input parameters
% nargin - returns the number of function input arguments
% given in the call to the currently executing function
if nargin < 1
    showIntro = true;
end
if nargin < 2
    loadPuzzleFile = '';
end

% Game introduction at the beginning
if showIntro
    introText = {
        '                  === SUDOKU GAME ===';
        ' ';
        'RULES:';
        '- Fill the 9x9 grid with digits 1-9';
        '- Each row must contain all digits 1-9 exactly once';
        '- Each column must contain all digits 1-9 exactly once';
        '- Each 3x3 block must contain all digits 1-9 exactly once';
        ' ';
        'CONTROLS:';
        '- Click on cells to enter numbers (1-9)';
        '- New (Easy/Medium/Hard): Generate a new puzzle';
        '- Check: Validate your entries and find conflicts';
        '- Solve: Auto-complete the puzzle';
        '- Clear Entries: Remove only your entered digits';
        '- Clear All: Reset the entire board';
        '- Theme: Toggle between Day and Night themes';
        ' ';
        'SCORING:';
        '- Moves: Number of moves you made';
        '- Mistakes: You lose after 5 mistakes';
        '- Win: Complete the puzzle correctly!'
    };

    msgbox(introText, 'Welcome to Sudoku', 'help');
end

hFig = figure('Name','Sudoku','NumberTitle','off',...
              'Position',[200 200 660 620],...
              'MenuBar','none','Resize','off');
movegui(hFig,'center');

style = build_style();

cellSize = 45;
gap = 2;
blockGap = 10;
startX = 20;
startY = 580;

% matrix 9x9
cellHandles = zeros(9);
for r = 1:9
    for c = 1:9
        % floor((c-1)/3) / floor((r-1)/3) -
        % в каком 3x3 блоке (от 0 до 2) находится текущая ячейка
        % addX и addY дополнительное смещение к координатам,
        % чтобы создать толстые линии (пробелы) между блоками 3x3
        addX = floor((c-1)/3)*blockGap;
        addY = floor((r-1)/3)*blockGap;

        x = startX + (c-1)*(cellSize+gap) + addX;
        y = startY - (r)*(cellSize+gap) - addY;

        cellHandles(r,c) = uicontrol('Style','edit','String','',...
            'Position',[x y cellSize cellSize],...
            'FontSize',style.cellFontSize,'FontName',style.fontName,...
            'HorizontalAlignment','center',...
            % tag  - Присваивает ячейке уникальный идентификатор
            %(например, 'cell_1_1' для верхнего левого угла)
            'Tag',sprintf('cell_%d_%d',r,c),...
            'BackgroundColor',style.themes.day.cellBg,...
            'Callback',@(src,~)cell_edit_callback(src));
    end
end

btnX = 500;
btnW = 140;
btnH = 35;

buttonHandles = zeros(1,9);
buttonHandles(1) = makeButton(btnX, 520, btnW, btnH, 'New (Easy)',...
    @(src,evt)generate_button_callback(src,'easy'));
buttonHandles(2) = makeButton(btnX, 475, btnW, btnH, 'New (Medium)',...
    @(src,evt)generate_button_callback(src,'medium'));
buttonHandles(3) = makeButton(btnX, 430, btnW, btnH, 'New (Hard)',...
    @(src,evt)generate_button_callback(src,'hard'));
buttonHandles(4) = makeButton(btnX, 360, btnW, btnH, 'Solve',...
    @solve_button_callback);
buttonHandles(5) = makeButton(btnX, 315, btnW, btnH, 'Check',...
    @check_button_callback);
buttonHandles(6) = makeButton(btnX, 270, btnW, btnH, 'Clear Entries',...
    @clear_entries_callback);
buttonHandles(7) = makeButton(btnX, 225, btnW, btnH, 'Clear All',...
    @clear_button_callback);
buttonHandles(8) = makeButton(btnX, 180, btnW, btnH, 'Theme: Day',...
    @toggle_theme_callback);
buttonHandles(9) = makeButton(btnX, 135, btnW, btnH, 'Load Puzzle',...
    @load_puzzle_callback);
themeButton = buttonHandles(8);

statusHandle = uicontrol('Style','text','String','Status: ready',...
    'Position',[20 20 610 30],...
    'Tag','status_box','HorizontalAlignment','left',...
    'FontSize',style.statusFontSize,'FontName',style.fontName);

movesHandle = uicontrol('Style','text','String','Moves: 0',...
    'Position',[20 55 200 30],...
    'Tag','moves_box','HorizontalAlignment','left',...
    'FontSize',style.statusFontSize,'FontName',style.fontName);

mistakesHandle = uicontrol('Style','text','String','Mistakes: 0/5',...
    'Position',[240 55 200 30],...
    'Tag','mistakes_box','HorizontalAlignment','left',...
    'FontSize',style.statusFontSize,'FontName',style.fontName);

setappdata(hFig,'cellHandles',cellHandles);
setappdata(hFig,'buttonHandles',buttonHandles);
setappdata(hFig,'themeButton',themeButton);
setappdata(hFig,'statusHandle',statusHandle);
setappdata(hFig,'finalElapsed',0);
setappdata(hFig,'isOctave',exist('OCTAVE_VERSION','builtin')~=0);
setappdata(hFig,'movesHandle',movesHandle);
setappdata(hFig,'mistakesHandle',mistakesHandle);
setappdata(hFig,'fullGrid',zeros(9));
setappdata(hFig,'puzzle',zeros(9));
setappdata(hFig,'moves',0);
setappdata(hFig,'mistakes',0);
setappdata(hFig,'gameActive',false);
setappdata(hFig,'style',style);
setappdata(hFig,'currentTheme','day');
setappdata(hFig,'loadPuzzleFile',loadPuzzleFile);

apply_theme(hFig);

% Load puzzle from file if provided
if ~isempty(loadPuzzleFile)
    load_puzzle_from_file(hFig, loadPuzzleFile);
end

    function hBtn = makeButton(x,y,w,h,label,cb)
        hBtn = uicontrol('Style','pushbutton','String',label,...
            'Position',[x y w h],...
            'FontName',style.fontName,...
            'FontSize',style.buttonFontSize,...
            'Callback',cb);
    end

    function s = build_style()
        s = struct();
        s.fontName = 'Arial Rounded MT Bold';
        s.cellFontSize = 18;
        s.buttonFontSize = 12;
        s.statusFontSize = 12;
        s.themeOrder = {'day','night'};
        s.themes.day = struct(...
            'name','day',...
            'displayName','Day',...
            'figureBg',[0.97 0.97 0.98],...
            'cellBg',[1 1 1],...
            'cellText',[0.1 0.1 0.1],...
            'prefillBg',[0.92 0.95 1],...
            'prefillText',[0 0.2 0.6],...
            'buttonBg',[0.88 0.92 0.98],...
            'buttonText',[0.1 0.1 0.1],...
            'statusBg',[0.9 0.93 0.98],...
            'statusText',[0.05 0.05 0.05],...
            'highlight',[1 0.7 0.7],...
            'correctHighlight',[0.7 1 0.7]);
        s.themes.night = struct(...
            'name','night',...
            'displayName','Night',...
            'figureBg',[0.12 0.13 0.17],...
            'cellBg',[0.18 0.19 0.24],...
            'cellText',[0.92 0.92 0.95],...
            'prefillBg',[0.22 0.24 0.32],...
            'prefillText',[0.85 0.92 1],...
            'buttonBg',[0.25 0.28 0.35],...
            'buttonText',[0.95 0.95 0.95],...
            'statusBg',[0.16 0.18 0.24],...
            'statusText',[0.95 0.95 0.95],...
            'highlight',[0.85 0.35 0.35],...
            'correctHighlight',[0.35 0.85 0.35]);
    end
end

