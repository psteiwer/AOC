Class AOC.Y2015.Day12 Extends AOC.Base [ ProcedureBlock ]
{

Parameter Day = 12;

Parameter Year = 2015;

ClassMethod Part1(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do:pInput="" ##class(AOC.Y2015.Day12).GetInput(..#Day,.pInput)
	
	set res=""
	set iterators=##class(AOC.Utils.Stack).%New()
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day12).ParseString(l,,.l)
		
		set json = ##class(%DynamicAbstractObject).%FromJSON(l)
		set iterator=json.%GetIterator()
		set hasnext=iterator.%GetNext(.key,.val)
		while hasnext {
			if $IsObject(val) {
				do iterators.Push(iterator)
				set iterator=val.%GetIterator()
			} else {
				set res=res+val
			}
			set hasnext=iterator.%GetNext(.key,.val)
			while (('hasnext)&&(iterators.GetItems()>0)) {
				set iterator=iterators.Pop()
				set hasnext=iterator.%GetNext(.key,.val)
			}
		}
		
		set pos=$o(pInput(pos),1,l)
	}
	
	Quit res
}

ClassMethod Part2(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Do:pInput="" ##class(AOC.Y2015.Day12).GetInput(..#Day,.pInput)
	
	set res=""
	set pos=$o(pInput(""),1,l)
	while pos'="" {
		do ##class(AOC.Y2015.Day12).ParseString(l,,.l)
		
		set json = ##class(%DynamicAbstractObject).%FromJSON(l)
		set iterator=json.%GetIterator()
		set hasnext=iterator.%GetNext(.key,.val)
		set hasred=0
		set tempval=0
		set iterators=0
		while hasnext {
			if '$ISVALIDNUM(key)&&(val="red") {
				set temp=json
				for i=1:1:iterators-1 {
					set temp=temp.%Get(iterators(i,"key"))
				}
				do temp.%Remove(iterators(iterators,"key"))

				set hasred=1
				set hasnext=0
			} else {
				if $IsObject(val) {
					set iterators($i(iterators))=iterator
					set iterators(iterators,"key")=key
					set iterators(iterators,"val")=val
					set iterator=val.%GetIterator()
				}
				set hasnext=iterator.%GetNext(.key,.val)
			}
			while (('hasnext)&&($g(iterators,0)>0)) {
				set iterator=iterators(iterators)
				k iterators(iterators)
				set iterators=iterators-1
				if hasred {
					set iterator=iterators(iterators,"val").%GetIterator()
					set hasnext=iterator.%GetNext(.key,.val)
				} else {
					set hasnext=iterator.%GetNext(.key,.val)
				}
				set hasred=0
			}
		}
		
		set pos=$o(pInput(pos),1,l)
	}

	Set pOutput($i(pOutput))=json.%ToJSON()
	
	Quit ##class(AOC.Y2015.Day12).Part1(.pOutput,pDebug,pWithUI)
}

ClassMethod Run(pInput = "", pDebug = 0, pWithUI = 0) As %String
{
	Set tPart1=##class(AOC.Y2015.Day12).Part1(pInput,pDebug,pWithUI)
	Set tPart2=##class(AOC.Y2015.Day12).Part2(pInput,pDebug,pWithUI)
	
	Write "Part 1:"_tPart1,!
	Write "Part 2:"_tPart2,!
	
	Quit tPart1_","_tPart2
}

}
