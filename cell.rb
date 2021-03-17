class Cell
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
