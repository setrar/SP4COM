function lms(x, d, Δ, N)
    # LMS Algorithm for Coefficient Adjustment
    # ----------------------------------------
    # Inputs:
    #   x     - Input array x[n]
    #   d     - Desired array d[n], length must be same as x
    #   Δ     - Step size
    #   N     - Length of the FIR filter
    # Outputs:
    #   h     - Estimated FIR filter coefficients
    #   y     - Output array y[n]
    
    M = length(x)
    y = zeros(Float64, M)
    h = zeros(Float64, N)
    
    for n in N:M
        x₁ = x[n:-1:n-N+1]        # Reverse the slice to mimic MATLAB's order
        y[n] = (h)ᵀ * x₁  # Calculate the output using dot product
        ϵ = d[n] - y[n]           # Error calculation
        h += Δ * ϵ * x₁           # Update the filter coefficients
    end
    
    return h, y
end