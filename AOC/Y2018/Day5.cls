Class AOC.Y2018.Day5 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 5;

Parameter Year = 2018;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day5).GetInput(..#Day,.pInput)
	Set l=pInput(1)_pInput(2)
	
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
	
	quit $length(l)
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day5).GetInput(..#Day,.pInput)
	Set l=pInput(1)_pInput(2)
	
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
	
	set minlen=##class(AOC.Y2018.Day5).Part1()
	for i=65:1:90 {
		set temp=$translate(l,$char(i)_$zconvert($char(i),"L"),"")
		
		set done=0
		while 'done {
			set done=1
			for j=1:1:$length(temp)-1 {
				if ($e(temp,j)'=$e(temp,j+1))&&($zconvert($e(temp,j),"U")=$zconvert($e(temp,j+1),"U")) {
					set temp=$e(temp,1,j-1)_$e(temp,j+2,*)
					set done=0
				}
			}
		}
		
		if $l(temp)<minlen {
			set minlen=$l(temp)
		}
	}
	
	quit minlen
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2018.Day5).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2018.Day5).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
