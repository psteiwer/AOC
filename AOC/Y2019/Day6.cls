Class AOC.Y2019.Day6 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 6;

Parameter Year = 2019;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do:((pInput="")&&($D(pInput)'=10)) ##class(AOC.Y2019.Day6).GetInput(..#Day,.pInput)
	
	set graph=##class(AOC.Utils.Graph).%New()
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019.Day6).ParseString(l,")",.a,.b)
		
		d graph.AddVertex(a)
		d graph.AddVertex(b)
		d graph.AddEdge(a,b,1)
		
		set pos=$o(pInput(pos),1,l)
	}
	
	set vertices=graph.GetListOfVertices()
	for i=1:1:$ll(vertices) {
		set res=res+graph.ShortestDistance("COM",$lg(vertices,i))
	}
	
	quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do:((pInput="")&&($D(pInput)'=10)) ##class(AOC.Y2019.Day6).GetInput(..#Day,.pInput)
	
	set graph=##class(AOC.Utils.Graph).%New()
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019.Day6).ParseString(l,")",.a,.b)
		
		d graph.AddVertex(a)
		d graph.AddVertex(b)
		d graph.AddEdge(a,b,1)
		
		set pos=$o(pInput(pos),1,l)
	}
	
	quit graph.ShortestDistance("YOU","SAN")-2
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day6).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day6).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
