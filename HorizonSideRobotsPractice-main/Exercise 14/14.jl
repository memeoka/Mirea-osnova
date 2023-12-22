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

function moverobot(r,side)
    while ismarker(r) == true
        if isborder(r,side)
            obhod(r,side)
        end
        if !isborder(r,side)
            move!(r,side)
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


function krest(r)
    for side in (HorizonSide(i) for i=0:3)
        putmarker(r,side) #функция передвигает и ставит марки
        moverobot(r,reverse(side)) #функция перемещает в первоначальное положение
    end
    putmarker!(r)
end