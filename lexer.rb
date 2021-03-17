class Lexer
    def lex(str="")
        str = str.gsub("("," ( ")
        str = str.gsub(")"," ) ")
        arr = str.split(" ")

        ret = []
        stack = []
        for i in 0..arr.length-1 do
            if /^\".*\"/.match(arr[i]) then
                ret.push(arr[i])
            elsif /^\".*/.match(arr[i]) and stack.length == 0 
                stack.push(arr[i])
            elsif /.*\"$/.match(arr[i])
                stack.push(arr[i])
                ret.push(stack.join(" "))
                stack = []
            elsif stack.length != 0
                stack.push(arr[i])
            else
                ret.push(arr[i])
            end
        end

        return ret
    end
end