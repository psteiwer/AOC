Class AOC.Y2015.Day14 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 14;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day14).GetInput(..#Day,.pInput)

	set tRaceTime=2503

	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day14).ParseString(l,,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l," can fly ",.name,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l," km/s for ",.speed,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l," seconds, but then must rest for ",.flytime,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l," seconds.",.resttime,.l)
		
		set reindeer(name)=$lb(speed,flytime,resttime)
		
		set pos=$o(pInput(pos),1,l)
	}

	set maxdistance=0
	set name=$o(reindeer(""))
	while name'="" {
		set ttime=0
		set tdistance=0
		set tspeed=$LG(reindeer(name),1)
		set tflytime=$LG(reindeer(name),2)
		set tresttime=$LG(reindeer(name),3)
		while ttime<tRaceTime {
			for i=1:1:tflytime {
				set ttime=ttime+1
				set tdistance=tdistance+tspeed
				if ttime>=tRaceTime {
					quit
				}
			}
			set ttime=ttime+tresttime
		}

		if tdistance>maxdistance {
			set maxdistance=tdistance
		}
		set name=$o(reindeer(name))
	}

	Quit maxdistance
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2015.Day14).GetInput(..#Day,.pInput)

	set tRaceTime=2503

	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day14).ParseString(l,,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l," can fly ",.name,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l," km/s for ",.speed,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l," seconds, but then must rest for ",.flytime,.l)
		do ##class(AOC.Y2015.Day14).ParseString(l," seconds.",.resttime,.l)
		
		set reindeer(name)=$lb(speed,flytime,resttime)
		set reindeer(name,"distance")=0
		
		set pos=$o(pInput(pos),1,l)
	}

	set maxdistance=0
	for i=0:1:tRaceTime-1 {
		set name=$o(reindeer(""))
		while name'="" {
			set ttime=0
			set tspeed=$LG(reindeer(name),1)
			set tflytime=$LG(reindeer(name),2)
			set tresttime=$LG(reindeer(name),3)
			
			set notresting=(i#(tflytime+tresttime))<tflytime
			if notresting {
				set reindeer(name,"distance")=reindeer(name,"distance")+tspeed
			}

			if reindeer(name,"distance")>maxdistance {
				set maxdistance=reindeer(name,"distance")
			}
			set name=$o(reindeer(name))
		}

		// loop through distance and if = to maxdistance, add 1 point
		set name=$o(reindeer(""))
		while name'="" {
			if reindeer(name,"distance")=maxdistance {
				set reindeer(name,"points")=$G(reindeer(name,"points"),0)+1
				if res<reindeer(name,"points") {
					set res=reindeer(name,"points")	
				}
			}
			set name=$o(reindeer(name))
		}
	}

	Quit res
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day14).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day14).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
