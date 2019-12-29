Class AOC.Y2018.Day3 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 3;

Parameter Year = 2018;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day3).GetInput(..#Day,.pInput)
	
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		set c=$piece(l," ",3)
		set s=$piece(l," ",4)
		set x=$p(c,",",1)
		set y=$p(c,",",2)
		set y=$p(y,":",1)
		set h=$p(s,"x",1)
		set w=$p(s,"x",2)
		
		for i=1:1:h {
			for j=1:1:w {
				set f(x+i,y+j)=$i(f(x+i,y+j))
			}
		}
		set pos=$o(pInput(pos),1,l)
	}
		
	set res=0
	set i=$o(f(""))
	while i'="" {
		set j=$o(f(i,""))
		while j'="" {
			if f(i,j)>1 {
				set res=res+1
			}
			set j=$o(f(i,j))
		}
		set i=$o(f(i))
	}
	
	quit res
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day3).GetInput(..#Day,.pInput)
	
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		set n=$piece(l," ",1)
		set claims(n)=""
		set c=$piece(l," ",3)
		set s=$piece(l," ",4)
		set x=$p(c,",",1)
		set y=$p(c,",",2)
		set y=$p(y,":",1)
		set h=$p(s,"x",1)
		set w=$p(s,"x",2)
		
		for i=1:1:h {
			for j=1:1:w {
				set f(x+i,y+j)=$g(f(x+i,y+j))_$lb(n)
			}
		}
		set pos=$o(pInput(pos),1,l)
	}
	
	set res=0
	set i=$o(f(""))
	while i'="" {
		set j=$o(f(i,""))
		while j'="" {
			if $ll(f(i,j))>1 {
				for k=1:1:$ll(f(i,j)) {
					k claims($lg(f(i,j),k))
				}
			}
			set j=$o(f(i,j))
		}
		set i=$o(f(i))
	}
	set res=$o(claims(""))
	quit $e(res,2,*)
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2018.Day3).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2018.Day3).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
