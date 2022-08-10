a, b = parse.(Int, split(readline()))

if rem(a * b, 2) == 1
    println("Odd")
else
    println("Even")
end