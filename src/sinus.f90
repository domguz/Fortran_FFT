program sinus

    !add fftw     
    use, intrinsic :: iso_c_binding
    implicit none
    include "fftw3.f03"
	
	!parameters
    integer, parameter :: n = 2000
	real(16) :: v
    real(c_double), allocatable :: din(:)
    complex(c_double_complex), allocatable :: dout(:)
    type(c_ptr) :: p1, p2
    real(16) :: t = 0.0
    real(16) :: dt=10/real(n-1)
    integer::i
	integer,parameter :: seed = 12345

	allocate(din(n))
    allocate(dout(n/2+1))
	call srand(seed)
	
	!create files
    open (unit = 1, file = "../res/sinTimeContaminated")
    open (unit = 2, file = "../res/sinFreqContaminated")
	open (unit = 3, file = "../res/sinTimeClear")
    open (unit = 4, file = "../res/sinFreqClear")
    open (unit = 5, file = "../res/sinTimeCleared")


    !contaminated sinus and clar sinus times
    do i=1,n
        t=t+dt
        write(3,*) t," ",sin(t)
        din(i)=sin(t) + rand()-rand()
        write(1,*) t," ",0.001*din(i)
    end do
 
 
    p1 = fftw_plan_dft_r2c_1d(size(din), din, dout, FFTW_ESTIMATE+FFTW_UNALIGNED)
    p2 = fftw_plan_dft_c2r_1d(size(din), dout, din, FFTW_ESTIMATE+FFTW_UNALIGNED)
    call fftw_execute_dft_r2c(p1, din, dout)

	!contaminated and clear sinus frequencies
    do i=1,n/2+1
        v=abs(dout(i))
        if(v /= v)v=0.0
        write(2,'(I15," ", F15.10)')i, v
        if(abs(dout(i))<50) dout(i)=0.0
    end do

    do i=1,n/2+1
        write(4,'(I15," ", F15.10)')i, abs(dout(i))
    end do

    call fftw_execute_dft_c2r(p2, dout, din)

	!cleared sinus time
    t = 0.0
    dt=10/real(n-1)
    do i=1,n
        t=t+dt
        write(5,*) t," ",din(i)/n

    end do

    call fftw_destroy_plan(p1)
    call fftw_destroy_plan(p2)

    close(1)
    close(2)
    close(3)
    close(4)
    close(5)

end program sinus
