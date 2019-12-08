Class AOC.Y2019 Extends AOC.Base
{

PARAMETER Year As %Integer = 2019;

ClassMethod D1P1() As %String
{
	do ##class(AOC.Y2019).GetInput(1,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		set res=res+((l\3)-2)
		set pos=$o(input(pos),1,l)
	}
	quit res
}

ClassMethod D1P2() As %String
{
	do ##class(AOC.Y2019).GetInput(1,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.temp)
		while temp>0 {
			set temp=((temp\3)-2)
			set:temp>0 res=res+temp
		} 
		set pos=$o(input(pos),1,l)
	}
	quit res
}

ClassMethod D2P1(input="") As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(2,.input)
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
	
	set instructions(1)=12
	set instructions(2)=2
	
	set pos=0
	
	while 1 {
		set inst=instructions(pos)
		set pos=(pos+1)#maxlen
		set val1=instructions(instructions(pos)#maxlen)
		set pos=(pos+1)#maxlen
		set val2=instructions(instructions(pos)#maxlen)
		set pos=(pos+1)#maxlen
		set storeloc=instructions(pos)#maxlen
		set pos=(pos+1)
		if inst=99 {
			quit
		} elseif inst=1 {
			set instructions(storeloc)=val1+val2
		} elseif inst=2 {
			set instructions(storeloc)=val1*val2
		}
	}
	
	zw instructions
	quit instructions(0)
}

ClassMethod D2P2(input="") As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(2,.input)
	}
	//zw out
	
	for x=0:1:99 {
		for y=0:1:99 {
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
			
			set instructions(1)=x
			set instructions(2)=y
			
			set pos=0
			
			while 1 {
				set inst=instructions(pos)
				set pos=(pos+1)#maxlen
				set val1=instructions(instructions(pos)#maxlen)
				set pos=(pos+1)#maxlen
				set val2=instructions(instructions(pos)#maxlen)
				set pos=(pos+1)#maxlen
				set storeloc=instructions(pos)#maxlen
				set pos=(pos+1)
				if inst=99 {
					quit
				} elseif inst=1 {
					set instructions(storeloc)=val1+val2
				} elseif inst=2 {
					set instructions(storeloc)=val1*val2
				}
			}
			
			if instructions(0)=19690720 {
				zw instructions
				w "x="_x,!
				w "y="_y,!
				w "answer="_(100*x+y),!
				quit
			}
		}
		if instructions(0)=19690720 {
			quit
		}
	}
	
	quit instructions(0)
}

ClassMethod D3P1(input) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(3,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	
	set x=0
	set y=0
	set count=0
	set grid1(x,y)=1
	for i=0:1:$length(l,",")-1 {
		set dir=$e($p(l,",",i+1),1)
		set num=$e($p(l,",",i+1),2,*)
		for j=1:1:num {
			if dir="R" {
				set x=x+1
			} elseif dir="L" {
				set x=x-1
			} elseif dir="U" {
				set y=y+1
			} elseif dir="D" {
				set y=y-1
			}
			set grid1(x,y)=1
		}
	}
	
	set pos=$o(input(pos),1,l)
	set x=0
	set y=0
	set grid2(x,y)=1
	for i=0:1:$length(l,",")-1 {
		set dir=$e($p(l,",",i+1),1)
		set num=$e($p(l,",",i+1),2,*)
		for j=1:1:num {
			if dir="R" {
				set x=x+1
			} elseif dir="L" {
				set x=x-1
			} elseif dir="U" {
				set y=y+1
			} elseif dir="D" {
				set y=y-1
			}
			set grid2(x,y)=1
		}
	}
	
	set maxdistance=999999
	
	set g1x=$order(grid1(""))
	while g1x'="" {
		set g1y=$order(grid1(g1x,""))
		while g1y'="" {
			if $d(grid1(g1x,g1y))&&$d(grid2(g1x,g1y)) {
				set temp=$zabs(g1x)+$zabs(g1y)
				if temp<maxdistance {
					set:temp'=0 maxdistance=temp
				}
			}
			set g1y=$order(grid1(g1x,g1y))
		}
		set g1x=$order(grid1(g1x))
	}
	
	quit maxdistance
}

