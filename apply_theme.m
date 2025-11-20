function apply_theme(fig)
% APPLY_THEME  Applies the active theme colors and fonts to the GUI.
if nargin < 1 || isempty(fig) || ~ishandle(fig)
    fig = gcf;
end

style = getappdata(fig,'style');
if isempty(style) || ~isfield(style,'themes')
    return;
end

theme = get_active_theme(fig);
if isempty(theme)
    return;
end

set(fig,'Color',theme.figureBg);

cellHandles = getappdata(fig,'cellHandles');
for idx = 1:numel(cellHandles)
    h = cellHandles(idx);
    if ~ishandle(h)
        continue;
    end
    if strcmpi(get(h,'Enable'),'inactive')
        bg = theme.prefillBg;
        fg = theme.prefillText;
    else
        bg = theme.cellBg;
        fg = theme.cellText;
    end
    set(h,'BackgroundColor',bg,...
        'ForegroundColor',fg,...
        'FontName',style.fontName,...
        'FontSize',style.cellFontSize);
end

buttonHandles = getappdata(fig,'buttonHandles');
for idx = 1:numel(buttonHandles)
    h = buttonHandles(idx);
    if ~ishandle(h)
        continue;
    end
    set(h,'BackgroundColor',theme.buttonBg,...
        'ForegroundColor',theme.buttonText,...
        'FontName',style.fontName,...
        'FontSize',style.buttonFontSize);
end

statusHandle = getappdata(fig,'statusHandle');
if ~isempty(statusHandle) && ishandle(statusHandle)
    set(statusHandle,'BackgroundColor',theme.statusBg,...
        'ForegroundColor',theme.statusText,...
        'FontName',style.fontName,...
        'FontSize',style.statusFontSize);
end

movesHandle = getappdata(fig,'movesHandle');
if ~isempty(movesHandle) && ishandle(movesHandle)
    set(movesHandle,'BackgroundColor',theme.statusBg,...
        'ForegroundColor',theme.statusText,...
        'FontName',style.fontName,...
        'FontSize',style.statusFontSize);
end

mistakesHandle = getappdata(fig,'mistakesHandle');
if ~isempty(mistakesHandle) && ishandle(mistakesHandle)
    set(mistakesHandle,'BackgroundColor',theme.statusBg,...
        'ForegroundColor',theme.statusText,...
        'FontName',style.fontName,...
        'FontSize',style.statusFontSize);
end

update_theme_button(fig,theme);
end

function update_theme_button(fig,theme)
btn = getappdata(fig,'themeButton');
if isempty(btn) || ~ishandle(btn)
    return;
end
label = sprintf('Theme: %s',theme.displayName);
set(btn,'String',label);
end
