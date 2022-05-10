# Complex Mathematics

cmath is a class used for calculations using complex numbers. This module is necessary when calculating Fourier transforms, but it can be used for a lot of other purposes as well.
!!! warning "Required by another script"
    This module must have the same Parent as the [Fourier module](fourier.md).

<br><br>

## Creating a new complex number
---
### [ComplexNumber]() cmath.new([float](https://developer.roblox.com/en-us/articles/Numbers) *<span style="color: grey">real?</span>*, [float](https://developer.roblox.com/en-us/articles/Numbers) *<span style="color: grey">imag?</span>*)

Creates a new Complex Number object. *<span style="color: grey">real</span>* is the real component and *<span style="color: grey">imag</span>* is the imaginary component.

---
### [ComplexNumber](cmath.md) cmath.new([dict](https://developer.roblox.com/en-us/articles/Table#dictionaries) *<span style="color: grey">{[float](https://developer.roblox.com/en-us/articles/Numbers) Real?, [float](https://developer.roblox.com/en-us/articles/Numbers) Imag?}</span>*)

Creates a new Complex Number object using a dictionary instead of two separate arguments.

<br><br>

## Properties
---
### [float](https://developer.roblox.com/en-us/articles/Numbers) Real
The real component of the Complex Number.

---
### [float](https://developer.roblox.com/en-us/articles/Numbers) Imag
The imaginary component of the Complex Number.

<br><br>

## Methods
---
### [float](https://developer.roblox.com/en-us/articles/Numbers), [float](https://developer.roblox.com/en-us/articles/Numbers) polar()

Returns the polar representation of a Complex Number. First number is the distance from origin (magnitude) and the second is the phase angle in radians. Magnitude is calculated using the [abs](#floathttpsdeveloperrobloxcomen-usarticlesnumbers-abs) method. Phase angle is calculated with
$$
\theta=\mathrm{atan2}\left(b{,}\ a\right)
$$

---
### [ComplexNumber](cmath.md) exp()

Returns e (approximately 2.7182818) raised to the power of a Complex Number. Uses the formula
$$
e^z=e^a\cos b+ie^a\sin b{,}\ \mathrm{where}\ z=a+bi\ \mathrm{and}\ a{,}\ b\in\mathbb{R}
$$

---
### [float](https://developer.roblox.com/en-us/articles/Numbers) abs()

Returns the absolute value (distance from origin) of a Complex Number with
$$
\left|z\right|=\sqrt{a^2+b^2}{,}\ \mathrm{where}\ z=a+bi\ \mathrm{and}\ a{,}\ b\in\mathbb{R}
$$
!!! important
    When performing comparisons `<`, `>`, `<=` and `>=` with complex numbers, the absolute value is used as there is no universally accepted way to compare complex numbers with each other. When using the `==` comparison, the real and complex components are compared individually.

<br><br>

## Mathematical operations
---
This section lists all mathematical operations supported by Complex Numbers. In this section $z$ and $w$ can both be either complex or real numbers. When necessary, real number inputs are automatically converted to complex numbers. In the following examples, $z=a+bi$ and $w=c+di$, where $a{,}\ b{,}\ c{,}\ d\in \mathbb{R}$.

### Addition and subtraction
To perform addition or subtraction with complex numbers, you can simply use `z+w` and `z-w` in your code. The formula used for this is
$$
z+w=a+c+(b+d)i
$$

### Multiplication
Multiplication is also supported using the standard `*` operator. This module performs complex multiplication as follows:
$$
z\cdot w=\left(ac-bd\right)+\left(ad+bc\right)i
$$

### Division
Division can be done using the `/` operator for any $z$ and $w$. Division uses the following formula:
$$
\frac{z}{w}=\frac{ac+bd}{c^2+d^2}+\frac{bc-ad}{c^2+d^2}i
$$

### Exponentiation
Exponentiation can be done using the `^` operator for any $z$ and $w$. The result is calculated as follows:
$$
z^w=e^{\log r\left(c+di\right)+\theta i\left(c+di\right)}
$$
where $r$ and $\theta$ are the magnitude and phase angle of the polar representation of the base.

###