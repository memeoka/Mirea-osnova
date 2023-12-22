function movements!(r,side::HorizonSide,a) #до упора + считает шаги
    i=0
    while isborder(r,side) == false
        move!(r,side)
        i+=1
    end
    push!(a,i)
end
function movements!(r,side::HorizonSide,num::Int)
    for i = 1:num
        move!(r,side)
    end
end
function reverse(j)
    if (mod(j,2) == 0)
        side = Ost
    else
        side = Nord
    end
    return side
end
function back(r,a)
    i=size(a)[1]   #размер массива
    for j = 1:i
        movements!(r,reverse(i-j+1),a[i-j+1])
    end
end
function ugl(r)
    for side in [Nord, Ost, Sud, West]
        putmarker!(r)
        while (isborder(r,side) == false)
            move!(r,side)
        end
    end
end

function zadacha(r)
    a=Int64[]
    if (isborder(r,Sud) == true)
        push!(a,0)
    end
    while (isborder(r,Sud) == false || isborder(r,West) == false)
        if (isborder(r,Sud) == false)
            movements!(r,Sud,a)
        elseif (isborder(r,West) == false)
            movements!(r,West,a)
        end
    end
    ugl(r)
    back(r,a)
end