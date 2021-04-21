"""
    factorial(n::Int)

Compute the factorial of n.
"""
function factorial(n::Int)
    if n < 0
        throw(DomainError("n must be non-negative"))
    end
    result = 1
    for i in 1:n
        result *= i
    end
    return result
end
