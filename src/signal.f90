program signal

    !add fftw
    use, intrinsic :: iso_c_binding
    implicit none
    include "fftw3.f03"

	!parameters
    integer, parameter :: n = 2000
    real(c_double), allocatable :: din(:)
    complex(c_double_complex), allocatable :: dout(:)
    type(c_ptr) :: p1
    real(16) :: t = 0.0
    real(16) :: dt=1/real(n-1)
    real(16) :: v
    integer::i

	!create output files
    open (unit = 1, file = "../res/sigTime")
    open (unit = 2, file = "../res/sigFreq")
    allocate(din(n))
    allocate(dout(n/2+1))

	!generate signal and write to file
    do i=1,n
        t=t+dt
        din(i)=sin(2*3.1415*t*200)+2*sin(2*3.1415*t*400)
        write(1,*) t," ",din(i)
    end do

	!make fas fourier
    p1 = fftw_plan_dft_r2c_1d(size(din), din, dout, FFTW_ESTIMATE+FFTW_UNALIGNED)
    call fftw_execute_dft_r2c(p1, din, dout)

	!write frequency to file
    do i=1,n/2+1
        v=abs(dout(i))
        if(v /= v)v=0.0
        write(2,'(I15," ", F15.10)')i, v
    end do

    call fftw_destroy_plan(p1)

end program signal
