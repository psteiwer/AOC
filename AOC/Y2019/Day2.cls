Class AOC.Y2019.Day2 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 2;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set intcode=##class(AOC.Y2019.Utils.Intcode).%New(2)
	Do intcode.SetInstruction(12,1)
	Do intcode.SetInstruction(2,2)
	set tSC=intcode.Run(pDebug)
	
	quit intcode.GetInstruction(0)
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	for x=0:1:99 {
		for y=0:1:99 {
			Set intcode=##class(AOC.Y2019.Utils.Intcode).%New(2)
			Do intcode.SetInstruction(x,1)
			Do intcode.SetInstruction(y,2)
			set tSC=intcode.Run(pDebug)
			
			if intcode.GetInstruction(0)=19690720 {
				return (100*x+y)
			}
		}
		if intcode.GetInstruction(0)=19690720 {
			quit
		}
	}
	quit intcode.GetInstruction(0)
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day2).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day2).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
