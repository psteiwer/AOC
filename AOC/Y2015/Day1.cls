Class AOC.Y2015.Day1 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 1;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day1).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day1).ParseString(l,,.l)

		for i=1:1:$l(l) {
			if $e(l,i)="(" {
				set res=$i(res,1)
			} elseif $e(l,i)=")" {
				set res=$i(res,-1)
			}
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day1).GetInput(..#Day,.pInput)
	
	set level=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day1).ParseString(l,,.l)
		for i=1:1:$l(l) {
			set res=$i(res)
			if $e(l,i)="(" {
				set level=$i(level,1)
			} elseif $e(l,i)=")" {
				set level=$i(level,-1)
			}
			if level=-1 {
				return res
			}
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day1).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day1).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
