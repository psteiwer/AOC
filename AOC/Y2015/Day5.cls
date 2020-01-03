Class AOC.Y2015.Day5 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 5;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day5).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day5).ParseString(l,,.l)
		set containsdouble=0
		set vowelcount=0
		set containsbad=0

		for i=1:1:$l(l) {
			set temp=$e(l,i,i+1)
			if (temp="ab")||(temp="cd")||(temp="pq")||(temp="xy") {
				set containsbad=1
			}
			if "aeiou"[$e(l,i) {
				set vowelcount=$i(vowelcount)
			}
			if $e(l,i)=$e(l,i+1) {
				set containsdouble=1
			}
		}
		if 'containsbad&&containsdouble&&(vowelcount>2) {
			set res=$i(res)
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day5).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day5).ParseString(l,,.l)
		set containsspaced=0
		set containsdoublepair=0
		k pairs

		for i=1:1:$l(l) {
			if $e(l,i)=$e(l,i+2) {
				set containsspaced=1
			}
			if i-$g(pairs($e(l,i,i+1)),i)>1 {
				set containsdoublepair=1
			} elseif '$d(pairs($e(l,i,i+1))) {
				set pairs($e(l,i,i+1))=i
			}	
		}
		if containsdoublepair&&containsspaced {
			zw:pDebug l
			set res=$i(res)
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day5).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day5).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
