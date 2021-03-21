require_relative "cell.rb"
require_relative "builtin.rb"
require_relative "lexer.rb"
require_relative "parser.rb"

class Interpreter
    def initialize()
        @builtin = Builtin.new()
        @builtin.builtin_init()
    end
    
    def lex(str="")
        lexer = Lexer.new()
        lexer.lex(str)
    end

    def parse(tokens)
        parser = Parser.new()
        parser.parse(tokens)
    end

    def evaluate(list)
        @builtin.evaluate(list)
    end
    
     def print(list)
        if list.instance_of?(Cell) then
            return "[" + print(list.car) + " " + print(list.cdr) + "]"
        else
            return list.to_s
        end
    end
end    

