Class AOC.Y2019.Day3 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 3;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day3).GetInput(..#Day,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	
	set x=0
	set y=0
	set count=0
	set grid1(x,y)=1
	for i=0:1:$length(l,",")-1 {
		set dir=$e($p(l,",",i+1),1)
		set num=$e($p(l,",",i+1),2,*)
		for j=1:1:num {
			if dir="R" {
				set x=x+1
			} elseif dir="L" {
				set x=x-1
			} elseif dir="U" {
				set y=y+1
			} elseif dir="D" {
				set y=y-1
			}
			set grid1(x,y)=1
		}
	}
	
	set pos=$o(input(pos),1,l)
	set x=0
	set y=0
	set grid2(x,y)=1
	for i=0:1:$length(l,",")-1 {
		set dir=$e($p(l,",",i+1),1)
		set num=$e($p(l,",",i+1),2,*)
		for j=1:1:num {
			if dir="R" {
				set x=x+1
			} elseif dir="L" {
				set x=x-1
			} elseif dir="U" {
				set y=y+1
			} elseif dir="D" {
				set y=y-1
			}
			set grid2(x,y)=1
		}
	}
	
	set maxdistance=999999
	
	set g1x=$order(grid1(""))
	while g1x'="" {
		set g1y=$order(grid1(g1x,""))
		while g1y'="" {
			if $d(grid1(g1x,g1y))&&$d(grid2(g1x,g1y)) {
				set temp=$zabs(g1x)+$zabs(g1y)
				if temp<maxdistance {
					set:temp'=0 maxdistance=temp
				}
			}
			set g1y=$order(grid1(g1x,g1y))
		}
		set g1x=$order(grid1(g1x))
	}
	
	quit maxdistance
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day3).GetInput(..#Day,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	
	set x=0
	set y=0
	set count=0
	set grid1(x,y)=1
	for i=0:1:$length(l,",")-1 {
		set dir=$e($p(l,",",i+1),1)
		set num=$e($p(l,",",i+1),2,*)
		for j=1:1:num {
			if dir="R" {
				set x=x+1
			} elseif dir="L" {
				set x=x-1
			} elseif dir="U" {
				set y=y+1
			} elseif dir="D" {
				set y=y-1
			}
			set grid1(x,y)=$i(count)
		}
	}
	
	set pos=$o(input(pos),1,l)
	set x=0
	set y=0
	set count=0
	set grid2(x,y)=1
	for i=0:1:$length(l,",")-1 {
		set dir=$e($p(l,",",i+1),1)
		set num=$e($p(l,",",i+1),2,*)
		for j=1:1:num {
			if dir="R" {
				set x=x+1
			} elseif dir="L" {
				set x=x-1
			} elseif dir="U" {
				set y=y+1
			} elseif dir="D" {
				set y=y-1
			}
			set grid2(x,y)=$i(count)
		}
	}
	
	set maxsteps=999999999
	
	set g1x=$order(grid1(""))
	while g1x'="" {
		set g1y=$order(grid1(g1x,""))
		while g1y'="" {
			if $d(grid1(g1x,g1y))&&$d(grid2(g1x,g1y)) {
				set temp=grid1(g1x,g1y)+grid2(g1x,g1y)
				if temp<maxsteps {
					set:temp'=2 maxsteps=temp
				}
			}
			set g1y=$order(grid1(g1x,g1y))
		}
		set g1x=$order(grid1(g1x))
	}
	
	quit maxsteps
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day3).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day3).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
