LOGFILENAME = "log.txt"

function create_log_file()
    file = io.open(LOGFILENAME, "w")
    file:write("---Log file---")
    file:write("\n> Starting game.")
    file:close()
end

function print_to_log(content)
    file = io.open(LOGFILENAME, "a")
    file:write('\n'..content)
    file:close()
end