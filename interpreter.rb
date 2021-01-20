class Interpreter
    def initialize()
        @define["+"] = -> (x,y){x + y}
        @define["-"] = -> (x,y){x - y}
        @define["*"] = -> (x,y){x * y}
        @define["/"] = -> (x,y){x / y}
        @define["define"] = -> (x,y){ @define[x] = y }
        @define["lambda"] = -> (params,exp){ 
            params_list = evaluate(params)
            for elem in params_list do
                @define[elem] = ""
            end
            return ->(x,y){
                @define[params_list[0]] = x
                @define[params_list[1]] = y
                evaluate(exp) 
            }
        }
    end

    def lex(str="")
        str = str.gsub("("," ( ")
        str = str.gsub(")"," ) ")
        sarray = str.split(" ")
        return sarray
    end

    def parse(tokens)
        list = []
        for token in tokens do
            case token
            when ")" then
                tmp = []
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
        return list[0]
    end

    def evaluate(list)
        if list.instance_of?(Array) then
            if list.count == 2 then
                return list
            else
                arg1 = evaluate(list[1])
                arg2 = list[0] == "lambda" ? list[2] : evaluate(list[2])
                ret = @define[list[0]].call(arg1,arg2)
                return list[0] == "define" ? list[1] : ret
            end
        else
            return list =~ /^\d+$/ ? list.to_i : @define[list] != nil ? @define[list] : list.to_s
        end
    end
end    

