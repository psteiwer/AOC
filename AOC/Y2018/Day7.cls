Class AOC.Y2018.Day7 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 7;

Parameter Year = 2018;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day7).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		set a=$e($piece(l," must be finished before step ",1),*)
		set b=$e($piece(l," must be finished before step ",2),1)
		set start(a)=1
		set start(b)=1
		set order(a,b)=1
		set pos=$o(pInput(pos),1,l)
	}
	
	set x=$o(order(""))
	while x'="" {
		set y=$o(order(x,""))
		while y'="" {
			k start(y)
			set y=$o(order(x,y))
		}
		set x=$o(order(x))
	}
	
	merge avail=start
	
	set x=$o(avail(""))
	while x'="" {
		set res=res_x
		set used(x)=1
		set y=$o(order(x,""))
		while y'="" {
			set z=$o(order(""))
			set isavail=1
			while z'="" {
				if $g(order(z,y)) {
					if '$d(used(z)) {
						set isavail=0
					}
				}
				set z=$o(order(z))
			}
			if ((isavail) & ('$d(used(y)))) {
				set avail(y)=1
			}
			set y=$o(order(x,y))
		}
		k avail(x)
		set x=$o(avail(""))
	}
	quit res
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day7).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		
		
		
		set pos=$o(input(pos),1,l)
	}
	
	Quit res
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2018.Day7).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2018.Day7).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
