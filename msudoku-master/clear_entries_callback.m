function clear_entries_callback(~, ~)
% CLEAR_ENTRIES_CALLBACK Vymaže len užívateľom zadané čísla
fig = gcf;
h = getappdata(fig, 'cellHandles');
for i = 1:81
    if strcmpi(get(h(i), 'Enable'), 'on')
        set(h(i), 'String', '');
    end
end
apply_theme(fig);
update_status(fig, 'Užívateľské zadania vymazané');
end
