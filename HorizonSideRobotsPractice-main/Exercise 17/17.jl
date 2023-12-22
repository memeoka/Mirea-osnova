function ryad(r,side)
    num = 0
    while !isborder(r,side)
        move!(r,side)
        num += 1
    end
    moves!(r, reverse(side))
    return num
end

function reverse(side::HorizonSide)
    for i=0:3
        if side == HorizonSide(i)
            return HorizonSide(mod(i+2, 4))
        end
    end
end

function moves!(r, side)
    num = 0
    while !isborder(r,side)
        move!(r, side)
        num += 1
    end
    return num
end

function check(r,sh, x, y) #функция проверяет нужно ли ставить маркер
    if (x+y) <= sh
        putmarker!(r)
    end
end

function move_coord!(r,side) #двигает робота и отсчитывает координаты
    global x_coord, y_coord
    if side == Nord
        y_coord += 1
    end
    if side == Sud
        y_coord -= 1
    end
    if side == Ost
        x_coord += 1
    end
    if side == West
        x_coord -= 1
    end
    move!(r,side)
end

function next_side(side)
    for i=0:3
        if side == HorizonSide(i)
            return HorizonSide(mod(i+3,4))
        end
    end
end

function obhod(r,side)
    global x_coord
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
        move_coord!(r,side)
    end
    if k != 0
        while isborder(r,reverse(next_side(side)))
            move_coord!(r,side)
        end
        for i in 1:k
            move!(r,reverse(next_side(side)))
        end
    end
    return 1
end

function back(r, side)
    c = 1
    while c != 0
        if !isborder(r, side)
            move_coord!(r, side)
        else
            c = obhod(r,side)
            if c == 0
                break
            end
        end
    end
end

function moves!(r, side, num) #перемещает на число шагов
    for i in 1:num
        if !isborder(r,side)
            move!(r, side)
        end
    end
end

function reverse(i::Int)
    if isodd(i) == true
        side = Ost
    else 
        side = Nord
    end
    return side
end

function back_a(r,a)
    global num   #размер массива
    for i = 1:num
        moves!(r,reverse(num-i+1),a[num-i+1])
    end
end
    
function lesenka_17(r)
    a = Int64[]
    global num = 0
    global x_coord = 0
    global y_coord = 0
    while !isborder(r,Sud) || !isborder(r,West)
        push!(a, moves!(r,West))
        push!(a, moves!(r,Sud))
        num += 2
    end
    sh = ryad(r, Ost) #ширина поля
    while !isborder(r,Nord)
        c = 1
        while c != 0
            check(r, sh, x_coord, y_coord)
            if !isborder(r, Ost)
                move_coord!(r, Ost)
                check(r, sh, x_coord, y_coord)
            else
                c = obhod(r, Ost)
                check(r, sh, x_coord, y_coord)
                if c == 0
                    break
                end 
            end
        end
        back(r, West)
        if !isborder(r, Nord)
            move_coord!(r, Nord)
        end
    end
    while !isborder(r, Ost)
        check(r,sh, x_coord, y_coord)
        move_coord!(r, Ost)
    end
    back(r, West)
    back(r, Sud)
    back_a(r,a)
end   