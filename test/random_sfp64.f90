program test

  implicit none
  integer :: exit_code
  
  exit_code = random_sfp64()
  stop exit_code

contains

integer function random_sfp64() result(r)
  use FEQParse
  use iso_fortran_env
  implicit none
  integer,parameter :: N = 10
  type(EquationParser) :: f
  character(LEN=1),dimension(1:3) :: independentVars
  character(LEN=2048) :: eqChar
  real(real64) :: x(1:3)
  real(real64) :: feval
  integer :: i

  ! Specify the independent variables
  independentVars = (/'x','y','z'/)

  ! Specify an equation string that we want to evaluate
  eqChar = 'f = rand( x )'

  ! Create the EquationParser object
  f = EquationParser(eqChar,independentVars)

  x = 0.0_real64

  ! Evaluate the equation
  feval = f % evaluate(x)
  if ((abs(feval)) <= 1.0_real64) then
    r = 0
  else
    r = 1
  end if

end function random_sfp64
end program test
