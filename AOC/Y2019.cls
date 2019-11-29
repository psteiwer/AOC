Class AOC.Y2019 Extends AOC.Base
{

PARAMETER Year As %Integer = 2019;

ClassMethod D1P1() As %String
{
	do ##class(AOC.Y2019).GetInput(1,.out)
	
	set res=""
	set pos=$o(out(""),1,l)
	while pos'="" {
		
		set pos=$o(out(pos),1,l)
	}
	quit res
}


}