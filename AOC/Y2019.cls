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