--[[
  TenX29
  fourier.lua
  May 10, 2022

  Licensed under the Mozilla Public License version 2.0
]]

local cmath = require(script.Parent.cmath)
local transform = {}

-- Discrete Fourier transform
function transform.dft(samples, maxFrequency, getAbsolute)
	local N = #samples
	local spectrum = {}
	
	maxFrequency = maxFrequency or N/2
	
	for f=0, maxFrequency-1 do
		local sum = cmath.new()
		for n=0, N-1 do
			sum += samples[n+1] * cmath.new(0, (-2*math.pi*f*n)/N):exp()
		end
		table.insert(spectrum, f, 1/math.sqrt(N) * sum)
	end
	
	if getAbsolute then
		table.foreach(spectrum, function(f, v)
			spectrum[f] = v:abs()
		end)
	end
	
	return spectrum
end

-- Fast Fourier transform
function transform.fft(samples, maxFrequency, getAbsolute)
	local N = #samples
	local spectrum = {}

	maxFrequency = maxFrequency or N/2

	for f=0, maxFrequency-1 do
		local sum = cmath.new()
		for n=1, N/2 do
			sum += samples[2*n] * cmath.new(0, (-2*math.pi*f*2*n)/N):exp()
		end
		for n=1, N/2 do
			if not samples[2*n+1] then continue end
			sum += samples[2*n+1] * cmath.new(0, (-2*math.pi*f*(2*n+1))/N):exp()
		end
		table.insert(spectrum, f, 1/math.sqrt(N) * sum)
	end
	
	if getAbsolute then
		table.foreach(spectrum, function(f, v)
			spectrum[f] = v:abs()
		end)
	end

	return spectrum
end

return transform
