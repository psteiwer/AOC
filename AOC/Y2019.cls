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
	set pos=-1
	
	set instructions(1)=12
	set instructions(2)=2
	
	while 1 {
		set inst=instructions($i(pos))
		quit:inst=99
		set val1=instructions(instructions($i(pos))#maxlen)
		set val2=instructions(instructions($i(pos))#maxlen)
		set storeloc=instructions($i(pos))#maxlen
		if inst=1 {
			set instructions(storeloc)=val1+val2
		} elseif inst=2 {
			set instructions(storeloc)=val1*val2
		}
	}
	
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
			
			set pos=-1
			
			while 1 {
				set inst=instructions($i(pos))
				quit:inst=99
				set val1=instructions(instructions($i(pos))#maxlen)
				set val2=instructions(instructions($i(pos))#maxlen)
				set storeloc=instructions($i(pos))#maxlen
				if inst=1 {
					set instructions(storeloc)=val1+val2
				} elseif inst=2 {
					set instructions(storeloc)=val1*val2
				}
			}
			
			if instructions(0)=19690720 {
				//zw instructions
				//w "x="_x,!
				//w "y="_y,!
				return (100*x+y)
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

ClassMethod D5P1(input="",debug=0) As %String
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
	
	set pos=-1
	set inputval=1
	
	while 1 {
		set inst=instructions($i(pos))
		quit:inst=99
		set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
		set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
		set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
		set inst=inst#100
		// ??? inst=4
		if ((mode1) || (inst=3) || (inst=4)) {
			set val1=instructions($i(pos))
		} else {
			set val1=instructions(instructions($i(pos))#maxlen)
		}
		if ((inst=1) || (inst=2)) {
			if mode2 {
				set val2=instructions($i(pos))
			} else {
				set val2=instructions(instructions($i(pos))#maxlen)
			}
			if (mode3) {
				set storeloc=instructions($i(pos))#maxlen
			} else {
				// ???
				set storeloc=instructions($i(pos))#maxlen
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
			w:debug res,!
		}
	}
	
	quit res
}

ClassMethod D5P2(input="",debug=0) As %String
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
	
	set pos=-1
	set inputval=5
	
	while 1 {
		set inst=instructions($i(pos))
		quit:inst=99
		set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
		set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
		set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
		set inst=inst#100
		// ??? inst=4
		if ((mode1) || (inst=3) || (inst=4)) {
			set val1=instructions($i(pos))
		} else {
			set val1=instructions(instructions($i(pos))#maxlen)
		}
		if ((inst=1) || (inst=2) || (inst=5) || (inst=6) || (inst=7) || (inst=8)) {
			if mode2 {
				set val2=instructions($i(pos))
			} else {
				set val2=instructions(instructions($i(pos))#maxlen)
			}
			if ((inst=1) || (inst=2) || (inst=7) || (inst=8)) {
				if (mode3) {
					set storeloc=instructions($i(pos))#maxlen
				} else {
					// ???
					set storeloc=instructions($i(pos))#maxlen
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
		}
	}
	
	quit res
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
							set pos=-1
							k instructions
							merge instructions=resetinstructions
							k inputcount
							while 1 {
								set inst=instructions($i(pos))
								quit:inst=99
								set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
								set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
								set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
								set inst=inst#100
								// ??? inst=4
								if ((mode1) || (inst=3) || (inst=4)) {
									set val1=instructions($i(pos))
								} else {
									set val1=instructions(instructions($i(pos))#maxlen)
								}
								if ((inst=1) || (inst=2) || (inst=5) || (inst=6) || (inst=7) || (inst=8)) {
									if mode2 {
										set val2=instructions($i(pos))
									} else {
										set val2=instructions(instructions($i(pos))#maxlen)
									}
									if ((inst=1) || (inst=2) || (inst=7) || (inst=8)) {
										if (mode3) {
											set storeloc=instructions($i(pos))#maxlen
										} else {
											// ???
											set storeloc=instructions($i(pos))#maxlen
										}
									}
								}
								if inst=1 {
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
						
						set pos(1)=-1
						set pos(2)=-1
						set pos(3)=-1
						set pos(4)=-1
						set pos(5)=-1
						
						while 'haltfound {
							set inputpos=$i(inputpos)#5
							k instructions
							merge instructions=resetinstructions(inputpos+1)
							//set inputpos=0
							set pos=pos(inputpos+1)
							//k instructions
							//merge instructions=resetinstructions
							while 1 {
								set inst=instructions($i(pos))
								set:inst=99 haltfound=1
								quit:inst=99
								set mode1=+$e($replace($j(inst#100000,5)," ",0),3)
								set mode2=+$e($replace($j(inst#100000,5)," ",0),2)
								set mode3=+$e($replace($j(inst#100000,5)," ",0),1)
								set inst=inst#100
								// ??? inst=4
								if ((mode1) || (inst=3) || (inst=4)) {
									set val1=instructions($i(pos))
								} else {
									set val1=instructions(instructions($i(pos))#maxlen)
								}
								if ((inst=1) || (inst=2) || (inst=5) || (inst=6) || (inst=7) || (inst=8)) {
									if mode2 {
										set val2=instructions($i(pos))
									} else {
										set val2=instructions(instructions($i(pos))#maxlen)
									}
									if ((inst=1) || (inst=2) || (inst=7) || (inst=8)) {
										if (mode3) {
											set storeloc=instructions($i(pos))#maxlen
										} else {
											// ???
											set storeloc=instructions($i(pos))#maxlen
										}
									}
								}
								if inst=1 {
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
	
	do ##class(AOC.Y2019).Print2DArray(.res,1)
	
	quit ""
}

ClassMethod D9P1(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(9,.input)
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
	
	set pos=-1
	set inputval=1
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
					//set storeloc=$g(instructions($i(pos)),0)+offset
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
				set res=val1
			} else {
				set res=instructions(val1)
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
	
	quit res
}

ClassMethod D9P2(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(9,.input)
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
	
	set pos=-1
	set inputval=2
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
				set res=val1
			} else {
				set res=instructions(val1)
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
	
	quit res
}

ClassMethod D10P1(input) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(10,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		
		for i=0:1:$length(l)-1 {
			if $e(l,i+1)="#" {
				set map(pos-1,i)=$e(l,i+1)
			}	
		}
		
		set pos=$o(input(pos),1,l)
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
					
					if ((x=0) && (y=-1)) {
						zw tempx
						zw tempy
						zw slope
						zw temp
						break
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
	
	zw max
	zw maxX
	zw maxY
	
	quit res
}

ClassMethod D10P2(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(10,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		
		for i=0:1:$length(l)-1 {
			if $e(l,i+1)="#" {
				set map(pos-1,i)=$e(l,i+1)
			}	
		}
		
		set pos=$o(input(pos),1,l)
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
		
		zw:debug max
		
		set vap1=$o(max(""))
		while vap1'="" {
			set vap2=$o(max(vap1,""))
			if $d(max(vap1))=1 {
				set tempx=$lg(max(vap1),1)
				set tempy=$lg(max(vap1),2)
				k map(tempy,tempx)
				set vapcount=$i(vapcount)
				zw:debug vap1
				w:debug "vaporize #"_vapcount_" "_tempx_","_tempy,!
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
				zw:debug vap1
				zw:debug vap2
				w:debug "vaporize #"_vapcount_" "_tempx_","_tempy,!
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

ClassMethod D11P1(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(11,.input)
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
	
	set painted=0
	set curY=0
	set curX=0
	set facing="U"
	set done=0
	set pos=-1
	set relativebase=0
	set outnum=0

	while 1 {
		set inputval=$G(map(curY,curX),0)
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
				set res=val1
			} else {
				set res=instructions(val1)
			}
			//w res,!
			if (outnum#2)=0 {
				set:$g(map(curY,curX))="" painted=$i(painted)
				if res=0 {
					w:debug "paint black",!
					set map(curY,curX)=0
				} else {
					w:debug "paint white",!
					set map(curY,curX)=1
				}
			} else {
				set tempdir=""
				if res=0 {
					w:debug "turn left",!
					if facing="U" {
						set facing="L"
					} elseif facing="L" {
						set facing="D"
					} elseif facing="D" {
						set facing="R"
					} elseif facing="R" {
						set facing="U"
					}
				} else {
					w:debug "turn right",!
					if facing="U" {
						set facing="R"
					} elseif facing="R" {
						set facing="D"
					} elseif facing="D" {
						set facing="L"
					} elseif facing="L" {
						set facing="U"
					}
				}
				if facing="U" {
					set curY=curY-1
				} elseif facing="R" {
					set curX=curX+1
				} elseif facing="D" {
					set curY=curY+1
				} elseif facing="L" {
					set curX=curX-1
				}
			}
			set outnum=$i(outnum)
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
	
	quit painted
}

ClassMethod D11P2(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(11,.input)
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
	
	set painted=0
	set curY=0
	set curX=0
	set map(0,0)=1
	set paintedstart=0
	set facing="U"
	set done=0
	set pos=-1
	set relativebase=0
	set outnum=0

	while 1 {
		set inputval=$G(map(curY,curX),0)
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
				set res=val1
			} else {
				set res=instructions(val1)
			}
			//w res,!
			if (outnum#2)=0 {
				set:$g(map(curY,curX))="" painted=$i(painted)
				if ((curY=0)&&(curX=0)&&(paintedstart=0)) {
					set paintedstart=1
					set painted=$i(painted)
				}
				if res=0 {
					w:debug "paint black",!
					set map(curY,curX)=0
				} else {
					w:debug "paint white",!
					set map(curY,curX)=1
				}
			} else {
				set tempdir=""
				if res=0 {
					w:debug "turn left",!
					if facing="U" {
						set facing="L"
					} elseif facing="L" {
						set facing="D"
					} elseif facing="D" {
						set facing="R"
					} elseif facing="R" {
						set facing="U"
					}
				} else {
					w:debug "turn right",!
					if facing="U" {
						set facing="R"
					} elseif facing="R" {
						set facing="D"
					} elseif facing="D" {
						set facing="L"
					} elseif facing="L" {
						set facing="U"
					}
				}
				if facing="U" {
					set curY=curY-1
				} elseif facing="R" {
					set curX=curX+1
				} elseif facing="D" {
					set curY=curY+1
				} elseif facing="L" {
					set curX=curX-1
				}
			}
			set outnum=$i(outnum)
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
	
	do ##class(AOC.Y2019).Print2DArray(.map,1)
	
	quit ""
}

ClassMethod D12P1(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(12,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,",",.x,.y,.z)
		set x=$piece(x,"=",2)
		set y=$piece(y,"=",2)
		set z=$piece($e(z,1,*-1),"=",2)
		set planets($i(planets))=$lb(x,y,z)
		
		set pos=$o(input(pos),1,l)
	}
	
	for step=1:1:1000 {
		// apply gravity
		for i=1:1:planets {
			for j=i+1:1:planets {
				set planetA=planets(i)
				set planetB=planets(j)
				for k=1:1:3 {
					//zw velocity
					set tempA=$lg($g(velocity(i)),k)
					set tempB=$lg($g(velocity(j)),k)
					if $lg(planetA,k)>$lg(planetB,k) {
						set $list(velocity(i),k)=$lg($g(velocity(i)),k)-1
						set $list(velocity(j),k)=$lg($g(velocity(j)),k)+1
					} elseif $lg(planetA,k)<$lg(planetB,k) {
						set $list(velocity(i),k)=$lg($g(velocity(i)),k)+1
						set $list(velocity(j),k)=$lg($g(velocity(j)),k)-1
					}
				}
			}
		}
		
		// apply velocity
		for i=1:1:planets {
			for j=1:1:3 {
				set $list(planets(i),j)=$lg(planets(i),j)+$lg(velocity(i),j)
			}
		}
		zw:debug planets
		zw:debug velocity
	}
	
	for i=1:1:planets {
		set tempPot=$zabs($lg(planets(i),1))+$zabs($lg(planets(i),2))+$zabs($lg(planets(i),3))
		set tempKin=$zabs($lg(velocity(i),1))+$zabs($lg(velocity(i),2))+$zabs($lg(velocity(i),3))
		set res=res+(tempPot*tempKin)
	}
	
	quit res
}

ClassMethod D12P2(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(12,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,",",.x,.y,.z)
		set x=$piece(x,"=",2)
		set y=$piece(y,"=",2)
		set z=$piece($e(z,1,*-1),"=",2)
		set planets($i(planets))=$lb(x,y,z)
		
		set pos=$o(input(pos),1,l)
	}
	
	merge initial=planets
	set done=0
	set xRepeat=0
	set yRepeat=0
	set zRepeat=0
	
	while 'done {
		// apply gravity
		for i=1:1:planets {
			for j=i+1:1:planets {
				set planetA=planets(i)
				set planetB=planets(j)
				for k=1:1:3 {
					set tempA=$lg($g(velocity(i)),k)
					set tempB=$lg($g(velocity(j)),k)
					if $lg(planetA,k)>$lg(planetB,k) {
						set $list(velocity(i),k)=$lg($g(velocity(i)),k)-1
						set $list(velocity(j),k)=$lg($g(velocity(j)),k)+1
					} elseif $lg(planetA,k)<$lg(planetB,k) {
						set $list(velocity(i),k)=$lg($g(velocity(i)),k)+1
						set $list(velocity(j),k)=$lg($g(velocity(j)),k)-1
					}
				}
			}
		}
		
		// apply velocity
		for i=1:1:planets {
			for j=1:1:3 {
				set $list(planets(i),j)=$lg(planets(i),j)+$lg(velocity(i),j)
			}
		}
		set res=$i(res)
		set xOK=1
		set yOK=1
		set zOK=1
		for i=1:1:planets {
			for j=1:1:3 {
				if $lg(planets(i),j)'=$lg(initial(i),j) {
					set:j=1 xOK=0
					set:j=2 yOK=0
					set:j=3 zOK=0
				}
				if $lg(velocity(i),j)'=0 {
					set:j=1 xOK=0
					set:j=2 yOK=0
					set:j=3 zOK=0
				}
			}
		}
		if xOK&&(xRepeat=0) {
			set xRepeat=res
			zw:debug xRepeat
		}
		if yOK&&(yRepeat=0) {
			set yRepeat=res
			zw:debug yRepeat
		}
		if zOK&&(zRepeat=0) {
			set zRepeat=res
			zw:debug zRepeat
		}
		if xRepeat&&yRepeat&&zRepeat {
			set res=##class(AOC.Y2019).LCM(xRepeat,yRepeat,zRepeat)
			set done=1
		}
	}
	
	quit res
}

ClassMethod D13P1(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(13,.input)
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
	
	set pos=-1
	set inputval=2
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
	
	for i=2:3:$l(res,",")-1 {
		set array($p(res,",",i),$p(res,",",i+1))=$p(res,",",i+2)
		set:$p(res,",",i+2)=2 count=$i(count)
	}
	
	zw:debug res
	zw:debug array
	
	quit count
}

ClassMethod D13P2(input="",withui=0,debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(13,.input)
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

ClassMethod D14P1(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(14,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,"=>",.a,.b)
		set a=$lfs(a)
		set tempb=$zstrip(b,"<>W")
		set tempbamount=$p(tempb," ",1)
		set tempbmat=$p(tempb," ",2)
		set materials(tempbmat)=tempbamount
		for i=1:1:$ll(a) {
			set tempa=$zstrip($lg(a,i),"<>W")
			set tempaamount=$p(tempa," ",1)
			set tempamat=$p(tempa," ",2)
			set materials(tempbmat,tempamat)=tempaamount
		}
		
		set pos=$o(input(pos),1,l)
	}
	
	zw:debug materials
	
	set noupdates=0
	set resources("FUEL")=1
	while 'noupdates {
		set noupdates=1
		set resource=$o(resources(""))
		while resource'="" {
			set tempresourceval=$G(resources(resource))
			set val=$G(materials(resource))
			set multiplier=0
			set:val>0 multiplier=$SYSTEM.SQL.CEILING(tempresourceval/val)
			//zw tempresource
			if resource'="ORE" {
				set tempresource=$o(materials(resource,""))
				while tempresource'="" {
					set val2=materials(resource,tempresource)
					set newresources(tempresource)=val2*multiplier
					
					set tempresource=$o(materials(resource,tempresource))
				}
			}
			zw:debug resources
			zw:debug newresources
			zw:debug resource
			zw:debug multiplier
			if multiplier>0 {
				set noupdates=0
				set resources(resource)=$i(resources(resource),-materials(resource)*multiplier)
			}
			set tempresource=$o(newresources(""))
			while tempresource'="" {
				set resources(tempresource)=$i(resources(tempresource),newresources(tempresource))
				
				set tempresource=$o(newresources(tempresource))
			}
			zw:debug resources
			
			k newresources
			
			set resource=$o(resources(resource))
		}
	}
	
	zw:debug resources
	
	
	quit resources("ORE")
}

ClassMethod D14P2(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(14,.input)
	set fuelbase=##class(AOC.Y2019).D14P1(.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,"=>",.a,.b)
		set a=$lfs(a)
		set tempb=$zstrip(b,"<>W")
		set tempbamount=$p(tempb," ",1)
		set tempbmat=$p(tempb," ",2)
		set materials(tempbmat)=tempbamount
		for i=1:1:$ll(a) {
			set tempa=$zstrip($lg(a,i),"<>W")
			set tempaamount=$p(tempa," ",1)
			set tempamat=$p(tempa," ",2)
			set materials(tempbmat,tempamat)=tempaamount
		}
		
		set pos=$o(input(pos),1,l)
	}
	
	set done=0
	set min=0
	set max=1000000000000
	set fueltest=1000000000000
	while 'done {
		set res=$i(res)
		set noupdates=0
		k resources
		set resources("FUEL")=fueltest
		while 'noupdates {
			set noupdates=1
			set resource=$o(resources(""))
			while resource'="" {
				set tempresourceval=$G(resources(resource))
				set val=$G(materials(resource))
				set multiplier=0
				set:val>0 multiplier=$SYSTEM.SQL.CEILING(tempresourceval/val)
				//zw tempresource
				if resource'="ORE" {
					set tempresource=$o(materials(resource,""))
					while tempresource'="" {
						set val2=materials(resource,tempresource)
						set newresources(tempresource)=val2*multiplier
						
						set tempresource=$o(materials(resource,tempresource))
					}
				}
				if multiplier>0 {
					set noupdates=0
					set resources(resource)=$i(resources(resource),-materials(resource)*multiplier)
				}
				set tempresource=$o(newresources(""))
				while tempresource'="" {
					set resources(tempresource)=$i(resources(tempresource),newresources(tempresource))
					
					set tempresource=$o(newresources(tempresource))
				}
				
				k newresources
				
				set resource=$o(resources(resource))
			}
		}
		
		if $g(resources("ORE"))<1000000000000 {
			if ($g(resources("ORE"))+fuelbase)>1000000000000 {
				set res=fueltest
				set done=1
				quit
			}
			zw:debug fueltest
			w:debug "too low",!
			set min=fueltest
			//break
			set fueltest=(((max-min)*.5)\1)+min
		} else {
			if ($g(resources("ORE"))-fuelbase)<1000000000000 {
				set res=fueltest-1
				set done=1
				quit
			}
			zw:debug fueltest
			w:debug "too high",!
			set max=fueltest
			//break
			set fueltest=fueltest-((max-min)\2)
		}
	}
	
	quit res
}

ClassMethod D15P1(input="",withui=0,debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(15,.input)
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
			zw:debug res
			zw:debug inputval
			set oldinputval=inputval
			w:withui #
			do:withui ##class(AOC.Y2019).Print2DArray(.map,1,posx,posy)
			k newx
			k newy
			zw:debug posx
			zw:debug posy
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
				w:debug "move "_$case(oldinputval,1:"U",4:"R",2:"D",3:"L",:"invalid")_" blocked",!
			} elseif res=1 {
				w:debug "moved "_$case(oldinputval,1:"U",4:"R",2:"D",3:"L",:"invalid"),!
				set:'backtrack path=path_oldinputval
				set backtrack=0
				set posx=$g(newx,posx)
				set posy=$g(newy,posy)
			} elseif res=2 {
				w:debug "OUTPUT WAS 2",!
				set posx=$g(newx,posx)
				set posy=$g(newy,posy)
				set oxygenx=posx
				set oxygeny=posy
				set done=1
				quit
			}
			
			// figure out next move
			zw:debug inputval
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
			zw:debug inputval
			zw:debug unknown
			
			w:debug "NEXT MOVE WILL BE "_inputval,!
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
	
	zw:debug oxygenx
	zw:debug oxygeny
	
	zw:debug path
	w:withui #
	do:withui ##class(AOC.Y2019).Print2DArray(.map,1,oxygenx,oxygeny)
	
	quit $length(path)+1
}

ClassMethod D15P2(input="",withui=0,debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(15,.input)
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
	w:withui #
	do:withui ##class(AOC.Y2019).Print2DArray(.map,"O")
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
		w:withui #
		do:withui ##class(AOC.Y2019).Print2DArray(.newmap,"O")
	}
	quit res-1
}

ClassMethod D16P1(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(16,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		
		set count=0
		for i=1:1:$length(l) {
			set vals(i)=$e(l,i)
			set vals=i
		}
		
		set pos=$o(input(pos),1,l)
	}
	
	set pattern=3
	set pattern(0)=0
	set pattern(1)=1
	set pattern(2)=0
	set pattern(3)=-1
	
	set numphases=100
	for phase=1:1:numphases {
		for pos=1:1:vals {
			k temppattern
			//compute temppattern
			for i=1:1:vals+1 {
				for j=0:1:pos-1 {
					continue:((i=1)&&(j=0))
					set temppattern($i(temppattern))=pattern((i-1)#(pattern+1))
					quit:temppattern>vals
				}
				quit:$G(temppattern)>vals
			}
			
			set tempout=0
			for pos2=1:1:vals {
				set tempout=tempout+(vals(pos2)*temppattern(pos2))
			}
			set vals(pos)=$zabs(tempout)#10
		}
		set res=""
		w:debug "after phase "_phase,!
		for i=1:1:8 {
			set res=res_vals(i)
		}
		w:debug res,!
	}
	
	quit res
}

ClassMethod D16P2(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(16,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		
		for i=1:1:$length(l) {
			set tempvals(i)=$e(l,i)
			set tempvals=i
		}
		
		set pos=$o(input(pos),1,l)
	}
	
	for i=1:1:10000 {
		for j=1:1:tempvals {
			set vals($i(vals))=tempvals(j)
		}
	}
	
	k tempvals
	
	set offset=vals(1)_vals(2)_vals(3)_vals(4)_vals(5)_vals(6)_vals(7)
	
	zw:debug offset
	
	set phases=100
	for i=1:1:phases {
		set pos=vals
		set sum=0
		while pos>=offset {
			set sum=sum+vals(pos)
			set vals(pos)=$zabs(sum)#10
			if (pos>6499997)&&debug {
				zw pos
				zw sum
				zw vals(pos)
				break
			}
			
			set pos=$i(pos,-1)
		}
		w:debug "PHASE "_i_" COMPLETE",!
	}
	
	for i=offset+1:1:offset+8 {
		set res=res_vals(i)
	}
	zw:debug res
	break:debug
	quit res
}

ClassMethod D17P1(input="",withui=0,debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(17,.input)
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
	
	do:withui ##class(AOC.Y2019).Print2DArray(.map)
	
	quit res
}

ClassMethod D17P2(input="",withui=0,debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(17,.input)
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
				
				zw:debug move
				set path=""
				for i=1:1:move {
					set path=path_$select(path'="":",",1:"")_move(i,"dir")_","_move(i,"count")
				}
				zw:debug path
				
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
							zw:debug temppath
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
	
	do:withui ##class(AOC.Y2019).Print2DArray(.map)
	
	quit res
}

ClassMethod D18P1(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(18,.input)
	
	set res=""
	set posy=""
	set posx=""
	set pos=$o(input(""),1,l)
	set map=-1
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		set map=$i(map)
		for i=1:1:$length(l) {
			set tempchar=$e(l,i)
			set map(map,i-1)=tempchar
			if tempchar="@" {
				set posy=map
				set posx=i-1
			}
			if (($ascii(tempchar)>96)&&($ascii(tempchar)<123)) {
				set keys(tempchar)=$lb(map,i-1)
			}
			if (($ascii(tempchar)>64)&&($ascii(tempchar)<91)) {
				set doors(tempchar)=$lb(map,i-1)
			}
		}
		
		set pos=$o(input(pos),1,l)
	}
	
	//optimization, loop through map and any . surrounded by 3 # is a dead end, change to #
	set modified=1
	set modifiedcount=0
	while modified {
		set modified=0
		for tempy=1:1:$o(map(""),-1)-1 {
			for tempx=1:1:$o(map(tempy,""),-1)-1 {
				set isfree=map(tempy,tempx)="."
				set isdoor=(($ascii(map(tempy,tempx))>=65)&&($ascii(map(tempy,tempx))<=90))
				if 'isfree&&'isdoor {
					// if it isnt a . or a door, skip
					continue
				}
				set wallcount=0
				set:map(tempy+1,tempx)="#" wallcount=$i(wallcount)
				set:map(tempy-1,tempx)="#" wallcount=$i(wallcount)
				set:map(tempy,tempx+1)="#" wallcount=$i(wallcount)
				set:map(tempy,tempx-1)="#" wallcount=$i(wallcount)
				if wallcount>2 {
					set map(tempy,tempx)="#"
					set modified=1
					set modifiedcount=$i(modifiedcount)
				}
			}
		}
	}
	
	set map(posy,posx)="."
	set res=##class(AOC.Y2019).D18Fill(debug,.map,.keys,0,5000,$lb("@"),,$lb(posx,posy))
	
	quit res
}

ClassMethod D18Fill(debug, ByRef pMap, ByRef pKeys, pSteps, pMinSteps, pPath, ByRef pKeystrings, pQ1="", pQ2="", pQ3="", pQ4="") As %Integer
{
	Quit:pSteps>=pMinSteps pMinSteps
	merge tMap=pMap
	merge tKeys=pKeys
	
	set done=0
	set part2=0
	
	set sizey=$o(tMap(""),-1)
	set sizex=$o(tMap(sizey,""),-1)
	set sizey=$system.SQL.CEILING(sizey/2)
	set sizex=$system.SQL.CEILING(sizex/2)
	
	if pQ1'="" {
		set tMap($lg(pQ1,2),$lg(pQ1,1))="!"
	}
	if pQ2'="" {
		set part2=1
		set tMap($lg(pQ2,2),$lg(pQ2,1))="!"
	}
	if pQ3'="" {
		set tMap($lg(pQ3,2),$lg(pQ3,1))="!"
	}
	if pQ4'="" {
		set tMap($lg(pQ4,2),$lg(pQ4,1))="!"
	}
	
	merge tempMap=tMap
	
	while 'done {
		set done=1
		set tempsteps=$i(tempsteps)
		Quit:(pSteps+tempsteps)>=pMinSteps
		set row=$o(tMap(""))
		while row'="" {
			set col=$o(tMap(row,""))
			while col'="" {
				if tMap(row,col)="!" {
					for tempcheck=1,2,3,4 {
						if tempcheck=1 {
							set y=row-1
							set x=col
						} elseif tempcheck=2 {
							set y=row+1
							set x=col
						} elseif tempcheck=3 {
							set y=row
							set x=col-1
						} elseif tempcheck=4 {
							set y=row
							set x=col+1
						}
						
						if tMap(y,x)="." {
							set tempMap(y,x)="!"
							set done=0
						} elseif (($ascii(tMap(y,x))>=65)&&($ascii(tMap(y,x))<=90)) {
							//this is a door, if the key doesnt exist, set to #
							if '$d(tKeys($$$LOWER(tMap(y,x)))) {
								set tempMap(y,x)="!"
								set done=0
							}
						} elseif (($ascii(tMap(y,x))>=97)&&($ascii(tMap(y,x))<=122)) {
							// this is a key
							set tempkey=tMap(y,x)
							if part2 {
								if (tempkey="y")&&($d(tKeys("m"))) {
									quit
								}
							} else {
								if (tempkey="l")&&($d(tKeys("e"))||$d(tKeys("y"))||$d(tKeys("m"))) {
									quit
								}
							}
							set pPath=pPath_$lb(tMap(y,x))
							k tKeys(tempkey)
							if $d(tKeys)=0 {
								zw pPath
								zw pSteps+tempsteps
								return pSteps+tempsteps
							}
							
							
							set pMap(y,x)="."
							k keylist
							for i=1:1:26 {
								set $list(keylist,i)=$data(tKeys($char(i+96)))
							}
							set keystring=$lts(keylist,,1)
							if $G(pKeystrings(tempkey,keystring),5000)>(pSteps+tempsteps) {
								set pKeystrings(tempkey,keystring)=pSteps+tempsteps
								
								set tQ1=""
								set tQ2=""
								set tQ3=""
								set tQ4=""
								if part2 {
									set tQ1=pQ1
									set tQ2=pQ2
									set tQ3=pQ3
									set tQ4=pQ4
									if ((x<sizex)&&(y<sizey)) {
										set tQ1=$lb(x,y)
									} elseif ((x>sizex)&&(y<sizey)) {
										set tQ2=$lb(x,y)
									} elseif ((x>sizex)&&(y>sizey)) {
										set tQ3=$lb(x,y)
									} elseif ((x<sizex)&&(y>sizey)) {
										set tQ4=$lb(x,y)
									}  
								} else {
									set tQ1=$lb(x,y)
								}
								set tempres=##class(AOC.Y2019).D18Fill(debug,.pMap,.tKeys,pSteps+tempsteps,pMinSteps,pPath,.pKeystrings,tQ1,tQ2,tQ3,tQ4)
								set:tempres<pMinSteps pMinSteps=tempres
							}
							
							set pMap(y,x)=tempkey
							set tempMap(y,x)="#"
							set done=0
							
							
								
							//do ##class(AOC.Y2019).Print2DArray(.tMap)
							//break
								
							set tKeys(tempkey)=1
							set pPath=$list(pPath,1,*-1)
						}
					}
				}
				set col=$o(tMap(row,col))
			}
			set row=$o(tMap(row))
		}
		k tMap
		merge tMap=tempMap
	}
	
	quit pMinSteps
}

ClassMethod D18P2(input,debug=0) As %String
{
	set:$d(input) istest=1
	do:'$d(input) ##class(AOC.Y2019).GetInput(18,.input)
	
	set res=""
	set posy=""
	set posx=""
	set pos=$o(input(""),1,l)
	set map=-1
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		set map=$i(map)
		for i=1:1:$length(l) {
			set tempchar=$e(l,i)
			set map(map,i-1)=tempchar
			if tempchar="@" {
				set posy=map
				set posx=i-1
			}
			if (($ascii(tempchar)>96)&&($ascii(tempchar)<123)) {
				set keys(tempchar)=$lb(map,i-1)
			}
			if (($ascii(tempchar)>64)&&($ascii(tempchar)<91)) {
				set doors(tempchar)=$lb(map,i-1)
			}
		}
		
		set pos=$o(input(pos),1,l)
	}
	
	//optimization, loop through map and any . surrounded by 3 # is a dead end, change to #
	set modified=1
	set modifiedcount=0
	while modified {
		set modified=0
		for tempy=1:1:$o(map(""),-1)-1 {
			for tempx=1:1:$o(map(tempy,""),-1)-1 {
				set isfree=map(tempy,tempx)="."
				set isdoor=(($ascii(map(tempy,tempx))>=65)&&($ascii(map(tempy,tempx))<=90))
				if 'isfree&&'isdoor {
					// if it isnt a . or a door, skip
					continue
				}
				set wallcount=0
				set:map(tempy+1,tempx)="#" wallcount=$i(wallcount)
				set:map(tempy-1,tempx)="#" wallcount=$i(wallcount)
				set:map(tempy,tempx+1)="#" wallcount=$i(wallcount)
				set:map(tempy,tempx-1)="#" wallcount=$i(wallcount)
				if wallcount>2 {
					set map(tempy,tempx)="#"
					set modified=1
					set modifiedcount=$i(modifiedcount)
				}
			}
		}
	}
	
	if '$G(istest,0) {
		set map(posy+1,posx)="#"
		set map(posy-1,posx)="#"
		set map(posy,posx+1)="#"
		set map(posy,posx-1)="#"
		set map(posy,posx)="#"
		
		set map(posy+1,posx+1)="."
		set map(posy-1,posx+1)="."
		set map(posy+1,posx-1)="."
		set map(posy-1,posx-1)="."
	} else {
		set posy=$o(map(""),-1)
		set posx=$o(map(posy,""),-1)
		set posy=$system.SQL.CEILING(posy/2)
		set posx=$system.SQL.CEILING(posx/2)
		do ##class(AOC.Y2019).Print2DArray(.map,,posx,posy)
	}
	
	set res=##class(AOC.Y2019).D18Fill(debug,.map,.keys,0,5000,$lb("@"),,$lb(posx-1,posy-1),$lb(posx+1,posy-1),$lb(posx+1,posy+1),$lb(posx-1,posy+1))
	
	quit res
}

ClassMethod D19P1(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(19,.input)
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
			zw:debug inst
			zw:debug mode1
			zw:debug mode2
			zw:debug mode3
			zw:debug relativebase
			zw:debug pos
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
			zw:debug val1
			if ((inst=1) || (inst=2) || (inst=5) || (inst=6) || (inst=7) || (inst=8)) {
				if mode2=0 {
					set val2=$g(instructions($g(instructions($i(pos)),0)),0)
				} elseif mode2=1 {
					set val2=$g(instructions($i(pos)),0)
				} elseif mode2=2 {
					set val2=$g(instructions($g(instructions($i(pos)),0)+relativebase),0)
				}
				zw:debug val2
				if ((inst=1) || (inst=2) || (inst=7) || (inst=8)) {
					set storeloc=$g(instructions($i(pos)),0)
					set:mode3=2 storeloc=storeloc+relativebase
					zw:debug storeloc
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
				zw:debug res
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
	
	do:debug ##class(AOC.Y2019).Print2DArray(.map)
	quit res
}

ClassMethod D19P2(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(19,.input)
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
			
			zw:debug count
			zw:debug nextcount
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
			zw:debug inst
			zw:debug mode1
			zw:debug mode2
			zw:debug mode3
			zw:debug relativebase
			zw:debug pos
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
			zw:debug val1
			if ((inst=1) || (inst=2) || (inst=5) || (inst=6) || (inst=7) || (inst=8)) {
				if mode2=0 {
					set val2=$g(instructions($g(instructions($i(pos)),0)),0)
				} elseif mode2=1 {
					set val2=$g(instructions($i(pos)),0)
				} elseif mode2=2 {
					set val2=$g(instructions($g(instructions($i(pos)),0)+relativebase),0)
				}
				zw:debug val2
				if ((inst=1) || (inst=2) || (inst=7) || (inst=8)) {
					set storeloc=$g(instructions($i(pos)),0)
					set:mode3=2 storeloc=storeloc+relativebase
					zw:debug storeloc
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
				zw:debug res
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

ClassMethod D20P1(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(20,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	set map=-1
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		set map=$i(map)
		for i=1:1:$length(l) {
			set map(map,i-1)=$e(l,i)
		}
		
		set pos=$o(input(pos),1,l)
	}
	
	//do ##class(AOC.Y2019).Print2DArray(.map)
	
	//optimization, loop through map and any . surrounded by 3 # is a dead end, change to #
	set modified=1
	set modifiedcount=0
	while modified {
		set modified=0
		for tempy=1:1:$o(map(""),-1)-1 {
			for tempx=1:1:$o(map(tempy,""),-1)-1 {
				set isfree=map(tempy,tempx)="."
				if isfree {
					set wallcount=0
					set:map(tempy+1,tempx)="#" wallcount=$i(wallcount)
					set:map(tempy-1,tempx)="#" wallcount=$i(wallcount)
					set:map(tempy,tempx+1)="#" wallcount=$i(wallcount)
					set:map(tempy,tempx-1)="#" wallcount=$i(wallcount)
					if wallcount>2 {
						set map(tempy,tempx)="#"
						set modified=1
						set modifiedcount=$i(modifiedcount)
					}
				}
			}
		}
	}
	
	do:debug ##class(AOC.Y2019).Print2DArray(.map)
	
	// find all paths
	set tempy=$o(map(0))
	while tempy'="" {
		set tempx=$o(map(tempy,0))
		while tempx'="" {
			if map(tempy,tempx)'="." {
				set tempx=$o(map(tempy,tempx))
				continue
			}
			set isend=0
			set:(map(tempy+1,tempx)'="#")&&(map(tempy+1,tempx)'=".") isend=1
			set:(map(tempy-1,tempx)'="#")&&(map(tempy-1,tempx)'=".") isend=2
			set:(map(tempy,tempx+1)'="#")&&(map(tempy,tempx+1)'=".") isend=3
			set:(map(tempy,tempx-1)'="#")&&(map(tempy,tempx-1)'=".") isend=4
			if isend=1 {
				set pathname=map(tempy+1,tempx)_map(tempy+2,tempx)
				set map(tempy+1,tempx)="#"
			} elseif isend=2 {
				set pathname=map(tempy-2,tempx)_map(tempy-1,tempx)
				set map(tempy-1,tempx)="#"
			} elseif isend=3 {
				set pathname=map(tempy,tempx+1)_map(tempy,tempx+2)
				set map(tempy,tempx+1)="#"
			} elseif isend=4 {
				set pathname=map(tempy,tempx-2)_map(tempy,tempx-1)
				set map(tempy,tempx-1)="#"
			}
			if isend {
				// if wall count is not >2, we will come back to this.
				set tempy2=tempy
				set tempx2=tempx
				set path=""
				set isout=0
				while 'isout {
					set wallcount=0
					set tempmovey=tempy2
					set tempmovex=tempx2
					//set tempdir=""
					set tempval=map(tempy2,tempx2)
					
					if tempval="." {
						if map(tempy2+1,tempx2)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2+1
							set tempmovex=tempx2
							set tempdir="D"
						}
						if map(tempy2-1,tempx2)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2-1
							set tempmovex=tempx2
							set tempdir="U"
						}
						if map(tempy2,tempx2+1)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2
							set tempmovex=tempx2+1
							set tempdir="R"
						}
						if map(tempy2,tempx2-1)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2
							set tempmovex=tempx2-1
							set tempdir="L"
						}
					}
					
					if ((wallcount=3)||(wallcount=4)) {
						set path=path_tempdir
						set map(tempy2,tempx2)="#"
						set tempy2=tempmovey
						set tempx2=tempmovex
						if $d(pathsplit(tempy2,tempx2)) {
							set isend=-1
							set tempval=pathsplit(tempy2,tempx2)
							set paths(pathname)=path
							set newpath=tempval_pathname
							zw:debug tempval
							zw:debug pathname
							zw:debug newpath
							//store current path, start logging new path
							set links(pathname,newpath)=path
							set invertpath=""
							for i=$length(path):-1:1 {
								set invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
								set:(i=1)&&($length(pathname)=2) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
							}
							set links(newpath,pathname)=invertpath
							
							set path=paths(pathsplit(tempy2,tempx2))
							set links(tempval,newpath)=path
							set invertpath=""
							for i=$length(path):-1:1 {
								set invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
								set:(i=1)&&($length(tempval)=2) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
							}
							set links(newpath,tempval)=invertpath
							set path=""
							set pathname=tempval_pathname
						}
					} else {
						set isout=1
						if tempdir="U" {
							set tempval=map(tempy2-1,tempx2)_map(tempy2,tempx2)
						} elseif tempdir="D" {
							set tempval=map(tempy2,tempx2)_map(tempy2+1,tempx2)
						} elseif tempdir="L" {
							set tempval=map(tempy2,tempx2-1)_map(tempy2,tempx2)
						} elseif tempdir="R" {
							set tempval=map(tempy2,tempx2)_map(tempy2,tempx2+1)
						}
						set paths(pathname)=path
						if ((tempval[".")||(tempval["#")) {
							set pathsplit(tempy2,tempx2)=pathname
						} else {
							set links(pathname,tempval)=path
							set invertpath=""
							for i=$length(path):-1:1 {
								set:i'=$length(path) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
								set:(i=1)&&($length(pathname)=2) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
							}
							set links(tempval,pathname)=invertpath
							
						}
						set tempy=0
						set tempx=0
					}
				}
			}
			quit:tempx=0
			set tempx=$o(map(tempy,tempx))
		}
		set tempy=$o(map(tempy))
	}
	
	//do ##class(AOC.Y2019).Print2DArray(.map)
	
	set currentpath="AA"
	set nextpath=$o(links(currentpath,""))
	set steps=$length(links(currentpath,nextpath))
	set path=$lb("AA",nextpath)
	set minsteps=3000
	set res=##class(AOC.Y2019).D20Move(debug,.map,.paths,.links,nextpath,path,steps,minsteps)
	
	quit res
}

ClassMethod D20Move(debug, ByRef pMap, ByRef pPaths, ByRef pLinks, pCurrentPath, pPath, pSteps, pMinSteps, pDay=1, pLevel=0, ByRef pLevels) As %Integer
{
	Quit:pLevel<0 pMinSteps
	Quit:pSteps>pMinSteps pSteps
	
	set nextpath=$o(pLinks(pCurrentPath,""))
	while nextpath'="" {
		if (nextpath'=$lg(pPath,*-1)) {
			set pSteps=pSteps+$length(pLinks(pCurrentPath,nextpath))
			set pPath=pPath_$lb(nextpath)
			if ((nextpath="ZZ")&&(pLevel=0)) {
				//break:debug
				zw:debug pCurrentPath
				zw:debug pPath
				zw:debug pSteps
				zw:debug pMinSteps
				return pSteps-1
			} else {
				if ((pDay=2)&&($length(nextpath)=2)) {
					set pLevel=pLevel+pLevels(pCurrentPath,nextpath)
					if pLevel<-1 {
						zw pLevel
						break
					}
				}
				set temp=##class(AOC.Y2019).D20Move(debug,.pMap,.pPaths,.pLinks,nextpath,pPath,pSteps,pMinSteps,pDay,pLevel,.pLevels)
				if ((temp=489)&&(pMinSteps'=temp)) {
					zw pPath
					zw pLevel
					break
				}
				set:temp<pMinSteps pMinSteps=temp
				if ((pDay=2)&&($length(nextpath)=2)) {
					set pLevel=pLevel-pLevels(pCurrentPath,nextpath)
				}
			}
			set pSteps=pSteps-$length(pLinks(pCurrentPath,nextpath))
			set pPath=$list(pPath,1,*-1)
		}
		
		set nextpath=$o(pLinks(pCurrentPath,nextpath))
	}
	
	Quit pMinSteps
}

ClassMethod D20P2(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(20,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	set map=-1
	set maxx=0
	set maxy=0
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		set map=$i(map)
		for i=1:1:$length(l) {
			set map(map,i-1)=$e(l,i)
			set:maxx<i maxx=i
		}
		set:maxy<map maxy=map
		set pos=$o(input(pos),1,l)
	}
	set maxx=maxx/2
	set maxy=maxy/2
	
	//do ##class(AOC.Y2019).Print2DArray(.map)
	
	//optimization, loop through map and any . surrounded by 3 # is a dead end, change to #
	set modified=1
	set modifiedcount=0
	while modified {
		set modified=0
		for tempy=1:1:$o(map(""),-1)-1 {
			for tempx=1:1:$o(map(tempy,""),-1)-1 {
				set isfree=map(tempy,tempx)="."
				if isfree {
					set wallcount=0
					set:map(tempy+1,tempx)="#" wallcount=$i(wallcount)
					set:map(tempy-1,tempx)="#" wallcount=$i(wallcount)
					set:map(tempy,tempx+1)="#" wallcount=$i(wallcount)
					set:map(tempy,tempx-1)="#" wallcount=$i(wallcount)
					if wallcount>2 {
						set map(tempy,tempx)="#"
						set modified=1
						set modifiedcount=$i(modifiedcount)
					}
				}
			}
		}
	}
	
	do:debug ##class(AOC.Y2019).Print2DArray(.map)
	
	// find all paths
	set tempy=$o(map(0))
	while tempy'="" {
		set tempx=$o(map(tempy,0))
		while tempx'="" {
			if map(tempy,tempx)'="." {
				set tempx=$o(map(tempy,tempx))
				continue
			}
			set startx=tempx
			set starty=tempy
			set isend=0
			set:(map(tempy+1,tempx)'="#")&&(map(tempy+1,tempx)'=".") isend=1
			set:(map(tempy-1,tempx)'="#")&&(map(tempy-1,tempx)'=".") isend=2
			set:(map(tempy,tempx+1)'="#")&&(map(tempy,tempx+1)'=".") isend=3
			set:(map(tempy,tempx-1)'="#")&&(map(tempy,tempx-1)'=".") isend=4
			if isend=1 {
				set pathname=map(tempy+1,tempx)_map(tempy+2,tempx)
				set map(tempy+1,tempx)="#"
			} elseif isend=2 {
				set pathname=map(tempy-2,tempx)_map(tempy-1,tempx)
				set map(tempy-1,tempx)="#"
			} elseif isend=3 {
				set pathname=map(tempy,tempx+1)_map(tempy,tempx+2)
				set map(tempy,tempx+1)="#"
			} elseif isend=4 {
				set pathname=map(tempy,tempx-2)_map(tempy,tempx-1)
				set map(tempy,tempx-1)="#"
			}
			if isend {
				// if wall count is not >2, we will come back to this.
				set tempy2=tempy
				set tempx2=tempx
				set path=""
				set isout=0
				while 'isout {
					set wallcount=0
					set tempmovey=tempy2
					set tempmovex=tempx2
					//set tempdir=""
					set tempval=map(tempy2,tempx2)
					
					if tempval="." {
						if map(tempy2+1,tempx2)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2+1
							set tempmovex=tempx2
							set tempdir="D"
							set leveldir=$case(tempy2<maxy,1:+1,:-1)
						}
						if map(tempy2-1,tempx2)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2-1
							set tempmovex=tempx2
							set tempdir="U"
							set leveldir=$case(tempy2<maxy,1:-1,:+1)
						}
						if map(tempy2,tempx2+1)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2
							set tempmovex=tempx2+1
							set tempdir="R"
							set leveldir=$case(tempx2<maxx,1:+1,:-1)
						}
						if map(tempy2,tempx2-1)="#" {
							set wallcount=$i(wallcount)
						} else {
							set tempmovey=tempy2
							set tempmovex=tempx2-1
							set tempdir="L"
							set leveldir=$case(tempx2<maxx,1:-1,:+1)
						}
					}
					
					if ((wallcount=3)||(wallcount=4)) {
						set path=path_tempdir
						set map(tempy2,tempx2)="#"
						set tempy2=tempmovey
						set tempx2=tempmovex
						if $d(pathsplit(tempy2,tempx2)) {
							set isend=-1
							set tempval=pathsplit(tempy2,tempx2)
							set paths(pathname)=path
							set pathend=$e(path,*)
							set newpath=tempval_pathname
							//store current path, start logging new path
							set links(pathname,newpath)=path
							set levels(pathname,newpath)=leveldir
							set leveldir=$e(path,*)
							if leveldir="U" {
								set leveldir=$case(tempy2<maxy,1:-1,:+1)
							} elseif leveldir="D" {
								set leveldir=$case(tempy2<maxy,1:+1,:-1)
							} elseif leveldir="L" {
								set leveldir=$case(tempx2<maxx,1:-1,:+1)
							} elseif leveldir="R" {
								set leveldir=$case(tempx2<maxx,1:+1,:-1)
							}
							set invertpath=""
							for i=$length(path):-1:1 {
								set invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
								set:(i=1)&&($length(pathname)=2) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
							}
							set links(newpath,pathname)=invertpath
							set levels(newpath,pathname)=-leveldir
							set path=paths(pathsplit(tempy2,tempx2))
							set links(tempval,newpath)=path
							set leveldir=$e(path,1)
							if leveldir="U" {
								set leveldir=$case(tempy2<maxy,1:-1,:+1)
							} elseif leveldir="D" {
								set leveldir=$case(tempy2<maxy,1:+1,:-1)
							} elseif leveldir="L" {
								set leveldir=$case(tempx2<maxx,1:-1,:+1)
							} elseif leveldir="R" {
								set leveldir=$case(tempx2<maxx,1:+1,:-1)
							}
							set levels(tempval,newpath)=leveldir
							set invertpath=""
							for i=$length(path):-1:1 {
								set invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
								set:(i=1)&&($length(tempval)=2) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
							}
							set links(newpath,tempval)=invertpath
							set levels(newpath,tempval)=-leveldir
							set path=""
							set pathname=tempval_pathname
						}
					} else {
						set isout=1
						if tempdir="U" {
							set tempval=map(tempy2-1,tempx2)_map(tempy2,tempx2)
						} elseif tempdir="D" {
							set tempval=map(tempy2,tempx2)_map(tempy2+1,tempx2)
						} elseif tempdir="L" {
							set tempval=map(tempy2,tempx2-1)_map(tempy2,tempx2)
						} elseif tempdir="R" {
							set tempval=map(tempy2,tempx2)_map(tempy2,tempx2+1)
						}
						set paths(pathname)=path
						if ((tempval[".")||(tempval["#")) {
							set pathsplit(tempy2,tempx2)=pathname
							set pathsplit(tempy2,tempx2,"startx")=startx
							set pathsplit(tempy2,tempx2,"starty")=starty
						} else {
							set links(pathname,tempval)=path
							set levels(pathname,tempval)=leveldir
							set invertpath=""
							for i=$length(path):-1:1 {
								set:i'=$length(path) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
								set:(i=1)&&($length(pathname)=2) invertpath=invertpath_$case($e(path,i),"U":"D","D":"U","L":"R","R":"L",:"")
							}
							set links(tempval,pathname)=invertpath
							set levels(tempval,pathname)=-leveldir
							
						}
						set tempy=0
						set tempx=0
					}
				}
			}
			quit:tempx=0
			set tempx=$o(map(tempy,tempx))
		}
		set tempy=$o(map(tempy))
	}
	
	set currentpath="AA"
	set nextpath=$o(links(currentpath,""))
	set steps=$length(links(currentpath,nextpath))
	set path=$lb("AA",nextpath)
	set minsteps=7000
	set res=##class(AOC.Y2019).D20Move(debug,.map,.paths,.links,nextpath,path,steps,minsteps,2,0,.levels)
	
	quit res
}

