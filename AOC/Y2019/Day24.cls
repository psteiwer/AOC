Class AOC.Y2019.Day24 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 24;

Parameter Year = 2019;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day24).GetInput(..#Day,.pInput)
	
	set res=""
	set map=-1
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019.Day24).ParseString(l,,.l)
		
		set map=$i(map)
		for i=1:1:$length(l) {
			set map(map,i-1)=$e(l,i)
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	zw:pDebug map
	
	do:pDebug ##class(AOC.Y2019.Day24).Print2DArray(.map)
	
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

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day24).GetInput(..#Day,.pInput)
	
	set res=""
	set map=-1
	set level=0
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019.Day24).ParseString(l,,.l)
		
		set map=$i(map)
		for i=1:1:$length(l) {
			set map(level,map,i-1)=$e(l,i)
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	zw:pDebug map
	
	do:pDebug ##class(AOC.Y2019.Day24).Print2DArray(.map)
	
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
	
	zw:pDebug map
	quit numbugs
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day24).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day24).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
