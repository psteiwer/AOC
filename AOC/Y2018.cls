Class AOC.Y2018 Extends AOC.Base
{

PARAMETER Year As %Integer = 2018;

ClassMethod D1P1() As %String
{
	do ##class(AOC.Y2018).GetInput(1,.out)
	
	set res=0
	set pos=$o(out(""),1,l)
	while pos'="" {
		set res=res+l
		set pos=$o(out(pos),1,l)
	}
	quit res
}

ClassMethod D1P2() As %String
{
	do ##class(AOC.Y2018).GetInput(1,.out)
	
	set res=0
	set done=0
	set pos=$o(out(""),1,l)
	while 'done {
		if pos'="" {
			set res=res+l
			set:$g(d(res)) done=1
			set d(res)=1
		}
		set pos=$o(out(pos),1,l)
	}
	quit res
}

ClassMethod D2P1() As %String
{
	do ##class(AOC.Y2018).GetInput(2,.out)
	
	set res=0
	set pos=$o(out(""),1,l)
	set two=0
	set three=0
	while pos'="" {
		k t
		for i=1:1:$length(l) {
			set c=$e(l,i)
			set t(c)=$i(t(c))
		}
		set temp3=0
		set temp2=0
		set p=$o(t(""),1,n)
		while p'="" {
			if n=2 {
				set:'temp2 two=two+1
				zw:'temp2 t
				w:'temp2 l_" is 2 "_p,!
				set temp2=1
				
			} elseif n=3 {
				set:'temp3 three=three+1
				zw:'temp2 t
				w:'temp3 l_" is 3 "_p,!
				set temp3=1
			}
			set p=$o(t(p),1,n)
		}
		set pos=$o(out(pos),1,l)
	}
	quit two*three
}

ClassMethod D2P2() As %String
{
	do ##class(AOC.Y2018).GetInput(2,.out)
	
	set pos=$o(out(""),1,l)
	while pos'="" {
		set t(l)=""
		set pos2=$o(t(""))
		while pos2'="" {
			set diff=0
			//w "compare:",!
			//w l,!
			//w pos2,!
			for i=1:1:$length(l) {
				if ($e(l,i))'=($e(pos2,i)) {
					set diff=diff+1
				}
			}
			
			if diff=1 {
				w "diff: "_diff,!
				w l,!
				w pos2,!
				quit
			}
			set pos2=$o(t(pos2))
		}
		set pos=$o(out(pos),1,l)
	}
	quit ""
}

ClassMethod D3P1() As %String
{
	do ##class(AOC.Y2018).GetInput(3,.out)
	
	set pos=$o(out(""),1,l)
	while pos'="" {
		set c=$piece(l," ",3)
		set s=$piece(l," ",4)
		set x=$p(c,",",1)
		set y=$p(c,",",2)
		set y=$p(y,":",1)
		set h=$p(s,"x",1)
		set w=$p(s,"x",2)
		
		for i=1:1:h {
			for j=1:1:w {
				set f(x+i,y+j)=$i(f(x+i,y+j))
			}
		}
		set pos=$o(out(pos),1,l)
	}
		
	set res=0
	set i=$o(f(""))
	while i'="" {
		set j=$o(f(i,""))
		while j'="" {
			if f(i,j)>1 {
				set res=res+1
			}
			set j=$o(f(i,j))
		}
		set i=$o(f(i))
	}
	
	quit res
}

ClassMethod D3P2() As %String
{
	do ##class(AOC.Y2018).GetInput(3,.out)
	
	set pos=$o(out(""),1,l)
	while pos'="" {
		set n=$piece(l," ",1)
		set claims(n)=""
		set c=$piece(l," ",3)
		set s=$piece(l," ",4)
		set x=$p(c,",",1)
		set y=$p(c,",",2)
		set y=$p(y,":",1)
		set h=$p(s,"x",1)
		set w=$p(s,"x",2)
		
		for i=1:1:h {
			for j=1:1:w {
				set f(x+i,y+j)=$g(f(x+i,y+j))_$lb(n)
			}
		}
		set pos=$o(out(pos),1,l)
	}
	
	set res=0
	set i=$o(f(""))
	while i'="" {
		set j=$o(f(i,""))
		while j'="" {
			if $ll(f(i,j))>1 {
				for k=1:1:$ll(f(i,j)) {
					k claims($lg(f(i,j),k))
				}
			}
			set j=$o(f(i,j))
		}
		set i=$o(f(i))
	}
	
	zw claims
	
	quit res
}

