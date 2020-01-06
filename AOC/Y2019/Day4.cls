Class AOC.Y2019.Day4 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 4;

Parameter Year = 2019;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	set:pInput="" pInput="372037-905157"
	
	do ##class(AOC.Y2019.Day4).ParseString(pInput,"-",.minnum,.maxnum)
	
	set res=0
	for i=minnum:1:maxnum {
		set last=-1
		set hasrepeat=0
		set increasing=1
		for j=1:1:6 {
			if $e(i,j)<last {
				set increasing=0
				quit
			} elseif $e(i,j)=last {
				set hasrepeat=1
			}
			set last=$e(i,j)
		}
		
		if hasrepeat&&increasing {
			set res=$i(res)
		}
	}
	quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	set:pInput="" pInput="372037-905157"
	
	do ##class(AOC.Y2019.Day4).ParseString(pInput,"-",.minnum,.maxnum)
	
	set res=0
	for i=minnum:1:maxnum {
		set last=-1
		set hasrepeat=0
		set increasing=1
		set repeatcount=0
		for j=1:1:6 {
			if $e(i,j)<last {
				set increasing=0
				quit
			} elseif $e(i,j)=last {
				set repeatcount=$i(repeatcount)
				if ((j=6) && (repeatcount=1)) {
					set hasrepeat=1
				}
			} else {
				if repeatcount=1 {
					set hasrepeat=1
				}
				set repeatcount=0
			}
			set last=$e(i,j)
		}
		
		if hasrepeat&&increasing {
			set res=$i(res)
		}
	}
	quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day4).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day4).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
