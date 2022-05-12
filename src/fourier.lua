--[[
  TenX29
  fourier.lua
  May 12, 2022

  Licensed under the Mozilla Public License version 2.0
]]

local cmath = require(script.Parent.cmath)
local fourier = {}

-- Constants and functions for slightly faster indexing
local pi = math.pi
local sqrt = math.sqrt
local foreach = table.foreach
local insert = table.insert
local remove = table.remove
local complex = cmath.new


-- Discrete Fourier transform
function fourier.dft(samples, maxFrequency, getAbsolute)
	local N = #samples
	local spectrum = {}

	maxFrequency = maxFrequency or N/2

	for f=0, maxFrequency-1 do
		local sum = complex()
		for n=0, N-1 do
			sum += samples[n+1] * complex(0, (-2*pi*f*n)/N):exp()
		end
		insert(spectrum, f, 1/sqrt(N) * sum)
	end

	if getAbsolute then
		foreach(spectrum, function(f, v)
			spectrum[f] = v:abs()
		end)
	end

	return spectrum
end


-- Fast Fourier Transform using the Cooley-Tukey algorithm
function fourier.fft(samples, ignoreConjugate, getAbsolute)
	local n=#samples
	assert(math.floor(math.log(n, 2)) == math.log(n, 2), "fast Fourier transform only accepts sample tables with a length that is a power of 2")

	-- Recursive function to solve the FFT (This is used to avoid performing the power-of-2 check above repeatedly)
	local function fftRecursive(samples)
		local n = #samples

		-- If the amount of samples is 0 or 1, the FFT is the same as the sample itself
		if n<=1 then
			if typeof(samples[1]) == "number" then
				return {complex(samples[1], 0)}
			else
				return samples
			end
		end

		-- Divide the samples into even and odd lists
		local odd,even={},{}
		foreach(samples, function(i, sample)
			if i%2 == 0 then
				insert(even, sample)
			else
				insert(odd, sample)
			end
		end)

		-- Perform an FFT for even and odd samples separately
		even = fftRecursive(even);
		odd = fftRecursive(odd);

		-- Combine the samples into a single spectrum
		local spectrum = {}
		for k=1,n/2 do
			local t=even[k] * complex(0, -2*pi*(k-1)/n):exp()
			spectrum[k] = odd[k] + t;
			spectrum[k+n/2] = odd[k] - t;
		end
		
		return spectrum
	end

	local spectrum = fftRecursive(samples)
	local processedSpectrum = nil
	
	-- Delete the conjugate data from the FFT
	if ignoreConjugate then
		processedSpectrum = {}
		foreach(spectrum, function(i, v)
			if i <= n/2 then
				insert(processedSpectrum, v)
			end
		end)
	end
	
	spectrum = processedSpectrum or spectrum
	
	-- Get the absolute value of the FFT
	if getAbsolute then
		foreach(spectrum, function(i, v)
			spectrum[i] = v:abs()
		end)
	end
	
	-- Shift the spectrum down by 1
	-- This will mean the index of the DC term is always 0, whereas
	-- the other frequencies will have an index corresponding to their
	-- respective frequency.
	foreach(spectrum, function(i, v)
		spectrum[i-1] = v
	end)
	remove(spectrum, #spectrum)
	
	return processedSpectrum or spectrum
end

return fourier
