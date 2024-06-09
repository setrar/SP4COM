using LinearAlgebra, Random, Printf

function signalgen(m, M, θ, φ, SIR, SNR)
    # Constants
    σₐ² = 1.0 # Power of the desired signal
    σₐ = sqrt(σₐ²) # Standard deviation of the desired signal

    # Calculate the power of the interferer and noise
    σᵦ² = σₐ² / 10^(SIR / 10) # Power of the interferer
    σᵦ = sqrt(σᵦ²) # Standard deviation of the interferer
    σᵤ² = σₐ² / 10^(SNR / 10) # Power of the noise per antenna
    σᵤ = sqrt(σᵤ²) # Standard deviation of the noise per antenna

    # Generate QPSK symbols for the desired signal
    aᵣ = (rand(1:2, M) .- 1.5) * 2 * σₐ / sqrt(2)
    aᵢ = (rand(1:2, M) .- 1.5) * 2 * σₐ / sqrt(2)
    a₀ = aᵣ .+ 1im * aᵢ

    # Generate QPSK symbols for the interferer signal
    bᵣ = (rand(1:2, M) .- 1.5) * 2 * σᵦ / sqrt(2)
    bᵢ = (rand(1:2, M) .- 1.5) * 2 * σᵦ / sqrt(2)
    bᵩ = bᵣ .+ 1im * bᵢ

    # Generate the array response vectors
    d = 0.5 # Spacing between antennas (normalized to wavelength)
    h = exp.(1im * 2 * π * d * (0:m-1) .* sin(θ)) # Array response for desired signal
    g = exp.(1im * (2 * π * d * (0:m-1) .* sin(φ) .+ π / 4)) # Array response for interferer

    # Generate noise
    uᵣ = randn(m, M) * sqrt(σᵤ² / 2)
    uᵢ = randn(m, M) * sqrt(σᵤ² / 2)
    u = uᵣ .+ 1im .* uᵢ

    # Reshape a and β to 1 x M for matrix multiplication
    a₀ = reshape(a₀, 1, M)
    bᵩ = reshape(bᵩ, 1, M)

    # Reshape h and g to m x 1 for matrix multiplication
    h = reshape(h, m, 1)
    g = reshape(g, m, 1)

    # Calculate the total received signal
    y = h * a₀ .+ g * bᵩ .+ u

    return y, a₀, h
end