ClassMethod D3P2(input) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(3,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	
	set x=0
	set y=0
	set count=0
	set grid1(x,y)=1
	for i=0:1:$length(l,",")-1 {
		set dir=$e($p(l,",",i+1),1)
		set num=$e($p(l,",",i+1),2,*)
		for j=1:1:num {
			if dir="R" {
				set x=x+1
			} elseif dir="L" {
				set x=x-1
			} elseif dir="U" {
				set y=y+1
			} elseif dir="D" {
				set y=y-1
			}
			set grid1(x,y)=$i(count)
		}
	}
	
	set pos=$o(input(pos),1,l)
	set x=0
	set y=0
	set count=0
	set grid2(x,y)=1
	for i=0:1:$length(l,",")-1 {
		set dir=$e($p(l,",",i+1),1)
		set num=$e($p(l,",",i+1),2,*)
		for j=1:1:num {
			if dir="R" {
				set x=x+1
			} elseif dir="L" {
				set x=x-1
			} elseif dir="U" {
				set y=y+1
			} elseif dir="D" {
				set y=y-1
			}
			set grid2(x,y)=$i(count)
		}
	}
	
	set maxsteps=999999999
	
	set g1x=$order(grid1(""))
	while g1x'="" {
		set g1y=$order(grid1(g1x,""))
		while g1y'="" {
			if $d(grid1(g1x,g1y))&&$d(grid2(g1x,g1y)) {
				set temp=grid1(g1x,g1y)+grid2(g1x,g1y)
				if temp<maxsteps {
					set:temp'=2 maxsteps=temp
				}
			}
			set g1y=$order(grid1(g1x,g1y))
		}
		set g1x=$order(grid1(g1x))
	}
	
	quit maxsteps
}

ClassMethod D4P1(input) As %String
{
	set:'$d(input) input="372037-905157"
	
	do ##class(AOC.Y2019).ParseString(input,"-",.minnum,.maxnum)
	
	set res=0
	for i=minnum:1:maxnum {
		set last=-1
		set hasrepeat=0
		set increasing=1
		for j=1:1:6 {
			if $e(i,j)<last {
				set increasing=0
				quit
			} elseif $e(i,j)=last {
				set hasrepeat=1
			}
			set last=$e(i,j)
		}
		
		if hasrepeat&&increasing {
			set res=$i(res)
		}
	}
	quit res
}

ClassMethod D4P2(input) As %String
{
	set:'$d(input) input="372037-905157"
	
	do ##class(AOC.Y2019).ParseString(input,"-",.minnum,.maxnum)
	
	set res=0
	for i=minnum:1:maxnum {
		set last=-1
		set hasrepeat=0
		set increasing=1
		set repeatcount=0
		for j=1:1:6 {
			if $e(i,j)<last {
				set increasing=0
				quit
			} elseif $e(i,j)=last {
				set repeatcount=$i(repeatcount)
				if ((j=6) && (repeatcount=1)) {
					set hasrepeat=1
				}
			} else {
				if repeatcount=1 {
					set hasrepeat=1
				}
				set repeatcount=0
			}
			set last=$e(i,j)
		}
		
		if hasrepeat&&increasing {
			set res=$i(res)
		}
	}
	quit res
}

