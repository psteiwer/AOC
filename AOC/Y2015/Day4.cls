Class AOC.Y2015.Day4 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 4;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set:pInput="" pInput="bgvyzdsv"
	//Do ##class(AOC.Y2015.Day4).GetInput(..#Day,.pInput)
	
	set res=""
	while 1 {
		set res=$i(res)
		set temp=##class(%SYSTEM.Encryption).MD5Hash(pInput_res)
		if ($ascii($e(temp,1))=0)&&($ascii($e(temp,2))=0)&&($ascii($e(temp,3))<10) {
			quit
		}
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set:pInput="" pInput="bgvyzdsv"
	//Do ##class(AOC.Y2015.Day4).GetInput(..#Day,.pInput)
	
	set res=""
	while 1 {
		set res=$i(res)
		set temp=##class(%SYSTEM.Encryption).MD5Hash(pInput_res)
		if ($ascii($e(temp,1))=0)&&($ascii($e(temp,2))=0)&&($ascii($e(temp,3))=0) {
			quit
		}
	}
	
	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day4).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day4).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
