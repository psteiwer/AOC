Class AOC.Y2019 Extends AOC.Base
{

PARAMETER Year As %Integer = 2019;

ClassMethod D1P1() As %String
{
	do ##class(AOC.Y2019).GetInput(1,.out)
	
	set res=""
	set pos=$o(out(""),1,l)
	while pos'="" {
		set res=res+((l\3)-2)
		set pos=$o(out(pos),1,l)
	}
	quit res
}

ClassMethod D1P2() As %String
{
	do ##class(AOC.Y2019).GetInput(1,.out)
	
	set res=""
	set pos=$o(out(""),1,l)
	while pos'="" {
		set temp=l
		while temp>0 {
			set temp=((temp\3)-2)
			set:temp>0 res=res+temp
		} 
		set pos=$o(out(pos),1,l)
	}
	quit res
}

ClassMethod D2P1() As %String
{
	do ##class(AOC.Y2019).GetInput(2,.out)
	
	set res=""
	set pos=$o(out(""),1,l)
	while pos'="" {
		set res=res+l
		set pos=$o(out(pos),1,l)
	}
	quit res
}

}