ClassMethod D5P1(input="") As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(5,.input)
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
	
	//set instructions(1)=12
	//set instructions(2)=2
	
	set pos=0
	
	set inputval=1
	
	while 1 {
		set inst=instructions(pos)
		set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
		set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
		set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
		set inst=inst#100
		set pos=(pos+1)#maxlen
		// ??? inst=4
		if ((mode1) || (inst=3) || (inst=4)) {
			set val1=instructions(pos)
		} else {
			set val1=instructions(instructions(pos)#maxlen)
		}
		if ((inst=1) || (inst=2) || (inst=99)) {
			set pos=(pos+1)#maxlen
			if mode2 {
				set val2=instructions(pos)
			} else {
				set val2=instructions(instructions(pos)#maxlen)
			}
			set pos=(pos+1)#maxlen
			if (mode3) {
				set storeloc=instructions(pos)#maxlen
			} else {
				// ???
				set storeloc=instructions(pos)#maxlen
			}
		}
		set pos=(pos+1)
		if inst=99 {
			quit
		} elseif inst=1 {
			set instructions(storeloc)=val1+val2
		} elseif inst=2 {
			set instructions(storeloc)=val1*val2
		} elseif inst=3 {
			set instructions(val1)=inputval
		} elseif inst=4 {
			if mode1 {
				zw val1
			} else {
				zw instructions(val1)
			}
		}
	}
	
	quit instructions(0)
}

ClassMethod D5P2(input="") As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(5,.input)
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
	
	//set instructions(1)=12
	//set instructions(2)=2
	
	set pos=0
	
	set inputval=5
	
	while 1 {
		set inst=instructions(pos)
		set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
		set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
		set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
		set inst=inst#100
		set pos=(pos+1)#maxlen
		// ??? inst=4
		if ((mode1) || (inst=3) || (inst=4)) {
			set val1=instructions(pos)
		} else {
			set val1=instructions(instructions(pos)#maxlen)
		}
		if ((inst=1) || (inst=2) || (inst=5) || (inst=6) || (inst=7) || (inst=8)  || (inst=99)) {
			set pos=(pos+1)#maxlen
			if mode2 {
				set val2=instructions(pos)
			} else {
				set val2=instructions(instructions(pos)#maxlen)
			}
			if ((inst=1) || (inst=2) || (inst=7) || (inst=8)) {
				set pos=(pos+1)#maxlen
				if (mode3) {
					set storeloc=instructions(pos)#maxlen
				} else {
					// ???
					set storeloc=instructions(pos)#maxlen
				}
			}
		}
		set pos=(pos+1)
		if inst=99 {
			quit
		} elseif inst=1 {
			set instructions(storeloc)=val1+val2
		} elseif inst=2 {
			set instructions(storeloc)=val1*val2
		} elseif inst=3 {
			set instructions(val1)=inputval
		} elseif inst=4 {
			if mode1 {
				zw val1
			} else {
				zw instructions(val1)
			}
		} elseif inst=5 {
			if val1'=0 {
				set pos=val2
			}
		} elseif inst=6 {
			if val1=0 {
				set pos=val2
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
		}
	}
	
	quit instructions(0)
}

ClassMethod D6P1(input) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(6,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,")",.a,.b)
		
		set orbits(b)=a
		set planets(a)=$i(planets(a))
		set planets(b)=$i(planets(b))
		
		set pos=$o(input(pos),1,l)
	}
	
	set planet=$o(planets(""))
	while planet'="" {
		set parent=$g(orbits(planet))
		while parent'="" {
			set res=$i(res)
			set parent=$g(orbits(parent))
		}
		set planet=$o(planets(planet))
	}
	
	quit res
}


ClassMethod D6P2(input) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(6,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,")",.a,.b)
		
		set orbits(b)=a
		set planets(a)=$i(planets(a))
		set planets(b)=$i(planets(b))
		
		set pos=$o(input(pos),1,l)
	}
	
	set planet=$o(planets(""))
	while planet'="" {
		set planetcount=0
		set parent=$g(orbits(planet))
		set planetpath=planet
		while parent'="" {
			set res=$i(res)
			set planetcount=$i(planetcount)
			set planetpath=parent_","_planetpath
			set parent=$g(orbits(parent))
		}
		set planetpath(planet)=planetpath
		set planetcount(planet)=planetcount
		set planet=$o(planets(planet))
	}
	
	set youpath=$lfs(planetpath("YOU"))
	set sanpath=$lfs(planetpath("SAN"))
	
	for i=1:1:$length(youpath) {
		if (($lg(youpath,i))=$lg(sanpath,i)) && ($lg(youpath,i)'="") {
			set commonparent=$lg(youpath,i)
		} else {
			quit
		}
	}
	
	quit (planetcount("YOU")-planetcount(commonparent))+(planetcount("SAN")-planetcount(commonparent))-2
}

