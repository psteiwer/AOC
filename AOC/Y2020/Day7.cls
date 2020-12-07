Class AOC.Y2020.Day7 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 7;

Parameter Year = 2020;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day7).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2020.Day7).ParseString(l,"contain ",.main,.contents)
		set main=$piece(main," ",1,2)
		for i=1:1:$length(contents,", ") {
			if $piece(contents,", ",i)="no other bags." {
				continue
			} else {
				set temp=$piece(contents,", ",i)
				do ##class(AOC.Y2020.Day7).ParseString(temp," ",.num,.style,.color,.ignore)
				set bags(style_" "_color,main)=num
			}
		}
		
		set pos=$o(pInput(pos),1,l)
	}

	set temp=$O(bags("shiny gold",""))
	while temp'="" {
		if '$d(res(temp)) {
			set res=$i(res)
			set res(temp)=""
		}
		set temp=$O(bags("shiny gold",temp))
	}
	set done=0
	while 'done {
		set done=1
		set temp=$O(res(""))
		while temp'="" {
			set next=$O(bags(temp,""))
			while next'="" {
				if '$d(res(next)) {
					set res=$i(res)
					set done=0
					set res(next)=""
				}
				set next=$O(bags(temp,next))
			}
			set temp=$O(res(temp))
		}
	}

	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day7).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2020.Day7).ParseString(l,"contain ",.main,.contents)
		set main=$piece(main," ",1,2)
		for i=1:1:$length(contents,", ") {
			if $piece(contents,", ",i)="no other bags." {
				set bags(main)=0
			} else {
				set temp=$piece(contents,", ",i)
				do ##class(AOC.Y2020.Day7).ParseString(temp," ",.num,.style,.color,.ignore)
				set bags(main,style_" "_color)=num
			}
		}
		
		set pos=$o(pInput(pos),1,l)
	}

	set done=0
	while 'done {
		set done=1
		set next=$O(bags(""))
		while next'="" {
			set temp=$O(bags(next,""))
			if temp="" {
				set rollup=$O(bags(""))
				while rollup'="" {
					if $D(bags(rollup,next)) {
						set done=0
						set bags(rollup)=$G(bags(rollup))+(bags(rollup,next)*bags(next))+bags(rollup,next)
						k bags(rollup,next)
					}
					set rollup=$O(bags(rollup))
				}
			}
			set next=$O(bags(next))
		}
	}

	Quit bags("shiny gold")
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2020.Day7).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2020.Day7).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
