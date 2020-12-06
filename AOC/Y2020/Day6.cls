Class AOC.Y2020.Day6 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 6;

Parameter Year = 2020;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day6).GetInput(..#Day,.pInput)
	
	set res=""
	set group=1
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2020.Day6).ParseString(l,,.l)
		
		if l="" {
			set group=$i(group)
		} else {
			for i=1:1:$length(l) {
				set answers(group,$e(l,i))=1
			}
		}

		set pos=$o(pInput(pos),1,l)
	}

	set g=$O(answers(""))
	while g'="" {
		set temp=0
		set a=$O(answers(g,""))
		while a'="" {
			set temp=$i(temp)
			set a=$O(answers(g,a))
		}
		set res=res+temp
		set g=$O(answers(g))
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day6).GetInput(..#Day,.pInput)
	
	set res=""
	set group=1
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2020.Day6).ParseString(l,,.l)
		if l="" {
			set group=$i(group)
		} else {
			set group(group)=$i(group(group))
			for i=1:1:$length(l) {
				set answers(group,$e(l,i))=$i(answers(group,$e(l,i)))
			}
		}

		set pos=$o(pInput(pos),1,l)
	}

	set g=$O(answers(""))
	while g'="" {
		set temp=0
		set a=$O(answers(g,""))
		while a'="" {
			set:answers(g,a)=group(g) temp=$i(temp)
			set a=$O(answers(g,a))
		}
		set res=res+temp
		set g=$O(answers(g))
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2020.Day6).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2020.Day6).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
