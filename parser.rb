def parser(str="")
    str = str.gsub("("," ( ")
    str = str.gsub(")"," ) ")
    sarray = str.split(" ")
    for elem in sarray
        puts elem
    end
end

parser("(+ 1 2)")