ClassMethod D4P1() As %String
{
	do ##class(AOC.Y2018).GetInput(4,.out)
	
	set pos=$o(out(""),1,l)
	while pos'="" {
		set time=$piece(l," ",1,2)
		set action=$piece(l," ",3,*)
		
		set timeline(time)=action
		
		set pos=$o(out(pos),1,l)
	}
	
	set guard=""
	set sleepstart=""
	set time=$o(timeline(""),1,action)
	while time'="" {
		if $e(action,1)="G" {
			set guard=$e($piece(action," ",2),2,*)
		} else {
			set min=$e($piece(time,":",2),1,*-1)
			if $e(action,1)="f" {
				set sleepstart=min
			} elseif $e(action,1)="w" {
				set sleepend=min
				for i=sleepstart:1:min {
					set sleeptimes(guard,i)=$i(sleeptimes(guard,i))
					set sleeptimes(guard)=$i(sleeptimes(guard))
				}
			}
		}
		
		set time=$o(timeline(time),1,action)
	}
	
	set maxtime=0
	set maxguard=""
	set g=$o(sleeptimes(""),1,n)
	while g'="" {
		if n>maxtime {
			set maxguard=g
			set maxtime=n
		}
		set g=$o(sleeptimes(g),1,n)
	}
	
	set maxmin=0
	set maxpos=""
	set m=$o(sleeptimes(maxguard,""),1,n)
	while m'="" {
		if n>maxmin {
			set maxpos=m
			set maxmin=n
		}
		set m=$o(sleeptimes(maxguard,m),1,n)
	}

	quit maxpos*maxguard
}

ClassMethod D4P2() As %String
{
	do ##class(AOC.Y2018).GetInput(4,.out)
	
	set pos=$o(out(""),1,l)
	while pos'="" {
		set time=$piece(l," ",1,2)
		set action=$piece(l," ",3,*)
		
		set timeline(time)=action
		
		set pos=$o(out(pos),1,l)
	}
	
	set guard=""
	set sleepstart=""
	set time=$o(timeline(""),1,action)
	while time'="" {
		if $e(action,1)="G" {
			set guard=$e($piece(action," ",2),2,*)
		} else {
			set min=$e($piece(time,":",2),1,*-1)
			if $e(action,1)="f" {
				set sleepstart=min
			} elseif $e(action,1)="w" {
				set sleepend=min
				for i=sleepstart:1:min {
					set sleeptimes(guard,i)=$i(sleeptimes(guard,i))
					set sleeptimes(guard)=$i(sleeptimes(guard))
				}
			}
		}
		
		set time=$o(timeline(time),1,action)
	}
	
	set maxmin=0
	set maxpos=""
	set maxguard=""
	set g=$o(sleeptimes(""))
	while g'="" {
		set m=$o(sleeptimes(g,""),1,n)
		while m'="" {
			if n>maxmin {
				set maxpos=m
				set maxmin=n
				set maxguard=g
			}
			set m=$o(sleeptimes(g,m),1,n)
		}
		set g=$o(sleeptimes(g))
	}

	quit maxpos*maxguard
}

ClassMethod D5P1(pIn="") As %String
{
	if pIn="" {
		do ##class(AOC.Y2018).GetInput(5,.out)
		set l=out(1)_out(2)
	} else {
		set l=pIn
	}
	
	set done=0
	while 'done {
		set done=1
		for i=1:1:$length(l)-1 {
			if ($e(l,i)'=$e(l,i+1))&&($zconvert($e(l,i),"U")=$zconvert($e(l,i+1),"U")) {
				set l=$e(l,1,i-1)_$e(l,i+2,*)
				set done=0
			}
		}
	}
	
	quit l
}

ClassMethod D5P2() As %String
{
	set x=##class(AOC.Y2018).D5P1()
	set minlen=$l(x)
	for i=65:1:90 {
		set temp=##class(AOC.Y2018).D5P1($translate(x,$char(i)_$zconvert($char(i),"L"),""))
		if $l(temp)<minlen {
			set minlen=$l(temp)
		}
	}
	
	quit minlen
}

