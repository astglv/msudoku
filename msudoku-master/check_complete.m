function ok = check_complete(G)
% CHECK_COMPLETE Overí, či je mriežka kompletne a správne vyplnená
ref = 1:9;
ok = true;
for i = 1:9
    if ~isequal(sort(G(i,:)), ref) || ~isequal(sort(G(:,i))', ref)
        ok = false;
        return;
    end
end
end