ClassMethod D21P1(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(21,.input)
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
			set tempval=inputvals($i(inputpos))
			set instructions(val1)=tempval
			set res=res_","_tempval
		} elseif inst=4 {
			if mode1 {
				set res=res_","_val1
			} else {
				set res=res_","_instructions(val1)
			}
			w res,!
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
		w $char(tempval)
		w:tempval=10 $char(13)
	}
	
	zw res
	quit $lg(res,*)
}



ClassMethod D21P2(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(21,.input)
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
			set tempval=inputvals($i(inputpos))
			set instructions(val1)=tempval
			set res=res_","_tempval
		} elseif inst=4 {
			if mode1 {
				set res=res_","_val1
			} else {
				set res=res_","_instructions(val1)
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
	
	set res=$e(res,2,*)
	set res=$lfs(res)
	for i=1:1:$ll(res) {
		set tempval=$lg(res,i)
		w $char(tempval)
		w:tempval=10 $char(13)
	}
	
	zw res
	quit $lg(res,*)
}

ClassMethod D22P1(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(22,.input)
	
	set deck=""
	for i=0:1:10006 {
		set deck=deck_$lb(i)
	}
	
	set res=""
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		zw:debug l
		if l["deal into new stack" {
			set tempdeck=""
			for i=1:1:$ll(deck) {
				set tempdeck=$lb($lg(deck,i))_tempdeck
			}
			set deck=tempdeck
		} elseif l["cut " {
			set tempval=$piece(l,"cut ",2)
			if tempval>0 {
				set deck=$list(deck,tempval+1,*)_$list(deck,1,tempval)
			} else {
				set tempval=$zabs(tempval)
				set deck=$list(deck,*-tempval+1,*)_$list(deck,1,*-tempval)
			}
		} elseif l["deal with increment " {
			set tempval=$piece(l,"deal with increment ",2)
			set count=0
			set i=0
			while count<$ll(deck) {
				set count=$i(count)
				set $list(tempdeck,((tempval*(count-1))#$ll(deck))+1)=$lg(deck,count)
			}
			set deck=tempdeck
		}
		
		set pos=$o(input(pos),1,l)
	}
	
	zw:debug deck
	for i=1:1:$ll(deck) {
		if $lg(deck,i)="2019" {
			set res=i-1
			quit
		}
	}
	quit res
}

ClassMethod D22P2(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(22,.input)
	
	set numcards=119315717514047
	set numshuffles=101741582076661
	set cardatpos=2020
	
	set vals(0)=cardatpos
	set res=""
	
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		if l["deal into new stack" {
			set cardatpos=numcards-cardatpos-1
		} elseif l["cut " {
			set tempval=$piece(l,"cut ",2)
			set cardatpos=(cardatpos-tempval)#numcards
		} elseif l["deal with increment " {
			set tempval=$piece(l,"deal with increment ",2)
			set cardatpos=(-(numcards-cardatpos)*tempval)#numcards
		}
		
		set pos=$o(input(pos),1,l)
	}
	
	set vals(1)=cardatpos
	
	//94676896952648 - too high
	//73686896952648 - too low

	quit cardatpos
}

ClassMethod D23P1(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(23,.input)
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
		
		w:debug "Processing "_networknum,!
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
				zw:debug network(networknum,"input")
				zw:debug networknum
				w:debug "using input "_tempinput,!
				//break
				set network(networknum,"input")=$list(network(networknum,"input"),2,*)
				w:debug "input is now "
				zw:debug network(networknum,"input")
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
						w:debug "setting output",!
						zw:debug network(network(networknum,"output","network"),"input")
						//break
						set network(network(networknum,"output","network"),"input")=$G(network(network(networknum,"output","network"),"input"),"")_$lb(network(networknum,"output","x"),res)
						zw:debug network(network(networknum,"output","network"),"input")
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

ClassMethod D23P2(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(23,.input)
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
		
		w:debug "Processing "_networknum,!
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
				zw:debug network(networknum,"input")
				zw:debug networknum
				w:debug "using input "_tempinput,!
				set network(networknum,"input")=$list(network(networknum,"input"),2,*)
				w:debug "input is now "
				zw:debug network(networknum,"input")
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
						w:debug "setting output",!
						zw:debug network(network(networknum,"output","network"),"input")
						//break
						set network(network(networknum,"output","network"),"input")=$G(network(network(networknum,"output","network"),"input"),"")_$lb(network(networknum,"output","x"),res)
						zw:debug network(network(networknum,"output","network"),"input")
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

ClassMethod D24P1(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(24,.input)
	
	set res=""
	set map=-1
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		
		set map=$i(map)
		for i=1:1:$length(l) {
			set map(map,i-1)=$e(l,i)
		}
		
		set pos=$o(input(pos),1,l)
	}
	
	zw map
	
	do ##class(AOC.Y2019).Print2DArray(.map)
	
	// calculate biodiversity and update map
	set done=0
	while 'done {
		set count=-1
		set biodiversity=0
		set y=$o(map(""))
		while y'="" {
			set x=$o(map(y,""))
			while x'="" {
				set count=$i(count)
				
				set:map(y,x)="#" biodiversity=biodiversity+(2**count)
				
				set adjacent=0
				if $G(map(y-1,x))="#" {
					set adjacent=$i(adjacent)
				}
				if $G(map(y+1,x))="#" {
					set adjacent=$i(adjacent)
				}
				if $G(map(y,x-1))="#" {
					set adjacent=$i(adjacent)
				}
				if $G(map(y,x+1))="#" {
					set adjacent=$i(adjacent)
				}
				
				if (map(y,x)="#")&&(adjacent'=1) {
					set tempmap(y,x)="."
				} elseif (map(y,x)=".")&&((adjacent=1)||(adjacent=2)) {
					set tempmap(y,x)="#"
				} else {
					set tempmap(y,x)=map(y,x)
				}
				
				set x=$o(map(y,x))
			}
			set y=$o(map(y))
		}
		
		if $d(biodiversities(biodiversity)) {
			set res=biodiversity
			set done=1
		}
		
		k map
		merge map=tempmap
		
		set biodiversities(biodiversity)=1
	}
	
	quit res
}

ClassMethod D24P2(input,debug=0) As %String
{
	do:'$d(input) ##class(AOC.Y2019).GetInput(24,.input)
	
	set res=""
	set map=-1
	set level=0
	set pos=$o(input(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,,.l)
		
		set map=$i(map)
		for i=1:1:$length(l) {
			set map(level,map,i-1)=$e(l,i)
		}
		
		set pos=$o(input(pos),1,l)
	}
	
	zw map
	
	do ##class(AOC.Y2019).Print2DArray(.map)
	
	set minlevel=-1
	set maxlevel=1
	for i=0:1:4 {
		for j=0:1:4 {
			set map(1,i,j)="."
			set map(-1,i,j)="."
		}
	}
	
	// calculate biodiversity and update map
	for loop=1:1:200 {
		set count=-1
		set numbugs=0
		set levelnonempty=0
		set level=$o(map(""))
		while level'="" {
			set y=$o(map(level,""))
			while y'="" {
				set x=$o(map(level,y,""))
				while x'="" {
					set count=$i(count)
					if ((y=2)&&(x=2)) {
						set x=$o(map(level,y,x))
						continue
					}
					
					set adjacent=0
					if (y=3)&&(x=2) {
						for i=0:1:4 {
							if $G(map(level+1,4,i))="#" {
								set adjacent=$i(adjacent)
							}
						}	
					} elseif (y'=0)&&($G(map(level,y-1,x))="#") {
						set adjacent=$i(adjacent)
					} elseif (y=0)&&($G(map(level-1,1,2))="#") {
						set adjacent=$i(adjacent)
					}
					
					if (y=1)&&(x=2) {
						for i=0:1:4 {
							if $G(map(level+1,0,i))="#" {
								set adjacent=$i(adjacent)
							}
						}	
					} elseif (y'=4)&&($G(map(level,y+1,x))="#") {
						set adjacent=$i(adjacent)
					} elseif (y=4)&&($G(map(level-1,3,2))="#") {
						set adjacent=$i(adjacent)
					}
					
					if (y=2)&&(x=3) {
						for i=0:1:4 {
							if $G(map(level+1,i,4))="#" {
								set adjacent=$i(adjacent)
							}
						}	
					} elseif (x'=0)&&($G(map(level,y,x-1))="#") {
						set adjacent=$i(adjacent)
					} elseif (x=0)&&($G(map(level-1,2,1))="#") {
						set adjacent=$i(adjacent)
					}
					
					if (y=2)&&(x=1) {
						for i=0:1:4 {
							if $G(map(level+1,i,0))="#" {
								set adjacent=$i(adjacent)
							}
						}
					} elseif $G(map(level,y,x+1))="#" {
						set adjacent=$i(adjacent)
					} elseif (x=4)&&($G(map(level-1,2,3))="#") {
						set adjacent=$i(adjacent)
					}
					
					if (map(level,y,x)="#")&&(adjacent'=1) {
						set tempmap(level,y,x)="."
					} elseif (map(level,y,x)=".")&&((adjacent=1)||(adjacent=2)) {
						set tempmap(level,y,x)="#"
					} else {
						set tempmap(level,y,x)=map(level,y,x)
					}
					
					set:tempmap(level,y,x)="#" numbugs=$i(numbugs)
					
					set x=$o(map(level,y,x))
				}
				set y=$o(map(level,y))
			}
			
			if ((level=minlevel)&&($G(numbugs,0)>0)) {
				set minlevel=minlevel-1
				for i=0:1:4 {
					for j=0:1:4 {
						set tempmap(minlevel,i,j)="."
					}
				}
			} elseif ((level=maxlevel)&&($G(numbugs,0)>0)) {
				set maxlevel=maxlevel+1
				for i=0:1:4 {
					for j=0:1:4 {
						set tempmap(maxlevel,i,j)="."
					}
				}
			}
			
			set level=$o(map(level))
		}
		
		k map
		merge map=tempmap
	}
	
	zw map
	quit numbugs
}

ClassMethod D25P1(input="",debug=0) As %String
{
	if input="" {
		do ##class(AOC.Y2019).GetInput(25,.input)
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

ClassMethod DXP1(input,debug=0) As %String
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