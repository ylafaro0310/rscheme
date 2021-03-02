require_relative "interpreter.rb"

ip = Interpreter.new()

scheme = "(+ 3 (- (* 4 2) 1))"
puts ip.evaluate(ip.parse(ip.lex(scheme)))

scheme = "(define year 2021)"
puts ip.evaluate(ip.parse(ip.lex(scheme)))
scheme = "(+ year 2)"
puts ip.evaluate(ip.parse(ip.lex(scheme)))

scheme = "(define average (lambda (x y) (/ (+ x y) 2)))"
puts ip.evaluate(ip.parse(ip.lex(scheme)))

scheme = "(average 2 6)"
puts ip.evaluate(ip.parse(ip.lex(scheme)))

scheme = "(+ \"He said \"I'm fine.\".\" \" He is cool.\")"
puts ip.evaluate(ip.parse(ip.lex(scheme)))

scheme = "(+ \"古今\" \"東西\")"
puts ip.evaluate(ip.parse(ip.lex(scheme)))

scheme = "(car (1 2 3))"
puts ip.print(ip.evaluate(ip.parse(ip.lex(scheme))))

scheme = "(cdr (1 2 3 4))"
puts ip.print(ip.evaluate(ip.parse(ip.lex(scheme))))
