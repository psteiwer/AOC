Class AOC.Y2019.Day17 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 17;

Parameter Year = 2019;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day17).GetInput(..#Day,.pInput)
	
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
	set inputval=2
	set relativebase=0
	set map=0
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
			set instructions(val1)=inputval
		} elseif inst=4 {
			if mode1 {
				set res=val1
			} else {
				set res=instructions(val1)
			}
			if res=10 {
				set map=$i(map)
			} else {
				set map(map,$i(map(map))-1)=$char(res)
			}
			//w res,!
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
	
	set res=0
	for r=0:1:map-2 {
		for c=0:1:$o(map(r,""),-1) {
			if map(r,c)="#" {
				set intersection=1
				set:$G(map(r+1,c))'="#" intersection=0
				set:$G(map(r-1,c))'="#" intersection=0
				set:$G(map(r,c+1))'="#" intersection=0
				set:$G(map(r,c-1))'="#" intersection=0
				if intersection {
					set res=res+(c*r)
				}
			}
		}
	}
	
	do:pWithUI ##class(AOC.Y2019.Day17).Print2DArray(.map)
	
	quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day17).GetInput(..#Day,.pInput)
	
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
	
	set firstinput=1
	set pos=-1
	set instructions(0)=2
	set inputval=2
	set relativebase=0
	set map=0
	while 1 {
		set inst=instructions($i(pos))
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
			if firstinput {
				for r=0:1:map-2 {
					for c=0:1:$o(map(r,""),-1) {
						if "^v<>"[map(r,c) {
							set botx=c
							set boty=r
							if map(r,c)="^" {
								set botdir="U"
							} elseif map(r,c)="v" {
								set botdir="D"
							} elseif map(r,c)="<" {
								set botdir="L"
							} elseif map(r,c)=">" {
								set botdir="R"
							}
							
							set firstinput=0
							quit
						}
						quit:'firstinput
					}
					quit:'firstinput
				}
				
				set move=0
				set done=0
				while 'done {
					if botdir="U" {
						if $G(map(boty-1,botx))="#" {
							set move(move,"count")=$i(move(move,"count"))
						} elseif $G(map(boty,botx-1))="#" {
							set move($i(move),"dir")="L"
							set move(move,"count")=1
							set botdir="L"
						} elseif $G(map(boty,botx+1))="#" {
							set move($i(move),"dir")="R"
							set move(move,"count")=1
							set botdir="R"
						} else {
							set done=1
						}
					} elseif botdir="D" {
						if $G(map(boty+1,botx))="#" {
							set move(move,"count")=$i(move(move,"count"))
						} elseif $G(map(boty,botx-1))="#" {
							set move($i(move),"dir")="R"
							set move(move,"count")=1
							set botdir="L"
						} elseif $G(map(boty,botx+1))="#" {
							set move($i(move),"dir")="L"
							set move(move,"count")=1
							set botdir="R"
						} else {
							set done=1
						}
					} elseif botdir="R" {
						if $G(map(boty,botx+1))="#" {
							set move(move,"count")=$i(move(move,"count"))
						} elseif $G(map(boty-1,botx))="#" {
							set move($i(move),"dir")="L"
							set move(move,"count")=1
							set botdir="U"
						} elseif $G(map(boty+1,botx))="#" {
							set move($i(move),"dir")="R"
							set move(move,"count")=1
							set botdir="D"
						} else {
							set done=1
						}
					} elseif botdir="L" {
						if $G(map(boty,botx-1))="#" {
							set move(move,"count")=$i(move(move,"count"))
						} elseif $G(map(boty+1,botx))="#" {
							set move($i(move),"dir")="L"
							set move(move,"count")=1
							set botdir="D"
						} elseif $G(map(boty-1,botx))="#" {
							set move($i(move),"dir")="R"
							set move(move,"count")=1
							set botdir="U"
						} else {
							set done=1
						}
					}
					
					//update bot position
					if botdir="U" {
						set boty=boty-1
					} elseif botdir="D" {
						set boty=boty+1
					} elseif botdir="L" {
						set botx=botx-1
					} elseif botdir="R" {
						set botx=botx+1
					}
				}
				
				zw:pDebug move
				set path=""
				for i=1:1:move {
					set path=path_$select(path'="":",",1:"")_move(i,"dir")_","_move(i,"count")
				}
				zw:pDebug path
				
				// rank path groupings
				for i=1:1:move {
					for j=i+1:1:$select(move<(i+5):move,1:i+5) {
						set templen=0
						set temppath=""
						for k=i:1:j {
							set tempval=move(k,"dir")_","_move(k,"count")
							set temppath=temppath_$select(temppath="":"",1:",")_tempval
						}
						if $length(temppath)<=20 {
							set rank(temppath)=$i(rank(temppath))
						}
					}
				}
				
				k inputvals
				set validgroup=0
				set group1=$o(rank(""))
				while group1'="" {
					set group2=$o(rank(group1))
					while group2'="" {
						set group3=$o(rank(group2))
						while group3'="" {
							set temppath=path
							set temppath=$replace(temppath,group1,"A")
							set temppath=$replace(temppath,group2,"B")
							set temppath=$replace(temppath,group3,"C")
							zw:pDebug temppath
							set validgroup=1
							if ((temppath["L")||(temppath["R")) {
								set validgroup=0
							}
							if $length(temppath)>20 {
								set validgroup=0
							}
							if validgroup {
								for i=1:1:$length(temppath) {
									set inputvals($i(inputvals))=$ascii($e(temppath,i))
								}
								set inputvals($i(inputvals))=10
								for i=1:1:$length(group1) {
									set inputvals($i(inputvals))=$ascii($e(group1,i))
								}
								set inputvals($i(inputvals))=10
								for i=1:1:$length(group2) {
									set inputvals($i(inputvals))=$ascii($e(group2,i))
								}
								set inputvals($i(inputvals))=10
								for i=1:1:$length(group3) {
									set inputvals($i(inputvals))=$ascii($e(group3,i))
								}
								set inputvals($i(inputvals))=10
								set inputvals($i(inputvals))=10
								set inputvals($i(inputvals))=$ascii("n")
								set inputvals($i(inputvals))=10
							}
							quit:validgroup
							set group3=$o(rank(group3))
						}
						quit:validgroup
						set group2=$o(rank(group2))
					}
					quit:validgroup
					set group1=$o(rank(group1))
				}
			}
			set instructions(val1)=inputvals($i(inputposition))
		} elseif inst=4 {
			if mode1 {
				set res=val1
			} else {
				set res=instructions(val1)
			}
			
			if res=10 {
				set map=$i(map)
			} else {
				set map(map,$i(map(map))-1)=$char(res)
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
	
	do:pWithUI ##class(AOC.Y2019.Day17).Print2DArray(.map)
	
	quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day17).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day17).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
