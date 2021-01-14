def lex(str="")
    str = str.gsub("("," ( ")
    str = str.gsub(")"," ) ")
    sarray = str.split(" ")
    return sarray
end

def parser(tokens)
    list = []
    for token in tokens do
        case token
        when ")" then
            tmp = []
            while true do
                elem = list.pop()            
                if elem == "(" then 
                    list.push(tmp)
                    break 
                end
                tmp.unshift(elem)
            end
        else
            list.push(token)
        end
    end
    return list[0]
end

$define = {}
$define["+"] = -> (x,y){x + y}
$define["-"] = -> (x,y){x - y}
$define["*"] = -> (x,y){x * y}
$define["/"] = -> (x,y){x / y}
$define["define"] = -> (x,y){ $define[x] = y}
#$define["lambda"] = -> (x,y){ (x){y} }
def eval(list)
    if list.instance_of?(Array) then        
        arg1 = eval(list[1])
        arg2 = eval(list[2])
        $define[list[0]].call(arg1,arg2)
    else
        return list.to_i
    end
end

# 文字列をトークンに分解
tokens = lex("(+ 3 (- (* 4 2) 1))")

# トークンをリストに変換
list = parser(tokens)

# (f x y) の評価
ret = eval(list)

# 結果の表示
p ret
