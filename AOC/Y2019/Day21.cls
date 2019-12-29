Class AOC.Y2019.Day21 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 21;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day21).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	set maxlen=0
	while pos'="" {
		set maxlen=$l(l,",")
		for i=0:1:$l(l,",")-1 {
			set instructions(i)=$p(l,",",i+1)
		}
		set pos=$o(pInput(pos),1,l)
	}
	
	
	
	set pos=-1
	set relativebase=0
	//set ss="NOT D J,WALK,"
	//set ss="NOT A J,NOT B T,AND T J,NOT C T,AND T J,AND D J,WALK,"
	// if 2 tiles away is empty and 4 tiles away is safe, jump
	// if 3 tiles away is empty and 4 tiles away is safe, jump
	// if (1 tile away is empty)||(2 tiles away is empty and 4 tiles away is safe)||(3 tiles away is empty and 4 tiles away is safe) = jump
	set ss="NOT A J,"
	set ss=ss_"NOT B T,AND D T,"
	set ss=ss_"OR T J,"
	set ss=ss_"NOT C T,AND D T,"
	set ss=ss_"OR T J,"
	set ss=ss_"WALK,"
	
	for i=1:1:$length(ss) {
		set tempchar=$e(ss,i)
		if tempchar="," {
			set inputvals($i(inputvals))=10
		} else {
			set inputvals($i(inputvals))=$ascii(tempchar)
		}	
	}
	
	while 1 {
		set inst=instructions($i(pos))
		quit:inst=99
		set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
		set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
		set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
		set inst=inst#100
		// ??? inst=4
		zw:pDebug inst
		zw:pDebug mode1
		zw:pDebug relativebase
		zw:pDebug pos
		if mode1=2 {
			set offset=0
			set offset=relativebase
			if (inst=3) {
				set val1=$g(instructions($i(pos)),0)+offset
			} else {
				set val1=$g(instructions($g(instructions($i(pos)),0)+offset),0)
			}	
		} elseif ((mode1) || (inst=3) || (inst=4)) {
			set val1=$g(instructions($i(pos)),0)
		} else {
			set val1=$g(instructions($g(instructions($i(pos)))),0)
		}
		zw:pDebug val1
		if ((inst=1) || (inst=2) || (inst=5) || (inst=6) || (inst=7) || (inst=8)) {
			if mode2=2 {
				set offset=0
				set offset=relativebase
				set val2=$g(instructions($g(instructions($i(pos)),0)+offset),0)
			} elseif mode2 {
				set val2=$g(instructions($i(pos)),0)
			} else {
				set val2=$g(instructions($g(instructions($i(pos)),0)),0)
			}
			zw:pDebug val2
			if ((inst=1) || (inst=2) || (inst=7) || (inst=8)) {
				if mode3=2 {
					set offset=0
					set offset=relativebase
					set storeloc=$g(instructions($i(pos)),0)+offset
				} elseif (mode3) {
					set storeloc=$g(instructions($i(pos)),0)
				} else {
					// ???
					set storeloc=$g(instructions($i(pos)),0)
				}
				zw:pDebug storeloc
			}
		}
		if inst=1 {
			set instructions(storeloc)=val1+val2
		} elseif inst=2 {
			set instructions(storeloc)=val1*val2
		} elseif inst=3 {
			set tempval=inputvals($i(inputpos))
			set instructions(val1)=tempval
			set res=res_","_tempval
		} elseif inst=4 {
			if mode1 {
				set res=res_","_val1
			} else {
				set res=res_","_instructions(val1)
			}
			w:pDebug res,!
		} elseif inst=5 {
			if val1'=0 {
				set pos=val2-1
			}
		} elseif inst=6 {
			if val1=0 {
				set pos=val2-1
			}
		} elseif inst=7 {
			if val1<val2 {
				set instructions(storeloc)=1
			} else {
				set instructions(storeloc)=0
			}
		} elseif inst=8 {
			if val1=val2 {
				set instructions(storeloc)=1
			} else {
				set instructions(storeloc)=0
			}
		} elseif inst=9 {
			set relativebase=relativebase+val1
		}
	}
	
	set res=$e(res,2,*)
	set res=$lfs(res)
	for i=1:1:$ll(res) {
		set tempval=$lg(res,i)
		w:pDebug $char(tempval)
		w:pDebug&&(tempval=10) $char(13)
	}
	
	zw:pDebug res
	quit $lg(res,*)
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day21).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	set maxlen=0
	while pos'="" {
		set maxlen=$l(l,",")
		for i=0:1:$l(l,",")-1 {
			set instructions(i)=$p(l,",",i+1)
		}
		set pos=$o(pInput(pos),1,l)
	}
	
	
	
	set pos=-1
	set relativebase=0
	
	// A=1,B=2,C=3,D=4,E=5,F=6,G=7,H=8,i=9
	// if (2, 5, or 9 is empty) AND (4 AND 8 are free) AND (next 3 are not free)
	set ss="NOT B J,"
	set ss=ss_"NOT E T,"
	set ss=ss_"OR T J,"
	set ss=ss_"NOT I T,"
	set ss=ss_"OR T J,"
	
	set ss=ss_"AND D J,"
	set ss=ss_"AND H J,"
	
	set ss=ss_"NOT A T,"
	set ss=ss_"NOT T T,"
	set ss=ss_"AND B T,"
	set ss=ss_"AND C T,"
	set ss=ss_"NOT T T,"
	set ss=ss_"AND T J,"
	
	set ss=ss_"NOT A T,"
	set ss=ss_"OR T J,"
	set ss=ss_"RUN,"
	
	for i=1:1:$length(ss) {
		set tempchar=$e(ss,i)
		if tempchar="," {
			set inputvals($i(inputvals))=10
		} else {
			set inputvals($i(inputvals))=$ascii(tempchar)
		}	
	}
	
	while 1 {
		set inst=instructions($i(pos))
		quit:inst=99
		set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
		set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
		set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
		set inst=inst#100
		// ??? inst=4
		zw:pDebug inst
		zw:pDebug mode1
		zw:pDebug relativebase
		zw:pDebug pos
		if mode1=2 {
			set offset=0
			set offset=relativebase
			if (inst=3) {
				set val1=$g(instructions($i(pos)),0)+offset
			} else {
				set val1=$g(instructions($g(instructions($i(pos)),0)+offset),0)
			}	
		} elseif ((mode1) || (inst=3) || (inst=4)) {
			set val1=$g(instructions($i(pos)),0)
		} else {
			set val1=$g(instructions($g(instructions($i(pos)))),0)
		}
		zw:pDebug val1
		if ((inst=1) || (inst=2) || (inst=5) || (inst=6) || (inst=7) || (inst=8)) {
			if mode2=2 {
				set offset=0
				set offset=relativebase
				set val2=$g(instructions($g(instructions($i(pos)),0)+offset),0)
			} elseif mode2 {
				set val2=$g(instructions($i(pos)),0)
			} else {
				set val2=$g(instructions($g(instructions($i(pos)),0)),0)
			}
			zw:pDebug val2
			if ((inst=1) || (inst=2) || (inst=7) || (inst=8)) {
				if mode3=2 {
					set offset=0
					set offset=relativebase
					set storeloc=$g(instructions($i(pos)),0)+offset
				} elseif (mode3) {
					set storeloc=$g(instructions($i(pos)),0)
				} else {
					// ???
					set storeloc=$g(instructions($i(pos)),0)
				}
				zw:pDebug storeloc
			}
		}
		if inst=1 {
			set instructions(storeloc)=val1+val2
		} elseif inst=2 {
			set instructions(storeloc)=val1*val2
		} elseif inst=3 {
			set tempval=inputvals($i(inputpos))
			set instructions(val1)=tempval
			set res=res_","_tempval
		} elseif inst=4 {
			if mode1 {
				set res=res_","_val1
			} else {
				set res=res_","_instructions(val1)
			}
			w:pDebug res,!
		} elseif inst=5 {
			if val1'=0 {
				set pos=val2-1
			}
		} elseif inst=6 {
			if val1=0 {
				set pos=val2-1
			}
		} elseif inst=7 {
			if val1<val2 {
				set instructions(storeloc)=1
			} else {
				set instructions(storeloc)=0
			}
		} elseif inst=8 {
			if val1=val2 {
				set instructions(storeloc)=1
			} else {
				set instructions(storeloc)=0
			}
		} elseif inst=9 {
			set relativebase=relativebase+val1
		}
	}
	
	set res=$e(res,2,*)
	set res=$lfs(res)
	for i=1:1:$ll(res) {
		set tempval=$lg(res,i)
		w:pDebug $char(tempval)
		w:pDebug&&(tempval=10) $char(13)
	}
	
	zw:pDebug res
	quit $lg(res,*)
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day21).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day21).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
