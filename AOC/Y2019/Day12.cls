Class AOC.Y2019.Day12 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 12;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day12).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,",",.x,.y,.z)
		set x=$piece(x,"=",2)
		set y=$piece(y,"=",2)
		set z=$piece($e(z,1,*-1),"=",2)
		set planets($i(planets))=$lb(x,y,z)
		
		set pos=$o(pInput(pos),1,l)
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
		zw:pDebug planets
		zw:pDebug velocity
	}
	
	for i=1:1:planets {
		set tempPot=$zabs($lg(planets(i),1))+$zabs($lg(planets(i),2))+$zabs($lg(planets(i),3))
		set tempKin=$zabs($lg(velocity(i),1))+$zabs($lg(velocity(i),2))+$zabs($lg(velocity(i),3))
		set res=res+(tempPot*tempKin)
	}
	
	quit res
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day12).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019).ParseString(l,",",.x,.y,.z)
		set x=$piece(x,"=",2)
		set y=$piece(y,"=",2)
		set z=$piece($e(z,1,*-1),"=",2)
		set planets($i(planets))=$lb(x,y,z)
		
		set pos=$o(pInput(pos),1,l)
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
			zw:pDebug xRepeat
		}
		if yOK&&(yRepeat=0) {
			set yRepeat=res
			zw:pDebug yRepeat
		}
		if zOK&&(zRepeat=0) {
			set zRepeat=res
			zw:pDebug zRepeat
		}
		if xRepeat&&yRepeat&&zRepeat {
			set res=##class(AOC.Y2019).LCM(xRepeat,yRepeat,zRepeat)
			set done=1
		}
	}
	
	quit res
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day12).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day12).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
