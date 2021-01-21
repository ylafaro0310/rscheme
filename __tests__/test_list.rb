require_relative "../list.rb"

class ListTest < Test::Unit::TestCase
    def setup
        @list = List.new()    
    end

    def test_count
        @list.push("first")
        assert_equal(1, @list.count)
    end

    def test_push
        @list.push("first")
        assert_equal("first",@list.start.car)
        assert_equal("first",@list.end.car)

        @list.push("second")
        assert_equal(2,@list.count)
        assert_equal("second",@list.start.cdr.car)
        assert_equal("second",@list.end.car)

        @list.push("third")
        assert_equal(3,@list.count)
        assert_equal("third",@list.start.cdr.cdr.car)
        assert_equal("third",@list.end.car)
    end

    def test_get
        @list.push("first")
        assert_equal("first",@list.get(0))
        @list.push("second")
        assert_equal("second",@list.get(1))
        @list.push("third")
        assert_equal("third",@list.get(2))
    end

    def test_pop
        @list.push("first")
        @list.push("second")
        @list.push("third")
        assert_equal("third",@list.pop())
        assert_equal(2,@list.count)
        assert_equal("first",@list.get(0))
        assert_equal("second",@list.pop())
        assert_equal(1,@list.count)
        assert_equal("first",@list.get(0))

        @list.pop()
        assert_equal(nil,@list.pop())
    end

    def test_unshift
        @list.push("first")
        @list.unshift("zero")
        assert_equal("zero",@list.start.car)
        assert_equal("first",@list.end.car)

        @list.unshift("minus zero")
        assert_equal("first",@list.end.car)
    end
end