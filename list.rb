class List
    def initialize()
        @start = nil
        @end = @start
        @count = 0
    end

    def start
        return @start
    end

    def end
        return @end
    end

    def count
        return @count
    end

    def count=(value)
        @count = value
    end

    def select(index)
        if index >= count then
            return nil
        end
        if index == 0 then
            return @start
        else
            tmp = @start
            for i in 1..index do
                tmp = tmp.cdr
            end
            return tmp
        end
    end

    def get(index)
        if index >= count then
            return nil
        end

        if index == 0 then
            return @start.car
        else
            tmp = @start
            for i in 1..index do
                tmp = tmp.cdr
            end
            return tmp.car
        end
    end

    def push(value)
        item = ListItem.new(value)
        if @count == 0 then
            @start = item
            @end = @start            
        else
            @end.cdr = item
            @end = item
        end
        @count = @count + 1
    end

    def pop()
        if @count <= 0 then
            return nil
        end
        ret = @end.car
        @end = self.select(@count-2)
        @end.cdr = nil

        @count = @count - 1
        return ret
    end

    def unshift(value)
        item = ListItem.new(value)
        item.cdr = @start
        @start = item
        if @count <= 0 then
            @end = @start
        end
        
        @count = @count + 1
    end
end

class ListItem
    def initialize(car)
        @car = car
        @cdr = nil
    end

    def car
        return @car
    end

    def car=(value)
        @car = value
    end

    def cdr
        return @cdr
    end

    def cdr=(value)
        @cdr = value
    end
end
