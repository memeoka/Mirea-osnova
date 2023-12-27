function moves!(r,side) #возвращает число шагов
    num=0
    while isborder(r,side) == false
        move!(r,side)
        num += 1
    end
    return num
end

function moves!(r, side, num) #перемещает на число шагов
    for i in 1:num
        if !isborder(r,side)
            move!(r, side)
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

function mark_cord(r, side, num)
    moves!(r,side,num)
    putmarker!(r)
    num = moves!(r,side)
    return num
end

function reverse(i)
    if isodd(i) == true
        side = Ost
    else 
        side = Nord
    end
    return side
end

function back(r,a)
    global num   #размер массива
    for i = 1:num
        moves!(r,reverse(num-i+1),a[num-i+1])
    end
end

function f(r)
    a = Int64[]
    global num = 0
    while !isborder(r,Sud) || !isborder(r,West)
        push!(a, moves!(r,West))
        push!(a, moves!(r,Sud))
        num += 2
    end
    x = 0
    y = 0
    for i in 1:num
        if isodd(i) == true
            y += a[i]
        else 
            x += a[i]
        end
    end
    side = Nord
    for _ in 1:2
        x = mark_cord(r,side,x)
        side = next_side(side)
        y = mark_cord(r,side,y)
        side = next_side(side)
    end
    back(r, a)
end
