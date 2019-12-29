Class AOC.Y2018.Day2 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 2;

Parameter Year = 2018;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day2).GetInput(..#Day,.pInput)
	
	set res=0
	set pos=$o(pInput(""),1,l)
	set two=0
	set three=0
	while pos'="" {
		k t
		for i=1:1:$length(l) {
			set c=$e(l,i)
			set t(c)=$i(t(c))
		}
		set temp3=0
		set temp2=0
		set p=$o(t(""),1,n)
		while p'="" {
			if n=2 {
				set:'temp2 two=two+1
				zw:pDebug&&'temp2 t
				w:pDebug&&'temp2 l_" is 2 "_p,!
				set temp2=1
				
			} elseif n=3 {
				set:'temp3 three=three+1
				zw:pDebug&&'temp2 t
				w:pDebug&&'temp3 l_" is 3 "_p,!
				set temp3=1
			}
			set p=$o(t(p),1,n)
		}
		set pos=$o(pInput(pos),1,l)
	}
	quit two*three
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day2).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		set t(l)=""
		set pos2=$o(t(""))
		while pos2'="" {
			set diff=0
			//w "compare:",!
			//w l,!
			//w pos2,!
			set ipos=0
			for i=1:1:$length(l) {
				if ($e(l,i))'=($e(pos2,i)) {
					set diff=diff+1
					set res=$e(l,1,i-1)_$e(l,i+1,*)
				}
			}
			
			if diff=1 {
				w:pDebug "diff: "_diff,!
				w:pDebug l,!
				w:pDebug pos2,!
				return res
			}
			set pos2=$o(t(pos2))
		}
		set pos=$o(pInput(pos),1,l)
	}
	quit res
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2018.Day2).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2018.Day2).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
