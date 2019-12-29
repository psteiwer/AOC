Class AOC.Y2018.Day6 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 6;

Parameter Year = 2018;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day6).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
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
		
		set pos=$o(pInput(pos),1,l)
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

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day6).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
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
		
		set pos=$o(pInput(pos),1,l)
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

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2018.Day6).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2018.Day6).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
