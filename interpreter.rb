require_relative "list.rb"

class Interpreter
    def initialize()
        @define = {}
        @define["+"] = -> (x,y){x + y}
        @define["-"] = -> (x,y){x - y}
        @define["*"] = -> (x,y){x * y}
        @define["/"] = -> (x,y){x / y}
        @define["define"] = -> (x,y){ @define[x] = y }
        @define["lambda"] = -> (params,exp){ 
            params_list = evaluate(params)
            @define[params_list.get(0)] = ""
            @define[params_list.get(1)] = ""

            return ->(x,y){
                @define[params_list.get(0)] = x
                @define[params_list.get(1)] = y
                evaluate(exp) 
            }
        }
    end

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

    def parse(tokens)
        list = List.new()
        for token in tokens do
            case token
            when ")" then
                tmp = List.new()
                while true do
                    elem = list.pop()            
                    if elem == "(" then 
                        list.push(tmp)
                        break 
                    end
                    tmp.unshift(elem)
                end
            else
                list.push(token)
            end
        end
        return list.start.car
    end

    def evaluate(list)
        if list.instance_of?(List) then
            if list.count == 2 then
                return list
            else
                arg1 = evaluate(list.get(1))
                arg2 = list.get(0) == "lambda" ? list.get(2) : evaluate(list.get(2))
                ret = @define[list.get(0)].call(arg1,arg2)
                return list.get(0) == "define" ? list.get(1) : ret
            end
        else
            if list =~ /^\d+$/ then 
                return list.to_i
            else 
                if @define[list] != nil then
                     return @define[list] 
                else 
                    return list =~ /^\"(.*)\"$/ ? list.to_s[/^\"(.*)\"$/,1] : list.to_s
                end
            end
        end
    end
end    

