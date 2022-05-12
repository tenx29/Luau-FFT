# Fourier

The Fourier module has two different methods you can use for performing discrete Fourier transforms.
!!! warning "Dependency"
    This module needs to perform calculations with complex numbers and must therefore have the same Parent as the [Complex Number module](cmath.md).

<br><br>

## What is a Fourier transform?
---
!!! warning
    This section is me trying my best to explain how the module works, but I'm not a professional. If you wish to learn more about Fourier transforms, ask someone with a degree.

According to [Wikipedia](https://en.wikipedia.org/wiki/Fourier_transform), a Fourier transform is
> a mathematical transform that decomposes functions depending on space or time into functions depending on spatial frequency or temporal frequency.

In simpler terms, it can be used to find out the intensity of sine waves of various frequencies that can be used to construct virtually any function. A common use for this is to calculate the frequency spectrum of a group of audio samples for audio visualization.

Ideally, a Fourier transform of a function would be calculated as

$$
\mathcal{F[f(x)](y)=\int_{-\infty}^{\infty}f\left(x\right)e^{-2\pi ixy}\ dx}
$$

However, because usually we don't need the symbolic solution (or don't have the computing power, memory or time to calculate it), this module uses something known as the **discrete Fourier transform**, which is the numeric equivalent for the Fourier transform using a finite set of samples with equal spacing. For this reason we use a different formula:
$$
X_k=\sum_{n=0}^{N-1}x_n\cdot e^{-\frac{2\pi i}{N}kn}
$$
where

* $X$ is the sequence of output frequencies,
* $k$ is the frequency, or the index of the intensity value $X_k$
* $x$ is the sequence of input samples,
* $N$ is the amount of input samples,
* $n$ is the current sample being iterated over.

The result is a fairly good approximation of the input signal's Fourier transform which is good enough for most purposes.

## Functions

!!! important
    The tables returned by **[dft](#tablehttpsdeveloperrobloxcomen-usarticlestable-dfttablehttpsdeveloperrobloxcomen-usarticlestable-span-style"color-grey"samplesspan-integerhttpsdeveloperrobloxcomen-usarticlesnumbers-span-style"color-grey"maxfrequencyspan-booleanhttpsdeveloperrobloxcomen-usarticlesnumbers-span-style"color-grey"getabsolutespan)** and **[fft](#tablehttpsdeveloperrobloxcomen-usarticlestable-ffttablehttpsdeveloperrobloxcomen-usarticlestable-span-style"color-grey"samplesspan-booleanhttpsdeveloperrobloxcomen-usarticlesnumbers-span-style"color-grey"ignoreconjugatespan-booleanhttpsdeveloperrobloxcomen-usarticlesnumbers-span-style"color-grey"getabsolutespan)** have the DC term of the Fourier transform at an index of 0. Other values are indexed normally by frequency.

---

### [table](https://developer.roblox.com/en-us/articles/Table) dft([table](https://developer.roblox.com/en-us/articles/Table) *<span style="color: grey">samples</span>*, [integer](https://developer.roblox.com/en-us/articles/Numbers) *<span style="color: grey">maxFrequency?</span>*, [boolean](https://developer.roblox.com/en-us/articles/Numbers) *<span style="color: grey">getAbsolute?</span>*)

Returns the discrete Fourier transform of the sample list *<span style="color: grey">samples</span>*. All samples must be real or complex numbers. The *<span style="color: grey">maxFrequency</span>* determines the maximum frequency calculated by the DFT algorithm. ($N/2$ by default, where $N$ is the amount of samples) If *<span style="color: grey">getAbsolute</span>* is `true`, the complex values in the result table are converted into real numbers based on their magnitudes.

!!! note
    If you need the conjugate data to be included in the result, set *<span style="color: grey">maxFrequency</span>* to the amount of samples.

!!! danger "Performance notice"
    Discrete Fourier transform has a time complexity of $n^2$, which means calculating the DFT of large input sample tables may be slow.

---

### [table](https://developer.roblox.com/en-us/articles/Table) fft([table](https://developer.roblox.com/en-us/articles/Table) *<span style="color: grey">samples</span>*, [boolean](https://developer.roblox.com/en-us/articles/Numbers) *<span style="color: grey">ignoreConjugate?</span>*, [boolean](https://developer.roblox.com/en-us/articles/Numbers) *<span style="color: grey">getAbsolute?</span>*)

Returns the fast Fourier transform of the sample list *<span style="color: grey">samples</span>* using the [Cooley-Tukey FFT algorithm](https://en.wikipedia.org/wiki/Cooley%E2%80%93Tukey_FFT_algorithm). Returns a result similar to DFT, but is a faster algorithm and is therefore more suitable for larger data sets. If *<span style="color: grey">ignoreConjugate</span>* is `true`, the conjugate data will be automatically cut off from the spectrum. If *<span style="color: grey">getAbsolute</span>* is `true`, the FFT will automatically be converted into its real counterpart similar to [dft](#tablehttpsdeveloperrobloxcomen-usarticlestable-dfttablehttpsdeveloperrobloxcomen-usarticlestable-span-style"color-grey"samplesspan-integerhttpsdeveloperrobloxcomen-usarticlesnumbers-span-style"color-grey"maxfrequencyspan-booleanhttpsdeveloperrobloxcomen-usarticlesnumbers-span-style"color-grey"getabsolutespan).
!!! danger "Performance notice"
    Fast Fourier transform has a time complexity of $n \log{n}$, which means calculating the FFT of extremely large input sample tables may be slow.

---
