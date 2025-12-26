function apply_theme(fig)
% APPLY_THEME Nastaví farby buniek podľa ich stavu (fixné hodnoty)
h = getappdata(fig, 'cellHandles');
for i = 1:81
    if strcmpi(get(h(i), 'Enable'), 'inactive')
        set(h(i), 'BackgroundColor', [0.92 0.95 1], 'ForegroundColor', [0 0.2 0.6]);
    else
        set(h(i), 'BackgroundColor', [1 1 1], 'ForegroundColor', [0.1 0.1 0.1]);
    end
end
end
