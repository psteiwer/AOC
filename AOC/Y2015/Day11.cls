Class AOC.Y2015.Day11 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 11;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	set l=pInput
	set:l="" l="cqjxjnds"
	
	set res=""
	
	while res="" {
		set pos=$Length(l)
		while pos'="" {
			set char=$e(l,pos)
			set char=$ascii(char)
			set char=$i(char)
			if char>122 {
				set char=97
				set l=$e(l,1,pos-1)_$char(char)_$e(l,pos+1,*)
				set pos=pos-1
			} else {
				set l=$e(l,1,pos-1)_$char(char)_$e(l,pos+1,*)
				set pos=""
			}
		}
		set hasstraight=0
		set doublecount=0
		set containsbad=0
		set lastdouble=0
		set hasbad=0
		for i=1:1:$length(l) {
			if (($ascii($e(l,i))+1=$ascii($e(l,i+1)))&&($ascii($e(l,i))+2=$ascii($e(l,i+2)))) {
				set hasstraight=1
			}
			if (($ascii($e(l,i))=$ascii($e(l,i+1)))&&(lastdouble<i)) {
				set doublecount=$i(doublecount)
				set lastdouble=i+1
			}
			if (($ascii($e(l,i))="i")||($ascii($e(l,i))="o")||($ascii($e(l,i))="l")) {
				set hasbad=1
			}
		}
		if hasstraight&&(doublecount>1)&&'hasbad {
			set res=l
		}
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	set l=pInput
	set:l="" l="cqjxxyzz"
	
	set res=""
	
	while res="" {
		set pos=$Length(l)
		while pos'="" {
			set char=$e(l,pos)
			set char=$ascii(char)
			set char=$i(char)
			if char>122 {
				set char=97
				set l=$e(l,1,pos-1)_$char(char)_$e(l,pos+1,*)
				set pos=pos-1
			} else {
				set l=$e(l,1,pos-1)_$char(char)_$e(l,pos+1,*)
				set pos=""
			}
		}
		set hasstraight=0
		set doublecount=0
		set containsbad=0
		set lastdouble=0
		set hasbad=0
		for i=1:1:$length(l) {
			if (($ascii($e(l,i))+1=$ascii($e(l,i+1)))&&($ascii($e(l,i))+2=$ascii($e(l,i+2)))) {
				set hasstraight=1
			}
			if (($ascii($e(l,i))=$ascii($e(l,i+1)))&&(lastdouble<i)) {
				set doublecount=$i(doublecount)
				set lastdouble=i+1
			}
			if (($ascii($e(l,i))="i")||($ascii($e(l,i))="o")||($ascii($e(l,i))="l")) {
				set hasbad=1
			}
		}
		if hasstraight&&(doublecount>1)&&'hasbad {
			set res=l
		}
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day11).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day11).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
