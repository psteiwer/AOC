Class AOC.Y2015.Day2 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 2;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day2).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day2).ParseString(l,"x",.l,.w,.h)
		
		set side1=(l*w)
		set side2=(w*h)
		set side3=(h*l)
		set min=##class(Math.Math).Min(side1,side2,side3)
		set res=res+((side1*2)+(side2*2)+(side3*2))+min
		
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day2).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day2).ParseString(l,"x",.l,.w,.h)
		
		set perim1=(l+w)*2
		set perim2=(w+h)*2
		set perim3=(h+l)*2
		set min=##class(Math.Math).Min(perim1,perim2,perim3)
		set res=res+min+(l*w*h)
		
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day2).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day2).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
