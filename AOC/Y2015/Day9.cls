Class AOC.Y2015.Day9 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 9;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day9).GetInput(..#Day,.pInput)
	
	set res=""
	set graph=##class(AOC.Utils.Graph).%New()
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day9).ParseString(l," = ",.l,.distance)
		do ##class(AOC.Y2015.Day9).ParseString(l," to ",.from,.to)
		do graph.AddVertex(from)
		do graph.AddVertex(to)
		do graph.AddEdge(from,to,distance)
		
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit graph.ShortestTraverse()
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day9).GetInput(..#Day,.pInput)
	
	set res=""
	set graph=##class(AOC.Utils.Graph).%New()
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day9).ParseString(l,,.l)
		do ##class(AOC.Y2015.Day9).ParseString(l," = ",.l,.distance)
		do ##class(AOC.Y2015.Day9).ParseString(l," to ",.from,.to)
		do graph.AddVertex(from)
		do graph.AddVertex(to)
		do graph.AddEdge(from,to,distance)
		
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit graph.LongestTraverse()
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day9).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day9).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
