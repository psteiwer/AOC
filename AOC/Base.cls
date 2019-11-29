Class AOC.Base
{

PARAMETER Year As %Integer;

ClassMethod GetInput(day, Output out) As %Status
{
		set st=$$$OK
		try {
			set path="C:\Users\psteiwer\Documents\AOC\Y"_..#Year_"\day"_day_".txt"
			set file=##class(%Stream.FileCharacter).%New()
			do file.LinkToFile(path)
			while 'file.AtEnd {
				set str=file.ReadLine()
				set out($i(out))=str
			}
		} catch ex {
			set st=ex.AsStatus()
		}
		
		quit st
}

}