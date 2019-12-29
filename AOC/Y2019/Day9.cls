Class AOC.Y2019.Day9 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 9;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set intcode=##class(AOC.Y2019.Utils.Intcode).%New(9)
	D intcode.AddInput(1)
	set tSC=intcode.Run(pDebug)
	set temp=intcode.GetOutput()
	while temp'="" {
		set res=temp
		set temp=intcode.GetOutput()
	}
	quit res
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set intcode=##class(AOC.Y2019.Utils.Intcode).%New(9)
	D intcode.AddInput(2)
	set tSC=intcode.Run(pDebug)
	set temp=intcode.GetOutput()
	while temp'="" {
		set res=temp
		set temp=intcode.GetOutput()
	}
	quit res
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day9).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day9).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
