class Parser
    def push(list,value)
        item = Cell.new(value)
        cell = search_tail(list)
        cell.cdr = item
        return list
    end

    def pop(list)
        cell = search_tail(list)
        ret = cell.car
        node = list
        while node.cdr != nil do
            if node.cdr.cdr == nil then
                node.cdr = nil
                break
            end
            node = node.cdr
        end
        return ret, list
    end

    def unshift(list,value)
        item = Cell.new(value)
        item.cdr = list
        return item
    end

    def search_tail(list)
        return list if list.cdr == nil
        search_tail(list.cdr)
    end

    def parse(tokens)
        list = nil
        for token in tokens do
            case token
            when ")" then
                tmp = nil
                while true do
                    elem, list = pop(list) 
                    if elem == "(" then 
                        list = push(list,tmp)
                        break 
                    end
                    if tmp == nil then
                        tmp = Cell.new(elem)
                    else
                        tmp = unshift(tmp,elem)
                    end
                end
            else
                if list == nil then
                    list = Cell.new(token)
                else
                    list = push(list,token)
                end
            end
        end
        return list.cdr.car
    end
end