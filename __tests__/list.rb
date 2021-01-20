require_relative "../list.rb"

class ListTest < Test::Unit::TestCase
    def setup
        @list = List.new("first")
    end
   
    def test_count_is_1
        assert_equal(1, @list.count)
    end

    def test_get_is_first
        assert_equal("first",@list.get)
    end
end