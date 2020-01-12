Class AOC.Y2015.Day16 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 16;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day16).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day16).ParseString(l,,.l)
		do ##class(AOC.Y2015.Day16).ParseString(l,"Sue ",,.l)
		do ##class(AOC.Y2015.Day16).ParseString(l,": ",.number,.l)
		for i=1:1:$length(l,",") {
			do ##class(AOC.Y2015.Day16).ParseString(l,": ",.item,.l)
			do ##class(AOC.Y2015.Day16).ParseString(l,", ",.value,.l)
			set sue(number,item)=value
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	set @"children"=3
	set @"cats"=7
	set @"samoyeds"=2
	set @"pomeranians"=3
	set @"akitas"=0
	set @"vizslas"=0
	set @"goldfish"=5
	set @"trees"=3
	set @"cars"=2
	set @"perfumes"=1

	for i=1:1:500 {
		set possible=1
		for item="children","cats","samoyeds","pomeranians","akitas","vizslas","goldfish","trees","cars","perfumes" {
			if $D(sue(i,item)) {
				if sue(i,item)=(@item) {
					continue
				} else {
					set possible=0
					quit
				}
			}
		}
		set:possible res=i
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day16).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day16).ParseString(l,,.l)
		do ##class(AOC.Y2015.Day16).ParseString(l,"Sue ",,.l)
		do ##class(AOC.Y2015.Day16).ParseString(l,": ",.number,.l)
		for i=1:1:$length(l,",") {
			do ##class(AOC.Y2015.Day16).ParseString(l,": ",.item,.l)
			do ##class(AOC.Y2015.Day16).ParseString(l,", ",.value,.l)
			set sue(number,item)=value
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	set @"children"=3
	set @"cats"=7
	set @"samoyeds"=2
	set @"pomeranians"=3
	set @"akitas"=0
	set @"vizslas"=0
	set @"goldfish"=5
	set @"trees"=3
	set @"cars"=2
	set @"perfumes"=1

	for i=1:1:500 {
		set possible=1
		for item="children","cats","samoyeds","pomeranians","akitas","vizslas","goldfish","trees","cars","perfumes" {
			if $D(sue(i,item)) {
				if ((item="cats")||(item="trees")) {
					if sue(i,item)>(@item) {
						continue
					} else {
						set possible=0
						quit
					}
				} elseif ((item="pomeranians")||(item="goldfish")) {
					if sue(i,item)<(@item) {
						continue
					} else {
						set possible=0
						quit
					}
				} else {
					if sue(i,item)=(@item) {
						continue
					} else {
						set possible=0
						quit
					}
				}
			}
		}
		set:possible res=i
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day16).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day16).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
