Class AOC.Y2019.Day25 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 25;

Parameter Year = 2019;


//ANSWER:
//- boulder
//- fixed point
//- polygon
//- manifold
ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day25).GetInput(..#Day,.pInput)
	
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
	set inputval=""
	set currentstring=""
	set relativebase=0
	set posy=0
	set posx=0
	
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
			if inputval="" {
				read inputval,!
				//zw inputval
				set tempinputval=""
				for i=1:1:$length(inputval) {
					set tempinputval=tempinputval_$ascii($e(inputval,i))_","
				}
				set tempinputval=tempinputval_"10"
				//zw tempinputval
				set inputval=tempinputval
				if inputval="110,111,114,116,104,10" {
					set map(posy,posx)="."
					set posy=posy-1
					set map(posy,posx)="@"
				} elseif inputval="115,111,117,116,104,10" {
					set map(posy,posx)="."
					set posy=posy+1
					set map(posy,posx)="@"
				} elseif inputval="101,97,115,116,10" {
					set map(posy,posx)="."
					set posx=posx+1
					set map(posy,posx)="@"
				} elseif inputval="119,101,115,116,10" {
					set map(posy,posx)="."
					set posx=posx-1
					set map(posy,posx)="@"
				}
			}
			//w "USING INPUT: "_$piece(inputval,",",1),!
			set instructions(val1)=$piece(inputval,",",1)
			set inputval=$piece(inputval,",",2,*)
		} elseif inst=4 {
			if mode1 {
				set res=val1
			} else {
				set res=instructions(val1)
			}
			if res'=10 {
				set currentstring=currentstring_$char(res)
			} else {
				if $G(posoptions,0)&&(currentstring="") {
					set posoptions=0
					//do ##class(AOC.Y2019).Print2DArray(.map,,posx,posy)
				}
			
			
				if currentstring="Doors here lead:" {
					set posoptions=1
				}
				
				set laststring=currentstring
				set currentstring=""
			}
			w $char(res)
			w:res=10 $char(13)
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
	
	quit res
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day25).Part1(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	
	Quit tPart1
}

}