ClassMethod D7P1(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(7,.input)
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
	
	//set instructions(1)=12
	//set instructions(2)=2
	
	zw:debug instructions
	
	merge resetinstructions=instructions
	
	set pos=0
	set maxout=-1
	
	for a=0:1:4 {
		for b=0:1:4 {
			continue:b=a
			for c=0:1:4 {
				continue:((c=a)||(c=b))
				for d=0:1:4 {
					continue:((d=a)||(d=b)||(d=c))
					for e=0:1:4 {
						continue:((e=a)||(e=b)||(e=c)||(e=d))
						set tempoutput=0
						set inputval=$lb(a,b,c,d,e)
						w:debug "using "
						zw:debug inputval
						for f=1:1:5 {
							set inputpos=0
							set pos=0
							k instructions
							merge instructions=resetinstructions
							k inputcount
							while 1 {
								set inst=instructions(pos)
								set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
								set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
								set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
								set inst=inst#100
								set pos=(pos+1)#maxlen
								// ??? inst=4
								if ((mode1) || (inst=3) || (inst=4)) {
									set val1=instructions(pos)
								} else {
									set val1=instructions(instructions(pos)#maxlen)
								}
								if ((inst=1) || (inst=2) || (inst=5) || (inst=6) || (inst=7) || (inst=8)  || (inst=99)) {
									set pos=(pos+1)#maxlen
									if mode2 {
										set val2=instructions(pos)
									} else {
										set val2=instructions(instructions(pos)#maxlen)
									}
									if ((inst=1) || (inst=2) || (inst=7) || (inst=8)) {
										set pos=(pos+1)#maxlen
										if (mode3) {
											set storeloc=instructions(pos)#maxlen
										} else {
											// ???
											set storeloc=instructions(pos)#maxlen
										}
									}
								}
								set pos=(pos+1)
								if inst=99 {
									quit
								} elseif inst=1 {
									set instructions(storeloc)=val1+val2
								} elseif inst=2 {
									set instructions(storeloc)=val1*val2
								} elseif inst=3 {
									if $i(inputcount)=1 {
										set instructions(val1)=$lg(inputval,f)
									} else {
										set instructions(val1)=tempoutput
									}
									zw:debug inputpos
								} elseif inst=4 {
									if mode1 {
										zw:debug inputval
										zw:debug val1
										set tempoutput=val1
									} else {
										zw:debug inputval
										zw:debug instructions(val1)
										set tempoutput=instructions(val1)
									}
								} elseif inst=5 {
									if val1'=0 {
										set pos=val2
									}
								} elseif inst=6 {
									if val1=0 {
										set pos=val2
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
								}
								zw:debug inst
								zw:debug val1
								zw:debug val2
								zw:debug storeloc
							}
						}
							
						if tempoutput>maxout {
							set maxout=tempoutput
							zw:debug inputval
							zw:debug maxout
							//break
						}
					}
				}
			}
		}
	}
	
	quit maxout
}

ClassMethod D7P2(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(7,.input)
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
	
	//set instructions(1)=12
	//set instructions(2)=2
	
	zw:debug instructions
	
	merge originalinstructions=instructions
	
	set maxout=-1
	
	for a=5:1:9 {
		for b=5:1:9 {
			continue:b=a
			for c=5:1:9 {
				continue:((c=a)||(c=b))
				for d=5:1:9 {
					continue:((d=a)||(d=b)||(d=c))
					for e=5:1:9 {
						continue:((e=a)||(e=b)||(e=c)||(e=d))
						set tempoutput=0
						set inputval=$lb(a,b,c,d,e)
						w:debug "using "
						zw:debug inputval
						set haltfound=0
						set inputpos=-1
						set inputcount(1)=0
						set inputcount(2)=0
						set inputcount(3)=0
						set inputcount(4)=0
						set inputcount(5)=0
						
						merge resetinstructions(1)=originalinstructions
						merge resetinstructions(2)=originalinstructions
						merge resetinstructions(3)=originalinstructions
						merge resetinstructions(4)=originalinstructions
						merge resetinstructions(5)=originalinstructions
						
						set pos(1)=0
						set pos(2)=0
						set pos(3)=0
						set pos(4)=0
						set pos(5)=0
						
						while 'haltfound {
							set inputpos=$i(inputpos)#5
							k instructions
							merge instructions=resetinstructions(inputpos+1)
							//set inputpos=0
							set pos=pos(inputpos+1)
							//k instructions
							//merge instructions=resetinstructions
							while 1 {
								set inst=instructions(pos)
								set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
								set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
								set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
								set inst=inst#100
								set pos=(pos+1)#maxlen
								// ??? inst=4
								if ((mode1) || (inst=3) || (inst=4)) {
									set val1=instructions(pos)
								} else {
									set val1=instructions(instructions(pos)#maxlen)
								}
								if ((inst=1) || (inst=2) || (inst=5) || (inst=6) || (inst=7) || (inst=8)  || (inst=99)) {
									set pos=(pos+1)#maxlen
									if mode2 {
										set val2=instructions(pos)
									} else {
										set val2=instructions(instructions(pos)#maxlen)
									}
									if ((inst=1) || (inst=2) || (inst=7) || (inst=8)) {
										set pos=(pos+1)#maxlen
										if (mode3) {
											set storeloc=instructions(pos)#maxlen
										} else {
											// ???
											set storeloc=instructions(pos)#maxlen
										}
									}
								}
								set pos=(pos+1)
								if inst=99 {
									set haltfound=1
									quit
								} elseif inst=1 {
									set instructions(storeloc)=val1+val2
								} elseif inst=2 {
									set instructions(storeloc)=val1*val2
								} elseif inst=3 {
									if $i(inputcount(inputpos+1))=1 {
										set instructions(val1)=$lg(inputval,inputpos+1)
									} else {
										set instructions(val1)=tempoutput
									}
									zw:debug inputpos
								} elseif inst=4 {
									if mode1 {
										zw:debug inputval
										zw:debug val1
										set tempoutput=val1
									} else {
										zw:debug inputval
										zw:debug instructions(val1)
										set tempoutput=instructions(val1)
									}
									
									k resetinstructions(inputpos+1)
									merge resetinstructions(inputpos+1)=instructions
									set pos(inputpos+1)=pos
									quit
								} elseif inst=5 {
									if val1'=0 {
										set pos=val2
									}
								} elseif inst=6 {
									if val1=0 {
										set pos=val2
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
								}
								zw:debug inst
								zw:debug val1
								zw:debug val2
								zw:debug storeloc
							}
						}
							
						if tempoutput>maxout {
							set maxout=tempoutput
							zw:debug inputval
							zw:debug maxout
						}
					}
				}
			}
		}
	}
	
	quit maxout
}

ClassMethod D8P1(input) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(8,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		set row=0
		set col=0
		set layer=0
		for i=0:1:$l(l)-1 {
			set image(layer,row,col)=$e(l,i+1)
			
			set vals(layer,$e(l,i+1))=$i(vals(layer,$e(l,i+1)))
			
			set col=(col+1)#25
			set:((i>0)&&(col=0)) row=(row+1)#6
			set:((i>0)&&(col=0)&&(row=0)) layer=layer+1
		}
		set pos=$o(input(pos),1,l)
	}
	
	set minzero=9999999
	set layer=$o(vals(""))
	set row=0
	while layer'="" {
		set numzero=vals(layer,0)
		if numzero<minzero {
			set minzero=numzero
			set res=vals(layer,1)*vals(layer,2)
		}		
		set layer=$o(vals(layer))
	}
	
	quit res
}

ClassMethod D8P2(input) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(8,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		set row=0
		set col=0
		set layer=0
		for i=0:1:$l(l)-1 {
			set image(layer,row,col)=$e(l,i+1)
			
			set vals(layer,$e(l,i+1))=$i(vals(layer,$e(l,i+1)))
			
			set col=(col+1)#25
			set:((i>0)&&(col=0)) row=(row+1)#6
			set:((i>0)&&(col=0)&&(row=0)) layer=layer+1
		}
		set pos=$o(input(pos),1,l)
	}
	
	for row=0:1:5 {
		for col=0:1:24 {
			set layer=$o(image(""))
			while layer'="" {
				set temp=image(layer,row,col)
				if temp=2 {
					set layer=$o(image(layer))
				} else {
					set res(row,col)=temp
					quit
				}
			}
		}
	}
	
	for row=0:1:5 {
		for col=0:1:24 {
			if res(row,col)=1 {
				w res(row,col)
			} else {
				w " "
			}
		}
		w !
	}
	
	quit ""
}

ClassMethod DXP1(input) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(X,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		
		
		
		set pos=$o(input(pos),1,l)
	}
	quit res
}

}