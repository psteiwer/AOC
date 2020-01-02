Class AOC.Y2015.Day3 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 3;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day3).GetInput(..#Day,.pInput)
	
	set res=""
	set posx=0
	set posy=0
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day3).ParseString(l,,.l)

		for i=1:1:$l(l) {
			set:'$d(map(posy,posx)) res=$i(res)
			set map(posy,posx)=1
			set temp=$e(l,i)
			set posy=posy+$case(temp,"^":-1,"v":1,:0)
			set posx=posx+$case(temp,"<":-1,">":1,:0)
			set:'$d(map(posy,posx)) res=$i(res)
			set map(posy,posx)=1
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day3).GetInput(..#Day,.pInput)

	set res=""
	set posx(0)=0
	set posy(0)=0
	set posx(1)=0
	set posy(1)=0
	set counter=0
	set pos=$o(pInput(""),1,l)
	while pos'="" {

		do ##class(AOC.Y2015.Day3).ParseString(l,,.l)
		for i=1:1:$l(l) {
			set counter=$i(counter)#2
			set:'$d(map(posy(counter),posx(counter))) res=$i(res)
			set map(posy(counter),posx(counter))=1
			set temp=$e(l,i)
			set posy(counter)=posy(counter)+$case(temp,"^":-1,"v":1,:0)
			set posx(counter)=posx(counter)+$case(temp,"<":-1,">":1,:0)
			set:'$d(map(posy(counter),posx(counter))) res=$i(res)
			set map(posy(counter),posx(counter))=1
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day3).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day3).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
