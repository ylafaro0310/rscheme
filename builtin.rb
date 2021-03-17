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

    def builtin_init()
        @define["+"] = method(:add)
        @define["-"] = method(:subtract)
        @define["*"] = method(:multiply)
        @define["/"] = method(:divide)
        @define["car"] = method(:car)
        @define["cdr"] = method(:cdr)
        @define["define"] = method(:define)
        @define["lambda"] = method(:lambda)
    end

    def evaluate(cell)
        if cell.instance_of?(Cell) then
            # defineに含まれておらず、リストの長さが2の時
            if !@define.include?(cell.car) and cell.cdr != nil and cell.cdr.cdr == nil then
                return cell
            else
                ret = @define[cell.car].call(cell.cdr)
                return cell.car == "define" ? cell.cdr.car : ret
            end
        else
            if cell =~ /^\d+$/ then 
                return cell.to_i
            else 
                if @define[cell] != nil then
                     return @define[cell] 
                else 
                    return cell =~ /^\"(.*)\"$/ ? cell.to_s[/^\"(.*)\"$/,1] : cell.to_s
                end
            end
        end
    end
end