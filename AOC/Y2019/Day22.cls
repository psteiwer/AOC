Class AOC.Y2019.Day22 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 22;

Parameter Year = 2019;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day22).GetInput(..#Day,.pInput)
	
	set deck=""
	for i=0:1:10006 {
		set deck=deck_$lb(i)
	}
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019.Day22).ParseString(l,,.l)
		zw:pDebug l
		if l["deal into new stack" {
			set tempdeck=""
			for i=1:1:$ll(deck) {
				set tempdeck=$lb($lg(deck,i))_tempdeck
			}
			set deck=tempdeck
		} elseif l["cut " {
			set tempval=$piece(l,"cut ",2)
			if tempval>0 {
				set deck=$list(deck,tempval+1,*)_$list(deck,1,tempval)
			} else {
				set tempval=$zabs(tempval)
				set deck=$list(deck,*-tempval+1,*)_$list(deck,1,*-tempval)
			}
		} elseif l["deal with increment " {
			set tempval=$piece(l,"deal with increment ",2)
			set count=0
			set i=0
			while count<$ll(deck) {
				set count=$i(count)
				set $list(tempdeck,((tempval*(count-1))#$ll(deck))+1)=$lg(deck,count)
			}
			set deck=tempdeck
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	zw:pDebug deck
	for i=1:1:$ll(deck) {
		if $lg(deck,i)="2019" {
			set res=i-1
			quit
		}
	}
	quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do ##class(AOC.Y2019.Day22).GetInput(..#Day,.pInput)
	
	set numcards=119315717514047
	set numshuffles=101741582076661
	set cardatpos=2020
	
	set vals(0)=cardatpos
	set res=""
	
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2019.Day22).ParseString(l,,.l)
		if l["deal into new stack" {
			set cardatpos=numcards-cardatpos-1
		} elseif l["cut " {
			set tempval=$piece(l,"cut ",2)
			set cardatpos=(cardatpos-tempval)#numcards
		} elseif l["deal with increment " {
			set tempval=$piece(l,"deal with increment ",2)
			set cardatpos=(-(numcards-cardatpos)*tempval)#numcards
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	set vals(1)=cardatpos
	
	//94676896952648 - too high
	//73686896952648 - too low

	quit cardatpos
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2019.Day22).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2019.Day22).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
