Class AOC.Y2015.Day13 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 13;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day13).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day13).ParseString(l,,.l)
		do ##class(AOC.Y2015.Day13).ParseString(l," would ",.p1,.l)
		if $find(l,"gain ") {
			do ##class(AOC.Y2015.Day13).ParseString(l,"gain ",,.l)
			set negation=1
		} else {
			do ##class(AOC.Y2015.Day13).ParseString(l,"lose ",,.l)
			set negation=-1
		}
		do ##class(AOC.Y2015.Day13).ParseString(l," happiness units by sitting next to ",.units,.p2)
		set units=units*negation
		set p2=$e(p2,1,*-1)
		set initial(p1,p2)=units
		
		set pos=$o(pInput(pos),1,l)
	}

	set graph=##class(AOC.Utils.Graph).%New()
	set p1=$O(initial(""))
	while p1'="" {
		set p2=$o(initial(p1,""))
		while p2'="" {
			do graph.AddVertex(p1)
			do graph.AddVertex(p2)
			do graph.AddEdge(p1,p2,initial(p1,p2)+initial(p2,p1))
			set p2=$o(initial(p1,p2))
		}
		set p1=$o(initial(p1))
	}
	
	Quit graph.LongestCycle()
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day13).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day13).ParseString(l,,.l)
		do ##class(AOC.Y2015.Day13).ParseString(l," would ",.p1,.l)
		if $find(l,"gain ") {
			do ##class(AOC.Y2015.Day13).ParseString(l,"gain ",,.l)
			set negation=1
		} else {
			do ##class(AOC.Y2015.Day13).ParseString(l,"lose ",,.l)
			set negation=-1
		}
		do ##class(AOC.Y2015.Day13).ParseString(l," happiness units by sitting next to ",.units,.p2)
		set units=units*negation
		set p2=$e(p2,1,*-1)
		set initial(p1,p2)=units
		
		set pos=$o(pInput(pos),1,l)
	}

	set graph=##class(AOC.Utils.Graph).%New()
	do graph.AddVertex("Me")
	set p1=$O(initial(""))
	while p1'="" {
		do graph.AddEdge(p1,"Me",0)
		set p2=$o(initial(p1,""))
		while p2'="" {
			do graph.AddVertex(p1)
			do graph.AddVertex(p2)
			do graph.AddEdge(p1,p2,initial(p1,p2)+initial(p2,p1))
			do graph.AddEdge(p1,p2,initial(p1,p2)+initial(p2,p1))
			set p2=$o(initial(p1,p2))
		}
		set p1=$o(initial(p1))
	}
	
	Quit graph.LongestCycle()
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day13).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day13).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
