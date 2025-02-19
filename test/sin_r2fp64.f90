program test

  implicit none
  integer :: exit_code
  
  exit_code = sin_r2fp64()
  stop exit_code

contains

integer function sin_r2fp64() result(r)
  use FEQParse
  use iso_fortran_env
  implicit none
  integer,parameter :: N = 10
  real(real64),parameter :: pi = 4.0_real64*atan(1.0_real64)
  type(EquationParser) :: f
  character(LEN=1),dimension(1:3) :: independentVars
  character(LEN=1024) :: eqChar
  real(real64),allocatable :: x(:,:,:)
  real(real64),allocatable :: feval(:,:)
  real(real64),allocatable :: fexact(:,:)
  integer :: i,j

  allocate (x(1:N,1:N,1:3), &
            feval(1:N,1:N), &
            fexact(1:N,1:N))

  ! Specify the independent variables
  independentVars = (/'x','y','z'/)

  ! Specify an equation string that we want to evaluate
  eqChar = 'f = sin( 2.0*pi*x )*sin( 2.0*pi*y )'

  ! Create the EquationParser object
  f = EquationParser(eqChar,independentVars)

  x = 0.0_real64
  do j = 1,N
    do i = 1,N
      x(i,j,1) = -1.0_real64 + (2.0_real64)/real(N,real64)*real(i - 1,real64)
      x(i,j,2) = -1.0_real64 + (2.0_real64)/real(N,real64)*real(j - 1,real64)
      fexact(i,j) = sin(2.0_real64*pi*x(i,j,1))*sin(2.0_real32*pi*x(i,j,2))
    end do
  end do

  ! Evaluate the equation
  feval = f % evaluate(x)
  if (maxval(abs(feval - fexact)) <= epsilon(1.0)) then
    r = 0
  else
    r = 1
  end if

  deallocate (x,feval,fexact)

end function sin_r2fp64
end program test
