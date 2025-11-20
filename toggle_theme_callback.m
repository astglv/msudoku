function toggle_theme_callback(src,~)
fig = gcf;

style = getappdata(fig,'style');
if isempty(style) || ~isfield(style,'themeOrder')
    return;
end

current = getappdata(fig,'currentTheme');
order = style.themeOrder;
idx = find(strcmp(order,current),1);
if isempty(idx)
    idx = 1;
end
nextIdx = mod(idx, numel(order)) + 1;
nextTheme = order{nextIdx};

setappdata(fig,'currentTheme',nextTheme);
apply_theme(fig);
end


