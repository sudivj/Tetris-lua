blockColours = {
    "sprites/null_b.png",
    "sprites/yellow_b.png",
    "sprites/green_b.png",
    "sprites/red_b.png",
    "sprites/purple_b.png",
    "sprites/darkblue_b.png",
    "sprites/orange_b.png",
    "sprites/blue_b.png"
}

shapeData = {
    {
        {
            {1, 1},         -- O block
            {1, 1}
        }
    },
    {
        {
            {0, 1, 1},      -- S block    
            {1, 1, 0}
        },
        {
            {1, 0},
            {1, 1},
            {0, 1}
        }
    },
    {
        {
            {1, 1, 0},      -- Z block
            {0, 1, 1}
        },
        {
            {0, 1},
            {1, 1},
            {1, 0}
        }
    },
    {
        {
            {1, 1, 1},      -- T block
            {0, 1, 0}
        },
        {
            {1, 0},
            {1, 1},
            {1, 0}
        },
        {
            {0, 1, 0},
            {1, 1, 1}
        },
        {
            {0, 1},
            {1, 1},
            {0, 1}
        }
    },
    {
        {
            {1, 0},         -- L block
            {1, 0},
            {1, 1}
        },
        {
            {0, 0, 1},
            {1, 1, 1}
        },
        {
            {1, 1},
            {0, 1},
            {0, 1}
        },
        {
            {1, 1, 1},
            {1, 0, 0}
        }
    },
    {
        {
            {0, 1},         -- J block
            {0, 1},
            {1, 1}
        },
        {
            {1, 1, 1},
            {0, 0, 1}
        },
        {
            {1, 1},
            {1, 0},
            {1, 0}
        },
        {
            {1, 0, 0},
            {1, 1, 1}
        }
    },
    {
        {
            {1, 1, 1, 1}    -- I block
        },
        {
            {1},
            {1},
            {1},
            {1}
        }
    }
}

shapeOrientations = {1, 2, 2, 4, 4, 4, 2}   --No. of rotations of each block

shapeDimensionsDetails = {                  --Length and height of each block orientation
    {
        {2, 2}
    },
    {
        {3, 2},
        {2, 3}
    },
    {
        {3, 2},
        {2, 3}
    },
    {
        {3, 2},
        {2, 3},
        {3, 2},
        {2, 3}        
    },
    {
        {2, 3},
        {3, 2},
        {2, 3},
        {3, 2},
    },
    {
        {2, 3},
        {3, 2},
        {2, 3},
        {3, 2},
    },
    {
        {4, 1},
        {1, 4}
    }

}