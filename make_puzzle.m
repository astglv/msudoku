function P = make_puzzle(fullGrid, blanks)
% MAKE_PUZZLE Vytvorí hádanku odstránením náhodných čísiel z plnej mriežky
P = fullGrid;
P(randperm(81, blanks)) = 0;
end
