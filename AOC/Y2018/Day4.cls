Class AOC.Y2018.Day4 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 4;

Parameter Year = 2018;

ClassMethod Part1(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day4).GetInput(..#Day,.pInput)
	
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		set time=$piece(l," ",1,2)
		set action=$piece(l," ",3,*)
		
		set timeline(time)=action
		
		set pos=$o(pInput(pos),1,l)
	}
	
	set guard=""
	set sleepstart=""
	set time=$o(timeline(""),1,action)
	while time'="" {
		if $e(action,1)="G" {
			set guard=$e($piece(action," ",2),2,*)
		} else {
			set min=$e($piece(time,":",2),1,*-1)
			if $e(action,1)="f" {
				set sleepstart=min
			} elseif $e(action,1)="w" {
				set sleepend=min
				for i=sleepstart:1:min {
					set sleeptimes(guard,i)=$i(sleeptimes(guard,i))
					set sleeptimes(guard)=$i(sleeptimes(guard))
				}
			}
		}
		
		set time=$o(timeline(time),1,action)
	}
	
	set maxtime=0
	set maxguard=""
	set g=$o(sleeptimes(""),1,n)
	while g'="" {
		if n>maxtime {
			set maxguard=g
			set maxtime=n
		}
		set g=$o(sleeptimes(g),1,n)
	}
	
	set maxmin=0
	set maxpos=""
	set m=$o(sleeptimes(maxguard,""),1,n)
	while m'="" {
		if n>maxmin {
			set maxpos=m
			set maxmin=n
		}
		set m=$o(sleeptimes(maxguard,m),1,n)
	}

	quit maxpos*maxguard
}

ClassMethod Part2(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Do ##class(AOC.Y2018.Day4).GetInput(..#Day,.pInput)
	
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		set time=$piece(l," ",1,2)
		set action=$piece(l," ",3,*)
		
		set timeline(time)=action
		
		set pos=$o(pInput(pos),1,l)
	}
	
	set guard=""
	set sleepstart=""
	set time=$o(timeline(""),1,action)
	while time'="" {
		if $e(action,1)="G" {
			set guard=$e($piece(action," ",2),2,*)
		} else {
			set min=$e($piece(time,":",2),1,*-1)
			if $e(action,1)="f" {
				set sleepstart=min
			} elseif $e(action,1)="w" {
				set sleepend=min
				for i=sleepstart:1:min {
					set sleeptimes(guard,i)=$i(sleeptimes(guard,i))
					set sleeptimes(guard)=$i(sleeptimes(guard))
				}
			}
		}
		
		set time=$o(timeline(time),1,action)
	}
	
	set maxmin=0
	set maxpos=""
	set maxguard=""
	set g=$o(sleeptimes(""))
	while g'="" {
		set m=$o(sleeptimes(g,""),1,n)
		while m'="" {
			if n>maxmin {
				set maxpos=m
				set maxmin=n
				set maxguard=g
			}
			set m=$o(sleeptimes(g,m),1,n)
		}
		set g=$o(sleeptimes(g))
	}

	quit maxpos*maxguard
}

ClassMethod Run(pInput = "",  pDebug = 0,  pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2018.Day4).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2018.Day4).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
