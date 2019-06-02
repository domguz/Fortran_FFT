# Fortran_FFT
1)We have a signal with a function:
**f(t)=sin(2πt*200)+2sin(2πt*400)**,

and a chart like this:
![alt text](https://github.com/domguz/Fortran_FFT/blob/master/res/signal.png)

then a fast fourier transform was made to get a frequency
![alt text](https://github.com/domguz/Fortran_FFT/blob/master/res/sigFreq.png)


As you can see, the signal constists of 2 signals with frequnecies: 200 and 400 Hz
The FFT (Fast Fourier Transform) is used here to get the signals, that the final signal is made of.

2)We use the sinus signal: **f(t)=sin(2πt)**.
With a chart:
![alt text](https://github.com/domguz/Fortran_FFT/blob/master/res/ClearSinus.png)

and then contaminate him:
![alt text](https://github.com/domguz/Fortran_FFT/blob/master/res/sinTime.png)

and then on contaminated signal the FFT is made:
![alt text](https://github.com/domguz/Fortran_FFT/blob/master/res/sinFreq.png)

Signals with low value are deleted:
![alt text](https://github.com/domguz/Fortran_FFT/blob/master/res/sinFreqClear.png)

and the fft is made one more time:
![alt text](https://github.com/domguz/Fortran_FFT/blob/master/res/sinusCleared.png)


we can see, the "cleared" sinus is almost identical, so FFT is very effective way to clear the contaminated signals.





