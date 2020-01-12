Class AOC.Y2015.Day17 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 17;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day17).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day17).ParseString(l,,.l)
		set container($i(container))=l
		
		set pos=$o(pInput(pos),1,l)
	}

	for i=1:1:(2**container)-1 {
		set temp=$factor(i)
		set total=0
		for j=1:1:$bitcount(temp) {
			set:$bit(temp,j) total=total+container(j)
			quit:total>150
		}
		set:total=150 res=$i(res)
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day17).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day17).ParseString(l,,.l)
		set container($i(container))=l
		
		set pos=$o(pInput(pos),1,l)
	}

	set minnum=20
	for i=1:1:(2**container)-1 {
		set temp=$factor(i)
		set numcontainers=$bitcount(temp,1)
		continue:numcontainers>minnum
		set total=0
		for j=1:1:$bitcount(temp) {
			set:$bit(temp,j) total=total+container(j)
			quit:total>150
		}
		if total=150 {
			if numcontainers<minnum {
				set minnum=numcontainers
				set res=0
			}
			set res=$i(res)
		}
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day17).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day17).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
