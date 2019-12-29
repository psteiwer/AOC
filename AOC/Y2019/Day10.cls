Class AOC.Y2019.Day10 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 10;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day10).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		
		for i=0:1:$length(l)-1 {
			if $e(l,i+1)="#" {
				set map(pos-1,i)=$e(l,i+1)
			}	
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	set max=0
	set maxX=0
	set maxY=0
	set y=$o(map(""))
	while y'="" {
		set x=$o(map(y,""))
		while x'="" {
			k temp
			set temp=0
			set tempy=$o(map(""))
			while tempy'="" {
				set tempx=$o(map(tempy,""))
				while tempx'="" {
					if tempx=x {
						if tempy=y {
						} elseif tempy<y {
							set slope="up"
						} elseif tempy>y {
							set slope="down"
						}
					} elseif tempy=y {
						if tempx<x {
							set slope="right"
						} elseif tempx>x {
							set slope="left"
						}
					} else {
						set dy=tempy-y
						set dx=tempx-x
						set slope=dy/dx
						if tempx>x {
							set slope="R"_slope
						} else {
							set slope="L"_slope
						}
					}
					
					if (($g(slope)'="") && ('$d(temp(slope)))) {
						set temp=$i(temp)
						set temp(slope)=1
					}
					set tempx=$o(map(tempy,tempx))
				}
				set tempy=$o(map(tempy))
			}
			
			if max<temp {
				set max=temp
				set maxX=x
				set maxY=y
			}
			
			set x=$o(map(y,x))
		}
		set y=$o(map(y))
	}
	
	zw:pDebug max
	zw:pDebug maxX
	zw:pDebug maxY
	
	quit max
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day10).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		
		for i=0:1:$length(l)-1 {
			if $e(l,i+1)="#" {
				set map(pos-1,i)=$e(l,i+1)
			}	
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	set vapcount=0
	set max=0
	set maxX=0
	set maxY=0
	
	while vapcount<200 {
		if vapcount=0 {
			set y=$o(map(""))
		} else {
			set y=maxY
		}
		while y'="" {
			if vapcount=0 {
				set x=$o(map(y,""))
			} else {
				set x=maxX
			}
			while x'="" {
				k temp
				set temp=0
				set tempy=$o(map(""))
				while tempy'="" {
					set tempx=$o(map(tempy,""))
					while tempx'="" {
						if tempx=x {
							if tempy=y {
								k slope
							} elseif tempy<y {
								set slope="a"
							} elseif tempy>y {
								set slope="g"
							}
						} elseif tempy=y {
							if tempx<x {
								set slope="e"
							} elseif tempx>x {
								set slope="c"
							}
						} else {
							set dy=tempy-y
							set dx=tempx-x
							set slope=dy/dx
							if tempx>x {
								if tempy<y {
									set slope="b,"_slope
								} else {
									set slope="d,"_slope
								}
							} else {
								if tempy<y {
									set slope="h,"_slope
								} else {
									set slope="f,"_slope
								}
							}
						}
						
						if ($g(slope)'="") {
							if $l(slope,",")>1 {
								if '$d(temp($p(slope,",",1),$p(slope,",",2))) {
									set temp=$i(temp)
									set temp($p(slope,",",1),$p(slope,",",2))=$lb(tempx,tempy)
								} else {
									set olddistance=($zabs($lg(temp($p(slope,",",1),$p(slope,",",2)),2)-y)+$zabs($lg(temp($p(slope,",",1),$p(slope,",",2)),1)-x))
									set newdistance=($zabs(tempy-y)+$zabs(tempx-x))
									if newdistance<olddistance {
										set temp($p(slope,",",1),$p(slope,",",2))=$lb(tempx,tempy)
									}
								}
							} else {
								if '$d(temp(slope)) {
									set temp=$i(temp)
									set temp(slope)=$lb(tempx,tempy)
								} else {
									set olddistance=($zabs($lg(temp(slope),2)-y)+$zabs($lg(temp(slope),1)-x))
									set newdistance=($zabs(tempy-y)+$zabs(tempx-x))
									if newdistance<olddistance {
										set temp(slope)=$lb(tempx,tempy)
									}
								}
							}
						}
						set tempx=$o(map(tempy,tempx))
					}
					set tempy=$o(map(tempy))
				}
				
				if max<temp {
					k max
					merge max=temp
					set maxX=x
					set maxY=y
				}
				quit:vapcount'=0
				set x=$o(map(y,x))
			}
			quit:vapcount'=0
			set y=$o(map(y))
		}
		
		zw:pDebug max
		
		set vap1=$o(max(""))
		while vap1'="" {
			set vap2=$o(max(vap1,""))
			if $d(max(vap1))=1 {
				set tempx=$lg(max(vap1),1)
				set tempy=$lg(max(vap1),2)
				k map(tempy,tempx)
				set vapcount=$i(vapcount)
				zw:pDebug vap1
				w:pDebug "vaporize #"_vapcount_" "_tempx_","_tempy,!
				if vapcount=200 {
					set res=(tempx*100)+tempy
					quit
				}
				set vap2=$o(max(vap1,vap2))
			}
			while vap2'="" {
				set tempx=$lg(max(vap1,vap2),1)
				set tempy=$lg(max(vap1,vap2),2)
				k map(tempy,tempx)
				set vapcount=$i(vapcount)
				zw:pDebug vap1
				zw:pDebug vap2
				w:pDebug "vaporize #"_vapcount_" "_tempx_","_tempy,!
				if vapcount=200 {
					set res=(tempx*100)+tempy
					quit
				}
				set vap2=$o(max(vap1,vap2))
			}
			quit:vapcount=200
			set vap1=$o(max(vap1))
		}
	}
	
	quit res
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day10).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day10).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
