Class AOC.Y2015.Day8 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 8;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day8).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day8).ParseString(l,,.l)
		set len1=$length(l)
		set l=$e(l,2,*-1)
		set temppos=$find(l,"\")-1
		zw:pDebug l
		while temppos'=-1 {
			if $e(l,temppos+1)="""" {
				set l=$e(l,1,temppos-1)_""""_$e(l,temppos+2,*)
				//set temppos=temppos-1
			} elseif $e(l,temppos+1)="\" {
				set l=$e(l,1,temppos-1)_"\"_$e(l,temppos+2,*)
				//set temppos=temppos-1
			} elseif $e(l,temppos+1)="x" {
				set l=$e(l,1,temppos-1)_$char($zhex($e(l,temppos+2,temppos+3)))_$e(l,temppos+4,*)
				//set temppos=temppos-4
			}
			set temppos=$find(l,"\",temppos+1)-1
		}
		zw:pDebug l
		break:pDebug
		set res=res+(len1-$length(l))
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day8).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day8).ParseString(l,,.l)
		set len1=$length(l)
		zw:pDebug l
		set l=$replace(l,"\","\\")
		set l=$replace(l,"""","\""")
		zw:pDebug l
		break:pDebug
		set res=res+($length(l)+2-len1)
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day8).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day8).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
