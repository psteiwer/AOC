Class AOC.Y2020.Day2 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 2;

Parameter Year = 2020;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day2).GetInput(..#Day,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2020.Day2).ParseString(l," ",.a,.b,.c)
		do ##class(AOC.Y2020.Day2).ParseString(a,"-",.min,.max)
        set char=$e(b,1)
        set count=0
        set strpos=$find(c,char)
        while strpos>0 {
            if $e(c,strpos-1)=char {
                set count=$i(count)
            }
            set strpos=$find(c,char,strpos)
        }

        if (count>=min)&&(count<=max) {
            set res=$i(res)
        }

		set pos=$o(input(pos),1,l)
	}
	quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day2).GetInput(..#Day,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2020.Day2).ParseString(l," ",.a,.b,.c)
		do ##class(AOC.Y2020.Day2).ParseString(a,"-",.min,.max)
        set char=$e(b,1)
        set count=0

        if (($e(c,min)=char)||($e(c,max)=char))&&($e(c,max)'=$e(c,min)) {
            set res=$i(res)
        }

		set pos=$o(input(pos),1,l)
	}
	quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2020.Day2).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2020.Day2).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
