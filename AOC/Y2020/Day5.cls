Class AOC.Y2020.Day5 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 5;

Parameter Year = 2020;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day5).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)

	while pos'="" {
		do ##class(AOC.Y2020.Day5).ParseString(l,,.l)
		
		set minrow=0
		set maxrow=127
		set minseat=0
		set maxseat=7
		for i=1:1:$length(l) {
			if $e(l,i)="F" {
				set maxrow=maxrow-((maxrow-minrow)\2)-1
			} elseif $e(l,i)="B" {
				set minrow=minrow+((maxrow-minrow)\2)+1
			} elseif $e(l,i)="L" {
				set maxseat=maxseat-((maxseat-minseat)\2)-1
			} else {
				set minseat=minseat+((maxseat-minseat)\2)+1
			}
		}
		set temp=minrow*8+minseat
		if temp>res {
			set res=temp
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day5).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	for i=0:1:127 {
		for j=0:1:7 {
			set seats(i,j)=1
		}
	}

	set finalminrow=127
	set finalmaxrow=0
	while pos'="" {
		do ##class(AOC.Y2020.Day5).ParseString(l,,.l)
		set minrow=0
		set maxrow=127
		set minseat=0
		set maxseat=7
		for i=1:1:$length(l) {
			if $e(l,i)="F" {
				set maxrow=maxrow-((maxrow-minrow)\2)-1
			} elseif $e(l,i)="B" {
				set minrow=minrow+((maxrow-minrow)\2)+1
			} elseif $e(l,i)="L" {
				set maxseat=maxseat-((maxseat-minseat)\2)-1
			} else {
				set minseat=minseat+((maxseat-minseat)\2)+1
			}
		}
		k seats(minrow,minseat)
		set temp=minrow*8+minseat
		if temp>res {
			set res=temp
		}
		if minrow<finalminrow {
			set finalminrow=minrow
		}
		if minrow>finalmaxrow {
			set finalmaxrow=minrow
		}
		
		set pos=$o(pInput(pos),1,l)
	}

	for i=0:1:finalminrow-1 {
		k seats(i)
	}
	for i=finalmaxrow:1:127 {
		k seats(i)
	}
	
	set resrow=$O(seats(""))
	set resseat=$O(seats(resrow,""))
	set res=resrow*8+resseat
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2020.Day5).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2020.Day5).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
