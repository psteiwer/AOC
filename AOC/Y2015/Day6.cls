Class AOC.Y2015.Day6 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 6;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day6).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day6).ParseString(l,,.l)
		set toRange=$piece(l," ",*)
		set toX=$piece(toRange,",",1)
		set toY=$piece(toRange,",",2)
		
		set command=$select($find(l,"turn on"):1,$find(l,"toggle"):2,$find(l,"turn off"):3,1:-1)

		set fromRange=$piece(l," ",$case(command,1:3,2:2,3:3,:0))
		set fromX=$piece(fromRange,",",1)
		set fromY=$piece(fromRange,",",2)

		for col=fromX:1:toX {
			for row=fromY:1:toY {
				if command=1 {
					set:$g(map(row,col),0)=0 res=$i(res)
					set map(row,col)=1
				} elseif command=2 {
					set map(row,col)=$i(map(row,col))#2
					set:map(row,col)=1 res=$i(res)
					set:map(row,col)=0 res=$i(res,-1)
				} elseif command=3 {
					set:$g(map(row,col),0)=1 res=$i(res,-1)
					set map(row,col)=0
				}
			}
		}

		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day6).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day6).ParseString(l,,.l)
		set toRange=$piece(l," ",*)
		set toX=$piece(toRange,",",1)
		set toY=$piece(toRange,",",2)
		
		set command=$select($find(l,"turn on"):1,$find(l,"toggle"):2,$find(l,"turn off"):3,1:-1)

		set fromRange=$piece(l," ",$case(command,1:3,2:2,3:3,:0))
		set fromX=$piece(fromRange,",",1)
		set fromY=$piece(fromRange,",",2)

		for col=fromX:1:toX {
			for row=fromY:1:toY {
				set oldbright=$g(map(row,col),0)
				if command=1 {
					set map(row,col)=$i(map(row,col))
				} elseif command=2 {
					set map(row,col)=$i(map(row,col),2)
				} elseif command=3 {
					set:$g(map(row,col),0)>0 map(row,col)=$i(map(row,col),-1)
				}
				set newbright=$g(map(row,col),0)
				set res=res+(newbright-oldbright)
			}
		}

		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day6).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day6).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
