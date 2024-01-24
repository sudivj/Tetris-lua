FILENAME = "game_scores.txt"

function write_score_to_file(score)
    local file = io.open(FILENAME, "a")
    file:write('\n'..score)
    file:close()
end

function file_exits()
    local file = io.open(FILENAME, "r")
    if file ~= nil then
        io.close(file)
        return true
    else
        return false
    end
end

function get_no_of_lines_in_file()
    local ctr = 0
    for _ in io.lines(FILENAME) do
        ctr = ctr + 1
    end
    return ctr
end

function set_highscore(highscore)
    local file = io.open(FILENAME, "r")
    local file_data = {}
    for line in file:lines() do
        table.insert(file_data, line)
    end
    io.close(file)

    file_data[3] = tostring(highscore)

    file = io.open(FILENAME, "w")
    for index,value in ipairs(file_data) do
        file:write(value..'\n')
    end
    io.close(file)
end

function create_file()
    local file = io.open(FILENAME, "w")
    file:write("---SCORES---\n")
    file:write("\n0\n")
    file:close()
end

function get_highscore()
    local ctr = 0
    for line in io.lines(FILENAME) do
        ctr = ctr + 1
        if (ctr == 3) then
            return line
        end
    end
end