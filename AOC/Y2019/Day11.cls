Class AOC.Y2019.Day11 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 11;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set intcode=##class(AOC.Y2019.Utils.Intcode).%New(11)
	
	set painted=0
	set posx=0
	set posy=0
	// 0=up, 1=right, 2=down, 3=left
	set dir=0
	d intcode.AddInput(0)
	set tSC=intcode.Run(pDebug,1)
	set temp=intcode.GetOutput()
	while temp'="" {
		set:'$d(map(posy,posx)) painted=$i(painted)
		set map(posy,posx)=temp
		set tSC=intcode.Run(pDebug,1)
		set temp=intcode.GetOutput()
		if temp=1 {
			set dir=(dir+1)#4
		} else {
			set dir=(dir-1)#4
		}
		if dir=0 {
			set posy=posy-1
		} elseif dir=1 {
			set posx=posx+1
		} elseif dir=2 {
			set posy=posy+1
		} elseif dir=3 {
			set posx=posx-1
		}
		d intcode.AddInput($g(map(posy,posx),0))
		set tSC=intcode.Run(pDebug,1)
		set temp=intcode.GetOutput()
	}
	
	quit painted
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set intcode=##class(AOC.Y2019.Utils.Intcode).%New(11)
	
	set painted=0
	set posx=0
	set posy=0
	// 0=up, 1=right, 2=down, 3=left
	set dir=0
	set map(posy,posx)=1
	d intcode.AddInput(1)
	set tSC=intcode.Run(pDebug,1)
	set temp=intcode.GetOutput()
	while temp'="" {
		set:'$d(map(posy,posx)) painted=$i(painted)
		set map(posy,posx)=temp
		set tSC=intcode.Run(pDebug,1)
		set temp=intcode.GetOutput()
		if temp=1 {
			set dir=(dir+1)#4
		} else {
			set dir=(dir-1)#4
		}
		if dir=0 {
			set posy=posy-1
		} elseif dir=1 {
			set posx=posx+1
		} elseif dir=2 {
			set posy=posy+1
		} elseif dir=3 {
			set posx=posx-1
		}
		d intcode.AddInput($g(map(posy,posx),0))
		set tSC=intcode.Run(pDebug,1)
		set temp=intcode.GetOutput()
	}
	
	do ##class(AOC.Y2019).Print2DArray(.map,1)
	quit ""
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day11).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day11).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
