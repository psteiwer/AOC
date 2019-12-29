Class AOC.Y2019.Day1 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 1;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day1).GetInput(..#Day,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		set res=res+((l\3)-2)
		set pos=$o(input(pos),1,l)
	}
	quit res
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day1).GetInput(..#Day,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.temp)
		while temp>0 {
			set temp=((temp\3)-2)
			set:temp>0 res=res+temp
		} 
		set pos=$o(input(pos),1,l)
	}
	quit res
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day1).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day1).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
