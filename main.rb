require_relative "parser.rb"

scheme = "(+ 3 (- (* 4 2) 1))"
puts eval(parse(lex(scheme)))

scheme = "(define year 2021)"
puts eval(parse(lex(scheme)))
scheme = "(+ year 2)"
puts eval(parse(lex(scheme)))

scheme = "(define average (lambda (x y) (/ (+ x y) 2)))"
puts eval(parse(lex(scheme)))

scheme = "(average 2 6)"
puts eval(parse(lex(scheme)))

