require_relative "../interpreter.rb"

class TestInterpreter < Test::Unit::TestCase
    def setup
        @ip = Interpreter.new()
    end

    def test_scheme
        scheme = "(+ 3 (- (* 4 2) 1))"
        assert_equal(["(","+","3","(","-","(","*","4","2",")","1",")",")"],@ip.lex(scheme))
    end

    def test_parse
        scheme = "(+ 3 (- (* 4 2) 1))"
        tmp = @ip.parse(@ip.lex(scheme))
        assert_equal("+",tmp.start.car)
        assert_equal("-",tmp.end.car.start.car)
        p tmp
    end

    def test_four_arithmetic_operations
        scheme = "(+ 3 (- (* 4 2) 1))"
        assert_equal(10,@ip.evaluate(@ip.parse(@ip.lex(scheme))))
    end

    def test_define
        scheme = "(define year 2021)"
        assert_equal("year",@ip.evaluate(@ip.parse(@ip.lex(scheme))))
    
        scheme = "(+ year 2)"
        assert_equal(2023,@ip.evaluate(@ip.parse(@ip.lex(scheme))))
    end

    def test_lambda
        scheme = "(define average (lambda (x y) (/ (+ x y) 2)))"
        assert_equal("average",@ip.evaluate(@ip.parse(@ip.lex(scheme))))
        
        scheme = "(average 2 6)"
        assert_equal(4,@ip.evaluate(@ip.parse(@ip.lex(scheme))))
    end
end
    

