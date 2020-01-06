Class AOC.Y2019.Day13 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 13;

Parameter Year = 2019;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set intcode=##class(AOC.Y2019.Utils.Intcode).%New(13)
	set tSC=intcode.Run(pDebug)
	set temp=intcode.GetOutput()
	while temp'="" {
		set temp=intcode.GetOutput()
		set temp=intcode.GetOutput()
		if temp=2 {
			set res=$i(res)
		}
		set temp=intcode.GetOutput()
	}
	quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set intcode=##class(AOC.Y2019.Utils.Intcode).%New(13)
	do intcode.SetInstruction(2,0)
	do intcode.AddInput(0)
	set tSC=intcode.Run(pDebug,1)
	set tempx=intcode.GetOutput()
	set paddlex=0
	set ballx=0
	while tempx'="" {
		set tSC=intcode.Run(pDebug,1)
		set tempy=intcode.GetOutput()
		set tSC=intcode.Run(pDebug,1)
		set tempid=intcode.GetOutput()
		if tempx=-1 {
			set res=tempid
		}
		if tempid=3 {
			set paddlex=tempx
		} elseif tempid=4 {
			set ballx=tempx
		}
		set map(tempy,tempx)=tempid
		do:pWithUI ##class(AOC.Y2019.Day13).Print2DArray(.map)
		
		do intcode.GetInput()
		if paddlex>ballx {
			do intcode.AddInput(-1)
		} elseif paddlex<ballx {
			do intcode.AddInput(1)
		} else {
			do intcode.AddInput(0)
		}
		set tSC=intcode.Run(pDebug,1)
		set tempx=intcode.GetOutput()
	}
	
	quit res
}

// Keeping this version for now since it has better UI display

ClassMethod Part2Old(input = "", withui = 0, debug = 0) As %String
{
	if input="" {
		do ##class(AOC.Y2019.Day13).GetInput(13,.input)
	}
	
	set res=""
	set pos=$o(input(""),1,l)
	set maxlen=0
	while pos'="" {
		set maxlen=$l(l,",")
		for i=0:1:$l(l,",")-1 {
			set instructions(i)=$p(l,",",i+1)
		}
		set pos=$o(input(pos),1,l)
	}
	
	set res=""
	set instructions(0)=2
	set inputval=0
	set pos=-1
	set relativebase=0
	while 1 {
		set inst=instructions($i(pos))
		quit:inst=99
		set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
		set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
		set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
		set inst=inst#100
		// ??? inst=4
		zw:debug inst
		zw:debug mode1
		zw:debug relativebase
		zw:debug pos
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
		zw:debug val1
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
			zw:debug val2
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
				zw:debug storeloc
			}
		}
		if inst=1 {
			set instructions(storeloc)=val1+val2
		} elseif inst=2 {
			set instructions(storeloc)=val1*val2
		} elseif inst=3 {
			set instructions(val1)=inputval
		} elseif inst=4 {
			if mode1 {
				set res=res_","_val1
			} else {
				set res=res_","_instructions(val1)
			}
			if ($length(res,",")#3)=1 {
				if $p(res,",",*)=3 {
					set paddle=$p(res,",",*-2)
				} elseif $p(res,",",*)=4 {
					set ball=$p(res,",",*-2)
				}
			}
			
			if $g(ball)<$g(paddle) {
				set inputval=-1
			} elseif $g(ball)>$g(paddle) {
				set inputval=1
			} else {
				set inputval=0
			}
			
			// UI
			if withui {
				if ($length(res,",")#3)=1 {
					set array($p(res,",",*-2),$p(res,",",*-1))=$p(res,",",*)
					if ($length(res,",")>2800)&&(($p(res,",",*)=4)||($p(res,",",*)=3)) {
						w #
						for row=0:1:23 {
							for col=0:1:40 {
								if $g(array(col,row)) {
									w $case($g(array(col,row)),1:"x",2:"#",3:"_",4:"o")
								} else {
									w " "
								}
							}
							w:row'=23 !
						}
						h .025
					}
				}
			}
			
			w:debug res,!
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
	
	if withui {
		set array($p(res,",",*-2),$p(res,",",*-1))=$p(res,",",*)
		w #
		for row=0:1:23 {
			for col=0:1:40 {
				if $g(array(col,row)) {
					w $case($g(array(col,row)),1:"x",2:"#",3:"_",4:"o")
				} else {
					w " "
				}
			}
			w !
		}
		w "SCORE: "
	}
	
	quit $p(res,",",*)
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day13).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day13).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
