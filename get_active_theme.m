function theme = get_active_theme(fig)
% GET_ACTIVE_THEME  Returns the currently selected theme structure.
theme = [];
if nargin < 1 || isempty(fig) || ~ishandle(fig)
    fig = gcf;
end

style = getappdata(fig,'style');
if isempty(style) || ~isfield(style,'themes')
    return;
end

themeName = getappdata(fig,'currentTheme');
if isempty(themeName) || ~isfield(style.themes,themeName)
    if isfield(style,'themeOrder') && ~isempty(style.themeOrder)
        themeName = style.themeOrder{1};
    else
        names = fieldnames(style.themes);
        themeName = names{1};
    end
    setappdata(fig,'currentTheme',themeName);
end

theme = style.themes.(themeName);
end


