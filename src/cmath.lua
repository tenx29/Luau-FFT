--[[
  TenX29
  cmath.lua
  May 10, 2022

  Licensed under the Mozilla Public License Version 2.0
]]

Complex = {}
Complex.__index = Complex

-- Constructor for a new complex number from two arguments
function Complex.new(real: number, imag: number)
	local self = {}
	setmetatable(self, Complex)
	self.Real = real or 0
	self.Imag = imag or 0
	return self
end

-- Constructor for a new complex number from a dictionary with keys "Real" and "Imag"
function Complex.fromDict(c: {Real: number, Imag: number})
	return Complex.new(c.Real, c.Imag)
end

-- Internal function for automatically converting numbers into complex format
local function convertToComplex(x)
	if typeof(x) == typeof(Complex.new()) then
		return x
	elseif typeof(x) == "number" then
		return Complex.new(x, 0)
	elseif typeof(x) == "table" then
		return Complex.fromDict(x)
	end
end



--[[
	===========
	CONVERSIONS
	===========
]]

-- Get radius and phase angle (in radians) of the polar form of the complex number
function Complex:polar()
	return self:abs(), math.atan2(self.Imag, self.Real)
end

-- Define complex negation
function Complex.__unm(t)
	local negated = {}
	for key, value in pairs(t) do
		negated[key] = -value
	end
	return negated
end

-- Tostring
function Complex.__tostring(t)
	local sep = '+'
	if t.Imag < 0 then
		sep = ''
	end
	return tostring(t.Real)..sep..tostring(t.Imag)..'i'
end



--[[
	=======================
	MATHEMATICAL OPERATIONS
	=======================
]]

-- Exponential function
-- Returns e^z
function Complex:exp()
	local a = self.Real
	local b = self.Imag
	
	return Complex.new(math.exp(a)*math.cos(b), math.exp(a)*math.sin(b))
end

-- Absolute value (length operator)
-- Returns |z|
function Complex:abs()
	return math.sqrt(self.Real^2 + self.Imag^2)
end

-- Addition
-- Returns z+w
function Complex.__add(t, v)
	-- Set t as the complex number and v as the second operand
	-- Because addition is a commutative operation, changing the order won't affect the result
	if typeof(t) == "number" then
		local temp = t
		t = v
		v = temp
	end
	
	if typeof(v) == typeof(t)  then
		return Complex.new(t.Real+v.Real, t.Imag+v.Imag)
	elseif typeof(v) == "number" then
		return Complex.new(t.Real+v, t.Imag)
	elseif typeof(t) == "number" then
		return Complex.new(v.Real+t, v.Imag)
	
	elseif typeof(t) == typeof(Complex.new()) then
		error("attempt to perform arithmetic (add) on complex number and "..typeof(v))
	else
		error("attempt to perform arithmetic (add) on "..typeof(v).." and complex number")
	end
end

-- Subtraction
-- Returns z-w
function Complex.__sub(t, v)
	if typeof(v) == typeof(t) then
		return Complex.new(t.Real-v.Real, t.Imag-v.Imag)
	elseif typeof(v) == "number" or typeof(t) == "number" then
		return convertToComplex(t)-convertToComplex(v)
	
	elseif typeof(t) == typeof(Complex.new()) then
		error("attempt to perform arithmetic (sub) on complex number and "..typeof(v))
	else
		error("attempt to perform arithmetic (sub) on "..typeof(v).." and complex number")
	end
end

-- Multiplication
-- Returns z*w
function Complex.__mul(t, v)
	-- Set t as the complex number and v as the second operand
	if typeof(t) == "number" then
		local temp = t
		t = v
		v = temp
	end
	
	local a = t.Real
	local b = t.Imag
	if typeof(v) == typeof(t) then
		local c = v.Real
		local d = v.Imag
		return Complex.new((a*c - b*d), (a*d + b*c))
	elseif typeof(v) == "number" then
		return Complex.new(a*v, b*v)
	elseif typeof(t) == typeof(Complex.new()) then
		error("attempt to perform arithmetic (mul) on complex number and "..typeof(v))
	else
		error("attempt to perform arithmetic (mul) on "..typeof(v).." and complex number")
	end
end

-- Division
-- Returns z/w
function Complex.__div(t, v)
	local a, b
	if typeof(t) == typeof(Complex.new()) then
		a = t.Real
		b = t.Imag
	else
		a = v.Real
		b = v.Imag
	end
	
	if typeof(v) == typeof(t) then
		local c = v.Real
		local d = v.Imag
		return Complex.new(
			(a*c + b*d)/(c^2 + d^2),
			(b*c - a*d)/(c^2 + d^2)
		)
	
	-- If one of the arguments is a real number, attempt to automatically convert it to a complex one
	elseif typeof(v) == "number" or typeof(t) == "number" then
		return convertToComplex(t)/convertToComplex(v)
		
	elseif typeof(t) == typeof(Complex.new()) then
		error("attempt to perform arithmetic (div) on complex number and "..typeof(v))
	else
		error("attempt to perform arithmetic (div) on "..typeof(v).." and complex number")
	end
end

-- Exponentiation
-- Returns z^w
function Complex.__pow(t, v)
	if typeof(v) == typeof(t) then
		local a = t.Real
		local b = t.Imag
		local c = v.Real
		local d = v.Imag
		
		local r, theta = t:polar()
		local log = math.log(r)
		local cdTerm = Complex.new(c, d)
		local thetaTerm = Complex.new(0, theta)
		local exponent = math.log(r)*cdTerm+thetaTerm*cdTerm
		
		return exponent:exp()
		
	elseif typeof(v) == "number" or typeof(t) == "number" then
		return convertToComplex(t)^convertToComplex(v)
		
	elseif typeof(t) == typeof(Complex.new()) then
		error("attempt to perform arithmetic (pow) on complex number and "..typeof(v))
	else
		error("attempt to perform arithmetic (pow) on "..typeof(v).." and complex number")
	end
end



--[[
	===========
	COMPARISONS
	===========
]]

-- These only work when comparing a complex number to another complex number

-- Equals
function Complex.__eq(t, v)
	return (v.Real == t.Real) and (v.Imag == t.Imag)
end

-- Less than
-- This is just one of many ways to compare complex numbers, but I chose this one
function Complex.__lt(t, v)
	return t:abs() < v:abs()
end

-- Less than or equal
function Complex.__le(t, v)
	return t:abs() <= v:abs()
end


return Complex
