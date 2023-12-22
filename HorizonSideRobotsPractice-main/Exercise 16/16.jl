
function ugol(r,side1,side2)
    while !isborder(r,side1) || !isborder(r,side2)
        if !isborder(r,side1)
            move!(r,side1)
        else
            move!(r,side2)
        end
    end
end

function putmarker(r,side)
    k = 1
    while k != 0
        if isborder(r,side)
            k = obhod(r,side)
            if k == 0
                break
            end 
            putmarker!(r)       
        end
        if !isborder(r,side)
            move!(r,side)
            putmarker!(r)
        end
    end
end

function reverse(side)
    for i=0:3
        if side == HorizonSide(i)
            return HorizonSide(mod(i+2, 4))
        end
    end
end

function next_side(side)
    for i=0:3
        if side == HorizonSide(i)
            return HorizonSide(mod(i+3,4))
        end
    end
end

function obhod(r,side)
    k = 0
    while (isborder(r,side) && !isborder(r,next_side(side)))
        move!(r,next_side(side))
        k += 1
    end
    if isborder(r,next_side(side))&&isborder(r,side)
        for i in 1:k
            move!(r,reverse(next_side(side)))
        end
        return 0
    end
    if !isborder(r,side)
        move!(r,side)
    end
    if k != 0
        while isborder(r,reverse(next_side(side)))
            move!(r,side)
        end
        for i in 1:k
            move!(r,reverse(next_side(side)))
        end
    end
    return 1
end

function up(r)
    if isborder(r,Nord) == false
        move!(r,Nord)
        putmarker!(r)
    end
end

function mpole(r)
    ugol(r, Sud, Ost)
    putmarker!(r)
    while isborder(r,Nord) == false
        putmarker(r,West)
        up(r)
        putmarker(r,Ost)
        up(r)
    end
    if isborder(r,Ost) == false
        putmarker(r,Ost)
    elseif isborder(r,West) == false
        putmarker(r,West)
    end
end