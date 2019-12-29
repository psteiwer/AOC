Class AOC.Y2019.Day19 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 19;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day19).GetInput(..#Day,.pInput)
	
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
	set pos=-1
	set relativebase=0
	set inputpos=0
	
	for i=0:1:49 {
		for j=0:1:49 {
			set inputvals($i(inputvals))=j
			set inputvals($i(inputvals))=i
		}
	}
	
	while inputpos<inputvals {
		k instructions
		merge instructions=originalinstructions
		set relativebase=0
		set pos=-1
		while 1 {
			k inst
			k mode1
			k mode2
			k mode3
			k val1
			k val2
			k storeloc
			set inst=instructions($i(pos))
			quit:inst=99
			set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
			set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
			set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
			set inst=inst#100
			zw:pDebug inst
			zw:pDebug mode1
			zw:pDebug mode2
			zw:pDebug mode3
			zw:pDebug relativebase
			zw:pDebug pos
			if inst=3 {
				set val1=$g(instructions($i(pos)),0)
				set:mode1=2 val1=val1+relativebase
			} else {
				if mode1=0 {
					set val1=$g(instructions($g(instructions($i(pos)),0)),0)
				} elseif mode1=1 {
					set val1=$g(instructions($i(pos)),0)
				} elseif mode1=2 {
					set val1=$g(instructions($g(instructions($i(pos)),0)+relativebase),0)
				}
			}
			zw:pDebug val1
			if ((inst=1) || (inst=2) || (inst=5) || (inst=6) || (inst=7) || (inst=8)) {
				if mode2=0 {
					set val2=$g(instructions($g(instructions($i(pos)),0)),0)
				} elseif mode2=1 {
					set val2=$g(instructions($i(pos)),0)
				} elseif mode2=2 {
					set val2=$g(instructions($g(instructions($i(pos)),0)+relativebase),0)
				}
				zw:pDebug val2
				if ((inst=1) || (inst=2) || (inst=7) || (inst=8)) {
					set storeloc=$g(instructions($i(pos)),0)
					set:mode3=2 storeloc=storeloc+relativebase
					zw:pDebug storeloc
				}
			}
			if inst=1 {
				set instructions(storeloc)=val1+val2
			} elseif inst=2 {
				set instructions(storeloc)=val1*val2
			} elseif inst=3 {
				set instructions(val1)=inputvals($i(inputpos))
			} elseif inst=4 {
				set temp=val1
				set map(inputvals(inputpos-1),inputvals(inputpos))=$case(temp,1:"#",:".")
				if temp {
					set res=res+temp
				}
				zw:pDebug res
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
	}
	
	do:pDebug ##class(AOC.Y2019).Print2DArray(.map)
	quit res
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day19).GetInput(..#Day,.pInput)
	
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
	set pos=-1
	set relativebase=0
	set inputpos=0
	
	set posx=0
	set posy=0
	set count=-1
	set nextcount=0
	
	while 1{
		set count=count+1
		if count=nextcount {
			set lenx=100
			set leny=100
			if count=0 {
				for i=0:1:99 {
					for j=0=1:1:99 {
						set inputvals($i(inputvals))=posy+i
						set inputvals($i(inputvals))=posx+j
					}
				}
				set nextcount=nextcount+((leny)*(lenx))
			} else {
				set somey=0
				set ally=1
				for i=posy+leny:-1:posy {
					if $G(map(i,posx+lenx-1))="#" {
						set somey=1
					} else {
						set ally=0
					}
				}
				set somex=0
				set allx=1
				for i=posx+lenx:-1:posx {
					if $G(map(posy+leny-1,i))="#" {
						set somex=1
					} else {
						set allx=0
					}
				}
				
				// compare all positions to position x+100 and y+100
				if $d(map) {
					set minY=$o(map(""))
					set maxY=$o(map(""),-1)
					set minX=$o(map(minY,""))
					set maxX=$o(map(maxY,""),-1)
					k valuecount
					for row=minY:1:maxY {
						for col=minX:1:maxX {
							if $G(map(row,col))="#" {
								if (($G(map(row+99,col))="#")&&($G(map(row,col+99))="#")) {
									return (row*10000)+col
								}
							}
						}
					}
				}
				
				if somex {
					// do next 100 y values
					set posy=posy+leny
					for i=posy:1:posy+leny-1 {
						for j=posx:1:posx+lenx-1 {
							set inputvals($i(inputvals))=i
							set inputvals($i(inputvals))=j
						}
					}
					set nextcount=nextcount+((leny)*(lenx))
				}
				if somey {
					// do next 100 x values
					set posx=posx+lenx
					for i=posy:1:posy+leny-1 {
						for j=posx:1:posx+lenx-1 {
							set inputvals($i(inputvals))=i
							set inputvals($i(inputvals))=j
						}
					}
					set nextcount=nextcount+((leny)*(lenx))
				}
				if somex&&somey {
					set posy=posy-leny
					for i=posy:1:posy+leny-1 {
						for j=posx:1:posx+lenx-1 {
							set inputvals($i(inputvals))=i
							set inputvals($i(inputvals))=j
						}
					}
					set posy=posy+leny
					set nextcount=nextcount+((leny)*(lenx))
				}
			}
			
			zw:pDebug count
			zw:pDebug nextcount
			//break
		}	
		k instructions
		merge instructions=originalinstructions
		set relativebase=0
		set pos=-1
		while 1 {
			k inst
			k mode1
			k mode2
			k mode3
			k val1
			k val2
			k storeloc
			set inst=instructions($i(pos))
			quit:inst=99
			set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
			set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
			set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
			set inst=inst#100
			zw:pDebug inst
			zw:pDebug mode1
			zw:pDebug mode2
			zw:pDebug mode3
			zw:pDebug relativebase
			zw:pDebug pos
			if inst=3 {
				set val1=$g(instructions($i(pos)),0)
				set:mode1=2 val1=val1+relativebase
			} else {
				if mode1=0 {
					set val1=$g(instructions($g(instructions($i(pos)),0)),0)
				} elseif mode1=1 {
					set val1=$g(instructions($i(pos)),0)
				} elseif mode1=2 {
					set val1=$g(instructions($g(instructions($i(pos)),0)+relativebase),0)
				}
			}
			zw:pDebug val1
			if ((inst=1) || (inst=2) || (inst=5) || (inst=6) || (inst=7) || (inst=8)) {
				if mode2=0 {
					set val2=$g(instructions($g(instructions($i(pos)),0)),0)
				} elseif mode2=1 {
					set val2=$g(instructions($i(pos)),0)
				} elseif mode2=2 {
					set val2=$g(instructions($g(instructions($i(pos)),0)+relativebase),0)
				}
				zw:pDebug val2
				if ((inst=1) || (inst=2) || (inst=7) || (inst=8)) {
					set storeloc=$g(instructions($i(pos)),0)
					set:mode3=2 storeloc=storeloc+relativebase
					zw:pDebug storeloc
				}
			}
			if inst=1 {
				set instructions(storeloc)=val1+val2
			} elseif inst=2 {
				set instructions(storeloc)=val1*val2
			} elseif inst=3 {
				set instructions(val1)=inputvals($i(inputpos))
			} elseif inst=4 {
				set temp=val1
				set map(inputvals(inputpos-1),inputvals(inputpos))=$case(temp,1:"#",:".")
				if temp {
					set res=res+temp
				}
				zw:pDebug res
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
	}
	quit res
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day19).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day19).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
