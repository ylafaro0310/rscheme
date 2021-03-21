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
        assert_equal("+",tmp.car)
        assert_equal("-",tmp.cdr.cdr.car.car)
    end

    def test_four_arithmetic_operations
        scheme = "(+ 3 2 3)"
        assert_equal(8,@ip.evaluate(@ip.parse(@ip.lex(scheme))))

        scheme = "(+ 3 (- (* 4 2) 1))"
        assert_equal(10,@ip.evaluate(@ip.parse(@ip.lex(scheme))))

        scheme = "(+ \"古今\" \"東西\")"
        assert_equal("古今東西",@ip.evaluate(@ip.parse(@ip.lex(scheme))))
        
        scheme = "(+ \"He said \"I'm fine.\".\" \"He is cool.\")"
        assert_equal("He said \"I'm fine.\".He is cool.",@ip.evaluate(@ip.parse(@ip.lex(scheme))))
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

    def test_and
        scheme = "(and #f 1 2)"
        assert_equal(false,@ip.evaluate(@ip.parse(@ip.lex(scheme))))
    end

    def test_or
        scheme = "(or #f 1 2)"
        assert_equal(1,@ip.evaluate(@ip.parse(@ip.lex(scheme))))
    end

    def test_if
        scheme = "(if (> 3 2) \"true\" \"false\")"
        assert_equal("true",@ip.evaluate(@ip.parse(@ip.lex(scheme))))
    end

    def test_cond
        scheme = "(cond ((> 3 4) (+ 1 2)) (#t (+ 2 3)) ((= 3 4) (- 4 2)) (else (+ 10 2)))"
        assert_equal(5,@ip.evaluate(@ip.parse(@ip.lex(scheme))))
    end
end
    

