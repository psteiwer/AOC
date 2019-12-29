Class AOC.Y2019.Day7 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 7;

Parameter Year = 2019;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	set res=0
	for a=0:1:4 {
		for b=0:1:4 {
			continue:b=a
			for c=0:1:4 {
				continue:((c=a)||(c=b))
				for d=0:1:4 {
					continue:((d=a)||(d=b)||(d=c))
					for e=0:1:4 {
						continue:((e=a)||(e=b)||(e=c)||(e=d))
						Set intcodeA=##class(AOC.Y2019.Utils.Intcode).%New(7)
						D intcodeA.AddInput(a)
						D intcodeA.AddInput(0)
						Set intcodeB=##class(AOC.Y2019.Utils.Intcode).%New(7)
						D intcodeB.AddInput(b)
						Set intcodeC=##class(AOC.Y2019.Utils.Intcode).%New(7)
						D intcodeC.AddInput(c)
						Set intcodeD=##class(AOC.Y2019.Utils.Intcode).%New(7)
						D intcodeD.AddInput(d)
						Set intcodeE=##class(AOC.Y2019.Utils.Intcode).%New(7)
						D intcodeE.AddInput(e)
						
						set tSC=intcodeA.Run(pDebug)
						D intcodeB.AddInput(intcodeA.GetOutput())
						
						set tSC=intcodeB.Run(pDebug)
						D intcodeC.AddInput(intcodeB.GetOutput())
						
						set tSC=intcodeC.Run(pDebug)
						D intcodeD.AddInput(intcodeC.GetOutput())
						
						set tSC=intcodeD.Run(pDebug)
						D intcodeE.AddInput(intcodeD.GetOutput())
						
						set tSC=intcodeE.Run(pDebug)
						set temp=intcodeE.GetOutput()
						set:temp>res res=temp
					}
				}
			}
		}
	}
	quit res
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	set res=0
	for a=5:1:9 {
		for b=5:1:9 {
			continue:b=a
			for c=5:1:9 {
				continue:((c=a)||(c=b))
				for d=5:1:9 {
					continue:((d=a)||(d=b)||(d=c))
					for e=5:1:9 {
						continue:((e=a)||(e=b)||(e=c)||(e=d))
						Set intcodeA=##class(AOC.Y2019.Utils.Intcode).%New(7)
						D intcodeA.AddInput(a)
						D intcodeA.AddInput(0)
						Set intcodeB=##class(AOC.Y2019.Utils.Intcode).%New(7)
						D intcodeB.AddInput(b)
						Set intcodeC=##class(AOC.Y2019.Utils.Intcode).%New(7)
						D intcodeC.AddInput(c)
						Set intcodeD=##class(AOC.Y2019.Utils.Intcode).%New(7)
						D intcodeD.AddInput(d)
						Set intcodeE=##class(AOC.Y2019.Utils.Intcode).%New(7)
						D intcodeE.AddInput(e)
						
						set lastEoutput=""
						While 1 {
							set tSC=intcodeA.Run(pDebug,1)
							set temp=intcodeA.GetOutput()
							D intcodeB.AddInput(temp)
							
							set tSC=intcodeB.Run(pDebug,1)
							set temp=intcodeB.GetOutput()
							D intcodeC.AddInput(temp)
							
							set tSC=intcodeC.Run(pDebug,1)
							set temp=intcodeC.GetOutput()
							D intcodeD.AddInput(temp)
							
							set tSC=intcodeD.Run(pDebug,1)
							set temp=intcodeD.GetOutput()
							D intcodeE.AddInput(temp)
							
							set tSC=intcodeE.Run(pDebug,1)
							if intcodeE.Finished {
								set:lastEoutput>res res=lastEoutput
								quit
							} Else {
								set lastEoutput=intcodeE.GetOutput()
								D intcodeA.AddInput(lastEoutput)
							}
						}
					}
				}
			}
		}
	}
	quit res
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day7).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day7).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
