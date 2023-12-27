#Посчитать число всех горизонтальных прямолинейных перегородок (вертикальных - нет)

function ugol(r,side1,side2)
    while !isborder(r,side1) || !isborder(r,side2)
        if !isborder(r,side1)
            move!(r,side1)
        else
            move!(r,side2)
        end
    end
end

function kray(r,side) #функция перемещает робота к краю
    while isborder(r,side) == false
        move!(r,side)
    end
end

function num_vert(r)
    ugol(r, West, Sud)
    n = 0
    flag = 1
    while !isborder(r, Nord)
        while !isborder(r, Ost)
            move!(r, Ost)
            if(flag == 0 && isborder(r, Nord))
                flag = 1
                n += 1
            elseif(flag == 1 && !isborder(r, Nord))
                flag = 0
            end
        end
        move!(r, Nord)
        kray(r,West)
    end
print(n)
end
