Class AOC.Y2019.Day15 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 15;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day15).GetInput(..#Day,.pInput)
	
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
	set inputval=3
	set relativebase=0
	set posx=0
	set posy=0
	set counter=0
	set backtrack=0
	set done=0
	set path=""
	set map(posy,posx)=1
	
	while 'done {
		set inst=instructions($i(pos))
		w:inst=99 "INST 99 reached",!
		quit:inst=99
		set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
		set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
		set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
		set inst=inst#100
		// ??? inst=4
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
			set instructions(val1)=inputval
		} elseif inst=4 {
			if mode1 {
				set res=val1
			} else {
				set res=instructions(val1)
			}
			zw:pDebug res
			zw:pDebug inputval
			set oldinputval=inputval
			w:pWithUI #
			do:pWithUI ##class(AOC.Y2019).Print2DArray(.map,1,posx,posy)
			k newx
			k newy
			zw:pDebug posx
			zw:pDebug posy
			if inputval=1 {
				set newy=posy-1
			} elseif inputval=2 {
				set newy=posy+1
			} elseif inputval=3 {
				set newx=posx-1
			} elseif inputval=4 {
				set newx=posx+1
			}
			set:'$D(map($g(newy,posy),$g(newx,posx))) map($g(newy,posy),$g(newx,posx))=res
			
			if res=0 {
				w:pDebug "move "_$case(oldinputval,1:"U",4:"R",2:"D",3:"L",:"invalid")_" blocked",!
			} elseif res=1 {
				w:pDebug "moved "_$case(oldinputval,1:"U",4:"R",2:"D",3:"L",:"invalid"),!
				set:'backtrack path=path_oldinputval
				set backtrack=0
				set posx=$g(newx,posx)
				set posy=$g(newy,posy)
			} elseif res=2 {
				w:pDebug "OUTPUT WAS 2",!
				set posx=$g(newx,posx)
				set posy=$g(newy,posy)
				set oxygenx=posx
				set oxygeny=posy
				set done=1
				quit
			}
			
			// figure out next move
			zw:pDebug inputval
			set unknown=0
			// see if any direction is unknown
			for i=1:1:4 {
				if i=1 {
					// check up
					if '$d(map(posy-1,posx)) {
						set inputval=1
						set unknown=1
						quit
					}
				} elseif i=2 {
					// check right
					if '$d(map(posy,posx+1)) {
						set inputval=4
						set unknown=1
						quit
					}
				} elseif i=3 {
					// check down
					if '$d(map(posy+1,posx)) {
						set inputval=2
						set unknown=1
						quit
					}
				} elseif i=4 {
					// check left
					if '$d(map(posy,posx-1)) {
						set inputval=3
						set unknown=1
						quit
					}
				}
			}
			
			
			if 'unknown {
				// backtrack
				set backtrack=1
				set inputval=$e(path,*)
				if inputval=1 {
					set inputval=2
				} elseif inputval=2 {
					set inputval=1
				}elseif inputval=3 {
					set inputval=4
				}elseif inputval=4 {
					set inputval=3
				}
				set path=$e(path,0,*-1)
			}
			zw:pDebug inputval
			zw:pDebug unknown
			
			w:pDebug "NEXT MOVE WILL BE "_inputval,!
			//break
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
	
	zw:pDebug oxygenx
	zw:pDebug oxygeny
	
	zw:pDebug path
	w:pWithUI #
	do:pWithUI ##class(AOC.Y2019).Print2DArray(.map,1,oxygenx,oxygeny)
	
	quit $length(path)+1
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day15).GetInput(..#Day,.pInput)
	
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
	set inputval=3
	set relativebase=0
	set posx=0
	set posy=0
	set counter=0
	set backtrack=0
	set done=0
	set path=""
	set map(posy,posx)=1
	
	while 'done {
		set inst=instructions($i(pos))
		w:inst=99 "INST 99 reached",!
		quit:inst=99
		set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
		set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
		set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
		set inst=inst#100
		// ??? inst=4
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
			set instructions(val1)=inputval
		} elseif inst=4 {
			if mode1 {
				set res=val1
			} else {
				set res=instructions(val1)
			}
			set oldinputval=inputval
			k newx
			k newy
			if inputval=1 {
				set newy=posy-1
			} elseif inputval=2 {
				set newy=posy+1
			} elseif inputval=3 {
				set newx=posx-1
			} elseif inputval=4 {
				set newx=posx+1
			}
			set:'$D(map($g(newy,posy),$g(newx,posx))) map($g(newy,posy),$g(newx,posx))=res
			
			if res=0 {
			} elseif (res=1) {
				set:'backtrack path=path_oldinputval
				set backtrack=0
				set posx=$g(newx,posx)
				set posy=$g(newy,posy)
			} elseif res=2 {
				set:'backtrack path=path_oldinputval
				set backtrack=0
				set posx=$g(newx,posx)
				set posy=$g(newy,posy)
				set oxygenx=posx
				set oxygeny=posy
			}
			
			// figure out next move
			set unknown=0
			// see if any direction is unknown
			for i=1:1:4 {
				if i=1 {
					// check up
					if '$d(map(posy-1,posx)) {
						set inputval=1
						set unknown=1
						quit
					}
				} elseif i=2 {
					// check right
					if '$d(map(posy,posx+1)) {
						set inputval=4
						set unknown=1
						quit
					}
				} elseif i=3 {
					// check down
					if '$d(map(posy+1,posx)) {
						set inputval=2
						set unknown=1
						quit
					}
				} elseif i=4 {
					// check left
					if '$d(map(posy,posx-1)) {
						set inputval=3
						set unknown=1
						quit
					}
				}
			}
			
			
			if 'unknown {
				if $length(path)=0 {
					// whole map discovered
					set done=1
					quit
				}
				// backtrack
				set backtrack=1
				set inputval=$e(path,*)
				if inputval=1 {
					set inputval=2
				} elseif inputval=2 {
					set inputval=1
				}elseif inputval=3 {
					set inputval=4
				}elseif inputval=4 {
					set inputval=3
				}
				set path=$e(path,0,*-1)
			}
			//break
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
	
	
	set minX=99999
	set minY=99999
	set maxX=0
	set maxY=0
	set tempY=$o(map(""))
	while tempY'="" {
		set tempX=$o(map(tempY,""))
		while tempX'="" {
			set:maxX<tempX maxX=tempX
			set:maxY<tempY maxY=tempY
			set:minX>tempX minX=tempX
			set:minY>tempY minY=tempY
			
			set tempX=$o(map(tempY,tempX))
		}
		
		set tempY=$o(map(tempY))
	}
	
	set map(oxygeny,oxygenx)="O"
	w:pWithUI #
	do:pWithUI ##class(AOC.Y2019).Print2DArray(.map,"O")
	set res=""
	set done=0
	while 'done {
		set done=1
		k newmap
		merge newmap=map
		set res=$i(res)
		for row=minY:1:maxY {
			for col=minX:1:maxX {
				if $G(map(row,col))="O" {
					if $G(map(row+1,col))=1 {
						set newmap(row+1,col)="O"
						set done=0
					}
					if $G(map(row-1,col))=1 {
						set newmap(row-1,col)="O"
						set done=0
					}
					if $G(map(row,col+1))=1 {
						set newmap(row,col+1)="O"
						set done=0
					}
					if $G(map(row,col-1))=1 {
						set newmap(row,col-1)="O"
						set done=0
					}
				}
			}
		}
		k map
		merge map=newmap
		w:pWithUI #
		do:pWithUI ##class(AOC.Y2019).Print2DArray(.newmap,"O")
	}
	quit res-1
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day15).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day15).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
