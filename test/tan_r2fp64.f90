
integer function tan_r2fp64() result(r)
  use FEQParse
  use iso_fortran_env
  implicit none
  integer,parameter :: N = 1000
  real(real64),parameter :: pi = 4.0_real64*atan(1.0_real64)
  type(EquationParser) :: f
  character(LEN=1),dimension(1:3) :: independentVars
  character(LEN=60) :: eqChar
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
  eqChar = 'f = \tan( 0.5*pi*x )*\tan( 0.5*pi*y )'

  ! Create the EquationParser object
  f = EquationParser(eqChar,independentVars)

  x = 0.0_real64
  do j = 1,N
    do i = 1,N
      x(i,j,1) = -1.0_real64 + (2.0_real64)/real(N,real64)*real(i - 1,real64)
      x(i,j,2) = -1.0_real64 + (2.0_real64)/real(N,real64)*real(j - 1,real64)
      fexact(i,j) = tan(0.5_real64*pi*x(i,j,1))*tan(0.5_real64*pi*x(i,j,2))
    end do
  end do

  ! Evaluate the equation
  feval = f % evaluate(x)
  if (maxval(abs(feval - fexact)) <= epsilon(1.0)) then
    r = 0
  else
    r = 1
  end if

  ! Clean up memory
  call f % Destruct()
  deallocate (x,feval,fexact)

end function tan_r2fp64
