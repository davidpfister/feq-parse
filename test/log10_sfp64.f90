program test

  implicit none
  integer :: exit_code
  
  exit_code = log10_sfp64()
  stop exit_code

contains

integer function log10_sfp64() result(r)
  use FEQParse
  use iso_fortran_env
  implicit none
  integer,parameter :: N = 10
  type(EquationParser) :: f
  character(LEN=1),dimension(1:3) :: independentVars
  character(LEN=2048) :: eqChar
  real(real64) :: x(1:3)
  real(real64) :: feval
  real(real64) :: fexact
  integer :: i

  ! Specify the independent variables
  independentVars = (/'x','y','z'/)

  ! Specify an equation string that we want to evaluate
  eqChar = 'f = log10( x )'

  ! Create the EquationParser object
  f = EquationParser(eqChar,independentVars)

  x = 10.0_real64
  fexact = log10(x(1))

  ! Evaluate the equation
  feval = f % evaluate(x)
  if ((abs(feval - fexact)) <= epsilon(1.0_real64)) then
    r = 0
  else
    r = 1
  end if

end function log10_sfp64
end program test
