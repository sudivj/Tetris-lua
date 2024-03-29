require ("src/home")

ORIENTATIONS = 4 --Number of orientations per tetra
CELLS = 4 --Number of cells
CELLSIZE = 32 --Cell size

function return_colour(colour)
    tmp = ("sprites/" .. home.settings.theme .. "/" .. CELLCOLOUR[colour])
    return tmp
end

CELLCOLOUR = {
    "blue_b.png",
    "darkblue_b.png",
    "orange_b.png",
    "yellow_b.png",
    "green_b.png",
    "purple_b.png",
    "red_b.png"
}

TETRAMINO = {
    -- I
  {{{1, 0}, {1, 1}, {1, 2}, {1, 3}},
   {{0, 2}, {1, 2}, {2, 2}, {3, 2}},
   {{2, 0}, {2, 1}, {2, 2}, {2, 3}},
   {{0, 1}, {1, 1}, {2, 1}, {3, 1}}},
  -- J
  {{{0, 0}, {1, 0}, {1, 1}, {1, 2}},
   {{0, 1}, {0, 2}, {1, 1}, {2, 1}},
   {{1, 0}, {1, 1}, {1, 2}, {2, 2}},
   {{0, 1}, {1, 1}, {2, 0}, {2, 1}}},
  -- L
  {{{0, 2}, {1, 0}, {1, 1}, {1, 2}},
   {{0, 1}, {1, 1}, {2, 1}, {2, 2}},
   {{1, 0}, {1, 1}, {1, 2}, {2, 0}},
   {{0, 0}, {0, 1}, {1, 1}, {2, 1}}},
  -- O
  {{{0, 0}, {0, 1}, {1, 0}, {1, 1}},
   {{0, 0}, {0, 1}, {1, 0}, {1, 1}},
   {{0, 0}, {0, 1}, {1, 0}, {1, 1}},
   {{0, 0}, {0, 1}, {1, 0}, {1, 1}}},
  -- S
  {{{0, 1}, {0, 2}, {1, 0}, {1, 1}},
   {{0, 1}, {1, 1}, {1, 2}, {2, 2}},
   {{1, 1}, {1, 2}, {2, 0}, {2, 1}},
   {{0, 0}, {1, 0}, {1, 1}, {2, 1}}},
  -- T
  {{{0, 1}, {1, 0}, {1, 1}, {1, 2}},
   {{0, 1}, {1, 1}, {1, 2}, {2, 1}},
   {{1, 0}, {1, 1}, {1, 2}, {2, 1}},
   {{0, 1}, {1, 0}, {1, 1}, {2, 1}}},
  -- Z
  {{{0, 0}, {0, 1}, {1, 1}, {1, 2}},
   {{0, 2}, {1, 1}, {1, 2}, {2, 1}},
   {{1, 0}, {1, 1}, {2, 1}, {2, 2}},
   {{0, 1}, {1, 0}, {1, 1}, {2, 0}}},
};