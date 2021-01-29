Class AOC.Y2020.Day1 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 1;

Parameter Year = 2020;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day1).GetInput(..#Day,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2020.Day1).ParseString(l,,.l)
		
		set nums($i(num))=l
		if num>1 {
			for i=1:1:num-1 {
				if l+nums(i)=2020 {
					set res=l*nums(i)
					return res
				}
			}
		}


		set pos=$o(input(pos),1,l)
	}
	quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day1).GetInput(..#Day,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2020.Day1).ParseString(l,,.l)
		
		set nums($i(num))=l
		if num>2 {
			for i=1:1:num-2 {
				for j=2:1:num-1 {
					if l+nums(i)+nums(j)=2020 {
						set res=l*nums(i)*nums(j)
						return res
					}
				}
			}
		}


		set pos=$o(input(pos),1,l)
	}
	quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2020.Day1).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2020.Day1).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
