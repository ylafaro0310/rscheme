class Builtin
    def initialize()
        @define = {}
    end

    def add(list)
        ret = evaluate(list.car)
        args = list.cdr
        while args != nil
            ret = ret + evaluate(args.car)
            args = args.cdr
        end
        return ret
    end

    def subtract(list)
        ret = evaluate(list.car)
        args = list.cdr
        while args != nil
            ret = ret - evaluate(args.car)
            args = args.cdr
        end
        return ret
    end

    def multiply(list)
        ret = evaluate(list.car)
        args = list.cdr
        while args != nil
            ret = ret * evaluate(args.car)
            args = args.cdr
        end
        return ret
    end

    def divide(list)
        ret = evaluate(list.car)
        args = list.cdr
        while args != nil
            ret = ret / evaluate(args.car)
            args = args.cdr
        end
        return ret
    end

    def car(list)
        return list.car.car
    end

    def cdr(list)
        return list.car.cdr
    end

    def define(list)
        @define[list.car] = evaluate(list.cdr.car)
        return list.car
    end

    def lambda(list)
        params = list.car
        exp = list.cdr.car
        params_list = evaluate(params)
        @define[params_list.car] = ""
        @define[params_list.cdr.car] = ""

        return ->(list){
            @define[params_list.car] = evaluate(list.car)
            @define[params_list.cdr.car] = evaluate(list.cdr.car)
            return evaluate(exp) 
        }
    end

    def if(list)
        predicate = list.car
        then_value = list.cdr.car
        else_value = list.cdr.cdr.car

        if evaluate(predicate) then
            evaluate(then_value)
        else
            evaluate(else_value)
        end
    end

    def and(list)
        arg = list
        while arg.car != nil do
            val = evaluate(arg.car)
            if val == false then
                return val
            end
            arg = arg.cdr
            if arg == nil then
                break
            end
        end
        return val
    end

    def or(list)
        arg = list
        while arg.car != nil do
            val = evaluate(arg.car)
            if val != false then
                return val
            end
            arg = arg.cdr
            if arg == nil then
                break
            end
        end
        return val
    end

    def equal(list)
        val1 = evaluate(list.car)
        val2 = evaluate(list.cdr.car)
        return val1 == val2
    end

    def greater(list)
        val1 = evaluate(list.car)
        val2 = evaluate(list.cdr.car)
        return val1 > val2
    end

    def lesser(list)
        val1 = evaluate(list.car)
        val2 = evaluate(list.cdr.car)
        return val1 < val2
    end

    def greater_equal(list)
        val1 = evaluate(list.car)
        val2 = evaluate(list.cdr.car)
        return val1 >= val2
    end

    def lesser_equal(list)
        val1 = evaluate(list.car)
        val2 = evaluate(list.cdr.car)
        return val1 <= val2
    end

    def _cond(list)
        predicate = evaluate(list.car)
        if predicate == true or predicate == "else" then
            return evaluate(list.cdr.car)
        end
        return false
    end

    def cond(list)
        arg = list
        while arg.car != nil do
            val = _cond(arg.car)
            if val != false then
                return val
            end
            arg = arg.cdr
            if arg == nil then
                break
            end
        end
        return false
    end

    def builtin_init()
        @define["+"] = method(:add)
        @define["-"] = method(:subtract)
        @define["*"] = method(:multiply)
        @define["/"] = method(:divide)
        @define["car"] = method(:car)
        @define["cdr"] = method(:cdr)
        @define["define"] = method(:define)
        @define["lambda"] = method(:lambda)
        @define["if"] = method(:if)
        @define["and"] = method(:and)
        @define["or"] = method(:or)
        @define[">"] = method(:greater)
        @define[">="] = method(:greater_equal)
        @define["<"] = method(:lesser)
        @define["<="] = method(:lesser_equal)
        @define["="] = method(:equal)
        @define["cond"] = method(:cond)
    end

    def evaluate(list)
        if list.instance_of?(Cell) then
            # defineに含まれておらず、リストの長さが2の時はそのまま返す ex) (1 2)
            if !@define.include?(list.car) and list.cdr != nil and list.cdr.cdr == nil then
                return list
            else
                return @define[list.car].call(list.cdr)
            end
        else
            if list =~ /^\d+$/ then 
                return list.to_i
            else 
                if @define[list] != nil then
                     return @define[list] 
                elsif list == "#t" then
                    return true
                elsif list == "#f" then
                    return false
                else 
                    return list =~ /^\"(.*)\"$/ ? list.to_s[/^\"(.*)\"$/,1] : list.to_s
                end
            end
        end
    end
end