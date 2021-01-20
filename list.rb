class List
    def initialize(value)
        @start = ListItem.new(value)
        @count = 1    
    end

    def count()
        return @count
    end

    def get(index)
        if index == 0 then
            return @start.car
        else
            for i in 0..index do
                tmp = @start.cdr
            end
            return tmp.car
        end
    end

    def push(value)
        item = ListItem.new(value)
        @end.cdr = item
        @end = item.cdr
    end

    def pop()
        @start
        return @@car
    end

    def unshift(value)
        item = ListItem.new(value)
        item.cdr = @start
        @start = item
    end
end

class ListItem
    def initialize(car)
        @car = car
    end

    def car()
        return @car
    end

    def cdr()
        return @cdr
    end
end