ClassMethod D6P1(input) As %String
{
	do:'$d(input) ##class(AOC.Y2018).GetInput(6,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	set marker=0
	set maxX=0
	set maxY=0
	set minX=99999
	set minY=99999
	while pos'="" {
		do ##class(AOC.Y2018).ParseString(l,",",.x,.y)
		set x=+x
		set y=+$zstrip(y,"*W")
		set map(y,x)=$i(marker)
		
		if x>maxX {
			set maxX=x
		}
		if x<minX {
			set minX=x
		}
		if y>maxY {
			set maxY=y
		}
		if y<minY {
			set minY=y
		}
		
		set pos=$o(input(pos),1,l)
	}
	
	for y=minY:1:maxY {
		for x=minX:1:maxX {
			set dY=99999
			set dX=99999
			set posX=0
			set posY=0
			set istie=0
			set tempY=$o(map(""))
			while tempY'="" {
				set tempX=$o(map(tempY,""))
				while tempX'="" {
					if ((($zabs(tempX-x)+$zabs(tempY-y))<(dX+dY))||((tempY=y)&&(tempX=x))) {
						set distance(y,x)=map(tempY,tempX)
						set dY=$zabs(y-tempY)
						set dX=$zabs(x-tempX)
						set posX=tempX
						set posY=tempY
						set istie=0
					} elseif ($zabs(tempX-x)+$zabs(tempY-y))=(dX+dY) {
						set distance(y,x)=0
						set istie=1
					}
					set tempX=$o(map(tempY,tempX))
				}
				set tempY=$o(map(tempY))
			}
			if ((x=minX)||(x=maxX)||(y=minY)||(y=maxY)) {
				set count(map(posY,posX))=-1
			}
			set:(($G(count(map(posY,posX)))'=-1)&&('istie)) count(map(posY,posX))=$i(count(map(posY,posX)))
		}
	}
	
	set countpos=$o(count(""))
	while countpos'="" {
		if count(countpos)>res {
			set res=count(countpos)
		}
		set countpos=$o(count(countpos))
	}
	
	quit res
}

ClassMethod D6P2(input) As %String
{
	do:'$d(input) ##class(AOC.Y2018).GetInput(6,.input)
	
	set res=""
	set pos=$o(input(""),1,l)
	set marker=0
	set maxX=0
	set maxY=0
	set minX=99999
	set minY=99999
	while pos'="" {
		do ##class(AOC.Y2018).ParseString(l,",",.x,.y)
		set x=+x
		set y=+$zstrip(y,"*W")
		set map(y,x)=$i(marker)
		
		if x>maxX {
			set maxX=x
		}
		if x<minX {
			set minX=x
		}
		if y>maxY {
			set maxY=y
		}
		if y<minY {
			set minY=y
		}
		
		set pos=$o(input(pos),1,l)
	}
	
	for y=minY:1:maxY {
		for x=minX:1:maxX {
			set totaldistance=0
			set tempY=$o(map(""))
			while ((tempY'="")&&(totaldistance<10000)) {
				set tempX=$o(map(tempY,""))
				while ((tempX'="")&&(totaldistance<10000)) {
					set totaldistance=totaldistance+($zabs(tempX-x)+$zabs(tempY-y))
					
					set tempX=$o(map(tempY,tempX))
				}
				set tempY=$o(map(tempY))
			}
			if totaldistance<10000 {
				set res=$i(res)
			}
		}
	}
	
	quit res
}

ClassMethod D7P1() As %String
{
	do ##class(AOC.Y2018).GetInput(7,.out)
	
	set res=""
	set pos=$o(out(""),1,l)
	while pos'="" {
		set a=$e($piece(l," must be finished before step ",1),*)
		set b=$e($piece(l," must be finished before step ",2),1)
		set start(a)=1
		set start(b)=1
		set order(a,b)=1
		set pos=$o(out(pos),1,l)
	}
	
	set x=$o(order(""))
	while x'="" {
		set y=$o(order(x,""))
		while y'="" {
			k start(y)
			set y=$o(order(x,y))
		}
		set x=$o(order(x))
	}
	
	merge avail=start
	
	set x=$o(avail(""))
	while x'="" {
		set res=res_x
		set used(x)=1
		set y=$o(order(x,""))
		while y'="" {
			set z=$o(order(""))
			set isavail=1
			while z'="" {
				if $g(order(z,y)) {
					if '$d(used(z)) {
						set isavail=0
					}
				}
				set z=$o(order(z))
			}
			if ((isavail) & ('$d(used(y)))) {
				set avail(y)=1
			}
			set y=$o(order(x,y))
		}
		k avail(x)
		set x=$o(avail(""))
	}
	quit res
}

}
