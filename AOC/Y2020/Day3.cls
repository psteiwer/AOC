Class AOC.Y2020.Day3 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 3;

Parameter Year = 2020;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day3).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	set map=0
	while pos'="" {
		do ##class(AOC.Y2020.Day3).ParseString(l,,.l)
		set map=$i(map)
		set mapwidth=$length(l)
		for i=1:1:mapwidth {
			set map(map,i)=$e(l,i)
		}
		
		set pos=$o(pInput(pos),1,l)
	}

	set mapposx=1
	set mapposy=1
	while mapposy<map {
		set mapposx=mapposx+3
		set mapposy=mapposy+1
		if mapposx>mapwidth {
			set mapposx=mapposx-mapwidth
		}
		if map(mapposy,mapposx)="#" {
			set res=$i(res)
		}
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day3).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	set map=0
	while pos'="" {
		do ##class(AOC.Y2020.Day3).ParseString(l,,.l)
		set map=$i(map)
		set mapwidth=$length(l)
		for i=1:1:mapwidth {
			set map(map,i)=$e(l,i)
		}
		
		set pos=$o(pInput(pos),1,l)
	}

	set res2=1
	for slopes=1:1:5 {
		set res=0
		set slopex=$case(slopes,1:1,2:3,3:5,4:7,:1)
		set slopey=$case(slopes,1:1,2:1,3:1,4:1,:2)
		set mapposx=1
		set mapposy=1
		while mapposy<map {
			set mapposx=mapposx+slopex
			set mapposy=mapposy+slopey
			if mapposx>mapwidth {
				set mapposx=mapposx-mapwidth
			}
			if map(mapposy,mapposx)="#" {
				set res=$i(res)
			}
		}
		set res2=res2*res
	}
	
	Quit res2
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2020.Day3).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2020.Day3).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
