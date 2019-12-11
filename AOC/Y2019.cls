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
			w res,!
		}
	}
	
	quit res
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