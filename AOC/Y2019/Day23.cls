Class AOC.Y2019.Day23 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 23;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day23).GetInput(..#Day,.pInput)
	
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
	
	merge originalinstructions=instructions
	set inputvals=""
	for i=0:1:49 {
		set network(i,"input")=$lb(i)
		set network(i,"output","network")=""
		
		merge network(i,"instructions")=instructions
	}
	set networknum=-1
	while 1 {
		set networknum=$i(networknum)#50
		
		w:pDebug "Processing "_networknum,!
		if $d(network(networknum,"instructions"))=0 {
			merge network(networknum,"instructions")=instructions
		}
		set pos=$g(network(networknum,"pos"),-1)
		set relativebase=$g(network(networknum,"relativebase"),0)
		k instructions
		merge instructions=network(networknum,"instructions")
		
		while 1 {
			set inst=instructions($i(pos))
			quit:inst=99
			set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
			set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
			set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
			set inst=inst#100
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
				}
			}
			if inst=1 {
				set instructions(storeloc)=val1+val2
			} elseif inst=2 {
				set instructions(storeloc)=val1*val2
			} elseif inst=3 {
				set tempinput=$lg(network(networknum,"input"),1,-1)
				set instructions(val1)=tempinput
				if tempinput=-1 {
					quit
				}
				zw:pDebug network(networknum,"input")
				zw:pDebug networknum
				w:pDebug "using input "_tempinput,!
				//break
				set network(networknum,"input")=$list(network(networknum,"input"),2,*)
				w:pDebug "input is now "
				zw:pDebug network(networknum,"input")
			} elseif inst=4 {
				if mode1 {
					set res=val1
				} else {
					set res=instructions(val1)
				}
				set network(networknum,"output")=$i(network(networknum,"output"))
				if network(networknum,"output")#3=1 {
					// this is address
					set network(networknum,"output","network")=res
				} elseif network(networknum,"output")#3=0 {
					// this is y
					set network(networknum,"output","y")=res
					if network(networknum,"output","network")=255 {
						return res
					} else {
						w:pDebug "setting output",!
						zw:pDebug network(network(networknum,"output","network"),"input")
						//break
						set network(network(networknum,"output","network"),"input")=$G(network(network(networknum,"output","network"),"input"),"")_$lb(network(networknum,"output","x"),res)
						zw:pDebug network(network(networknum,"output","network"),"input")
						//break
					}
				} elseif network(networknum,"output")#3=2 {
					// this is x
					set network(networknum,"output","x")=res
				}
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
		set network(networknum,"pos")=pos
		set network(networknum,"relativebase")=relativebase
		k network(networknum,"instructions")
		merge network(networknum,"instructions")=instructions
	}
	
	quit res
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day23).GetInput(..#Day,.pInput)
	
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
	
	merge originalinstructions=instructions
	set inputvals=""
	for i=0:1:49 {
		set network(i,"input")=$lb(i)
		set network(i,"output","network")=""
		
		merge network(i,"instructions")=instructions
	}
	set networknum=-1
	set idle1=1
	set idle2=0
	set lastidley=""
	while 1 {
		if networknum=49 {
			if idle1 {
				if idle2 {
					// release output to address 0
					set network(0,"input")=network(255,"input")
					if lastidley=$lg(network(0,"input"),2) {
						return lastidley
					}
					set lastidley=$lg(network(0,"input"),2)
					set idle1=1
					set idle2=0
				} else {
					set idle2=1
				}
			} else {
				set idle2=0
			}
			set idle1=1
		}
		
		set networknum=$i(networknum)#50
		
		w:pDebug "Processing "_networknum,!
		if $d(network(networknum,"instructions"))=0 {
			merge network(networknum,"instructions")=instructions
		}
		set pos=$g(network(networknum,"pos"),-1)
		set relativebase=$g(network(networknum,"relativebase"),0)
		k instructions
		merge instructions=network(networknum,"instructions")
		
		while 1 {
			set inst=instructions($i(pos))
			quit:inst=99
			set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
			set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
			set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
			set inst=inst#100
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
				}
			}
			if inst=1 {
				set instructions(storeloc)=val1+val2
			} elseif inst=2 {
				set instructions(storeloc)=val1*val2
			} elseif inst=3 {
				set tempinput=$lg(network(networknum,"input"),1,-1)
				set instructions(val1)=tempinput
				if tempinput=-1 {
					quit
				}
				zw:pDebug network(networknum,"input")
				zw:pDebug networknum
				w:pDebug "using input "_tempinput,!
				set network(networknum,"input")=$list(network(networknum,"input"),2,*)
				w:pDebug "input is now "
				zw:pDebug network(networknum,"input")
			} elseif inst=4 {
				if mode1 {
					set res=val1
				} else {
					set res=instructions(val1)
				}
				set network(networknum,"output")=$i(network(networknum,"output"))
				if network(networknum,"output")#3=1 {
					// this is address
					set network(networknum,"output","network")=res
				} elseif network(networknum,"output")#3=0 {
					// this is y
					set network(networknum,"output","y")=res
					if network(networknum,"output","network")=255 {
						set network(network(networknum,"output","network"),"input")=$lb(network(networknum,"output","x"),res)
					} else {
						w:pDebug "setting output",!
						zw:pDebug network(network(networknum,"output","network"),"input")
						//break
						set network(network(networknum,"output","network"),"input")=$G(network(network(networknum,"output","network"),"input"),"")_$lb(network(networknum,"output","x"),res)
						zw:pDebug network(network(networknum,"output","network"),"input")
						//break
					}
				} elseif network(networknum,"output")#3=2 {
					// this is x
					set network(networknum,"output","x")=res
				}
				set idle1=0
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
		set network(networknum,"pos")=pos
		set network(networknum,"relativebase")=relativebase
		k network(networknum,"instructions")
		merge network(networknum,"instructions")=instructions
	}
	
	quit res
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day23).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day23).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
