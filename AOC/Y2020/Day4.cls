Class AOC.Y2020.Day4 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 4;

Parameter Year = 2020;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day4).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	set people=1
	set expected=$lb("byr","iyr","eyr","hgt","hcl","ecl","pid","cid")

	while pos'="" {
		do ##class(AOC.Y2020.Day4).ParseString(l,,.l)
		if l="" {
			set people=$i(people)
		} else {
			for i=1:1:$length(l," ") {
				set temp=$piece(l," ",i)
				set key=$piece(temp,":",1)
				set val=$piece(temp,":",2)
				set people(people,key)=val
				set people(people,"values")=$i(people(people,"values"))
			}
		}
		
		set pos=$o(pInput(pos),1,l)
	}

	for i=1:1:people {
		set valid=0
		if people(i,"values")=8 {
			set valid=1
		} elseif (people(i,"values")=7) && ('$Data(people(i,"cid")))  {
			set valid=1
		}

		set:valid res=$i(res)
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2020.Day4).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	set people=1
	set expected=$lb("byr","iyr","eyr","hgt","hcl","ecl","pid","cid")

	while pos'="" {
		do ##class(AOC.Y2020.Day4).ParseString(l,,.l)
		if l="" {
			set people=$i(people)
		} else {
			for i=1:1:$length(l," ") {
				set temp=$piece(l," ",i)
				set key=$piece(temp,":",1)
				if key="pid" {
					set val=$e(temp,$find(temp,":")-1,*)
				} else {
					set val=$piece(temp,":",2)
				}
				set people(people,key)=val
				set people(people,"values")=$i(people(people,"values"))
			}
		}
		
		set pos=$o(pInput(pos),1,l)
	}

	for i=1:1:people {
		set valid=1
		if '($d(people(i,"byr"))) || '(($g(people(i,"byr"))>=1920) && ($g(people(i,"byr"))<=2002)) {
			set valid=0
		}
		if '($d(people(i,"iyr"))) || '(($g(people(i,"iyr"))>=2010) && ($g(people(i,"iyr"))<=2020)) {
			set valid=0
		}
		if '($d(people(i,"eyr"))) || '(($g(people(i,"eyr"))>=2020) && ($g(people(i,"eyr"))<=2030)) {
			set valid=0
		}
		if '($d(people(i,"hgt"))) {
			set valid=0
		} else {
			if $e(people(i,"hgt"),*-1,*)="cm" {
				if (+people(i,"hgt")<150) || (+people(i,"hgt")>193) {
					set valid=0
				}
			} elseif $e(people(i,"hgt"),*-1,*)="in" {
				if (+people(i,"hgt")<59) || (+people(i,"hgt")>76) {
					set valid=0
				}
			} else {
				set valid=0
			}
		}
		if '($d(people(i,"hcl"))) {
			set valid=0
		} else {
			if $length(people(i,"hcl"))'=7 {
				set valid=0
			}
			if $zstrip(people(i,"hcl"),"*","0123456789abcdef")'="#" {
				set valid=0
			}
		}
		if '($d(people(i,"ecl"))) || '(($g(people(i,"ecl"))="amb") ||($g(people(i,"ecl"))="gry") ||($g(people(i,"ecl"))="blu") ||($g(people(i,"ecl"))="brn") ||($g(people(i,"ecl"))="grn") ||($g(people(i,"ecl"))="hzl") ||($g(people(i,"ecl"))="oth")) {
			set valid=0
		}
		if '($d(people(i,"pid"))) {
			set valid=0
		} else {
			if $length(people(i,"pid"))'=10 {
				set valid=0
			} elseif $zstrip(people(i,"pid"),"*N")'=":" {
				set valid=0
			}
		}

		set:valid res=$i(res)
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2020.Day4).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2020.Day4).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
