Class AOC.Y2018.Day1 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 1;

Parameter Year = 2018;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day1).GetInput(..#Day,.pInput)
	
	set res=0
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		set res=res+l
		set pos=$o(pInput(pos),1,l)
	}
	quit res
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day1).GetInput(..#Day,.pInput)
	
	set res=0
	set done=0
	set pos=$o(pInput(""),1,l)
	while 'done {
		if pos'="" {
			set res=res+l
			set:$g(d(res)) done=1
			set d(res)=1
		}
		set pos=$o(pInput(pos),1,l)
	}
	quit res
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2018.Day1).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2018.Day1).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
