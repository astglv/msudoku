# msudoku

Small MATLAB app that provides a Sudoku GUI with puzzle generation, solving,
and validation helpers.

## Project Requirements Checklist

### Required Conditions (5 points)

- **Game board (playing area) stored in a matrix** - 2 pts
  - The 9x9 Sudoku grid is stored in matrices (`puzzle`, `fullGrid`) and displayed using `uicontrol` edit boxes.

- **Use exactly 2–3 commands that are not mentioned in any PDF** - 0 pts
  - Functions potentially not in PDFs (need verification):
    - `setappdata` / `getappdata` - GUI data storage
    - `movegui` - GUI positioning
    - `uigetfile` - file dialog
    - `msgbox` - message box
    - `fopen`, `fgetl`, `fclose`, `feof`, `sscanf` - file I/O operations
    - `randperm` - random permutation
    - `reshape` - matrix reshaping
    - `ishandle` - GUI handle checking
    - `strcmpi` - case-insensitive string comparison
    - `isfield` - struct field checking
  - Note: Most core functions (`for`, `while`, `if`, `switch`, `zeros`, `ones`, `size`, `numel`, `any`, `all`, `sum`, `sort`, `isequal`, `floor`, `mod`, `num2str`, `str2double`, `sprintf`, `figure`, `uicontrol`, `get`, `set`, `gcf`, `nargin`) are standard and should be in PDFs.

- **Functions, for-loops, while, if, switch used in the form shown in the exercises**
  - All control structures (`for`, `while`, `if`, `switch`) are used throughout the codebase.

- **Working with matrices and vectors as practiced in the exercises**
  - Extensive matrix operations: indexing, assignment, logical masks, reshaping, etc.

- **Use 3 levels/difficulty tiers**
  - Three difficulty levels: Easy (30 blanks), Medium (40 blanks), Hard (50 blanks).

- **Custom map in .txt, at least 2 versions (each student creates one)**
  - Two custom puzzle files: `puzzle1.txt` and `puzzle2.txt`
  - Load functionality via "Load Puzzle" button or input parameter.

### Code

- **At the beginning: briefly introduce the game – rules, controls**
  - Game introduction displayed via `msgbox` when `sudoku_gui()` is called (can be disabled with `sudoku_gui(false)`).
  - Introduction includes: rules, controls, and scoring system.

- **Any input parameters**
  - Function signature: `sudoku_gui(showIntro, loadPuzzleFile)`
  - `showIntro`: logical, controls whether to show introduction (default: true)
  - `loadPuzzleFile`: string, path to .txt file to load puzzle from (default: '')

- **Ability to quit at any time**
  - Window can be closed at any time using the standard window close button
  - No confirmation dialog - closes immediately

- **Winner and number of moves/achieved score**
  - Winner detection: When puzzle is completed correctly, displays "WIN! Completed in X moves"
  - Move counter: Tracks and displays number of moves
  - Score tracking: Shows mistakes count (0/5) and game ends after 5 mistakes
  - Status bar shows current game state and move count

### Aesthetics

- **Foolproofing/error resistance**
  - Input validation: Only accepts integers 1-9
  - File loading: Validates file existence, format (9x9), and value ranges (0-9)
  - Error handling: Try-catch blocks, null checks, handle validation
  - Invalid input feedback: Status messages guide user

- **GUI – create a .fig as done in the exercises**
  - GUI created programmatically using `figure` and `uicontrol`
  - Note: To create a .fig file, open the GUI in MATLAB and use File > Save As to save as .fig
  - All GUI elements are properly structured and themed

- **Code aesthetics**
  - Consistent naming conventions
  - Clear function documentation
  - Organized code structure
  - Readable formatting

- **Code efficiency** 
  - Efficient matrix operations
  - Minimal redundant calculations
  - Proper use of logical indexing
  - Optimized solver algorithm

### Creativity

1. **Day/Night Theme System** - Toggle between two complete visual themes
2. **Custom Puzzle Loading** - Load puzzles from .txt files with file dialog
3. **Mistake Limit System** - Game ends after 5 mistakes with visual feedback
4. **Conflict Highlighting** - Visual highlighting of conflicts in red
5. **Move Counter** - Real-time tracking and display of moves
6. **Clear Entries vs Clear All** - Two-level clearing system
7. **Auto-solver** - Backtracking algorithm to solve puzzles
8. **Status Bar** - Comprehensive status messages throughout gameplay

## Game Rules

- Fill the 9x9 grid with digits 1-9
- Each row must contain all digits 1-9 exactly once
- Each column must contain all digits 1-9 exactly once
- Each 3x3 block must contain all digits 1-9 exactly once

## Controls / How to Play

1. **Start the game**: Run `sudoku_gui` in MATLAB
2. **Generate puzzle**: Click "New (Easy/Medium/Hard)" to create a new puzzle
3. **Enter numbers**: Click on cells and type digits 1-9
4. **Check**: Click "Check" to validate entries and find conflicts (highlighted in red)
5. **Solve**: Click "Solve" to auto-complete the puzzle
6. **Clear Entries**: Remove only your entered digits (keeps original puzzle)
7. **Clear All**: Reset the entire board
8. **Load Puzzle**: Load a custom puzzle from a .txt file
9. **Theme**: Toggle between Day and Night themes
10. **Close**: Close the window using the standard window close button

### Example Usage with Parameters:
```matlab
% Start with introduction
sudoku_gui()

% Start without introduction
sudoku_gui(false)

% Start and load a puzzle file
sudoku_gui(true, 'puzzle1.txt')

% Start without introduction and load puzzle
sudoku_gui(false, 'puzzle2.txt')
```

## File Overview

### Main Files
- `sudoku_gui.m`: UI creation and shared state initialization (with input parameters and introduction)
- `generate_button_callback.m`: puzzle generation for selected difficulty
- `cell_edit_callback.m`: per-cell validation and move counter updates
- `check_button_callback.m`: grid validation and highlighting
- `solve_button_callback.m`: solver entry point and UI updates
- `clear_entries_callback.m`: wipes only user-entered digits
- `clear_button_callback.m`: complete board reset
- `load_puzzle_callback.m`: file dialog for loading puzzles
- `load_puzzle_from_file.m`: loads puzzle from .txt file

### Game Logic
- `generate_full.m`: random full solution generator
- `make_puzzle.m`: removes clues from a full grid
- `solve_iterative.m`: iterative backtracking solver
- `can_place.m`, `check_complete.m`: Sudoku rule helpers

### GUI Utilities
- `read_grid_from_handles.m`, `highlight_cells.m`, `update_status.m`: GUI
- `apply_theme.m`, `get_active_theme.m`, `toggle_theme_callback.m`: theme management

### Custom Puzzle Files
- `puzzle1.txt`: Custom Sudoku puzzle #1
- `puzzle2.txt`: Custom Sudoku puzzle #2