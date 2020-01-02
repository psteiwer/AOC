Class AOC.Generator
{

ClassMethod Create(pYear = "", pDay = "") As %Status
{
	Set tSC=$$$OK
	
	// Create new class
	Set tSC=##class(AOC.Generator).CreateClass(pYear,pDay,.tClass)
	If $$$ISERR(tSC) Quit
	
	// Add Year Parameter
	Set tSC=##class(AOC.Generator).AddParameter("Year",pYear,.tClass)
	If $$$ISERR(tSC) Quit
	
	// Add Day Parameter
	Set tSC=##class(AOC.Generator).AddParameter("Day",pDay,.tClass)
	If $$$ISERR(tSC) Quit
	
	// Add Part1 Method
	Set tSC=##class(AOC.Generator).AddPart(pYear,pDay,1,.tClass)
	If $$$ISERR(tSC) Quit
	
	// Add Part2 Method
	Set tSC=##class(AOC.Generator).AddPart(pYear,pDay,2,.tClass)
	If $$$ISERR(tSC) Quit
	
	// Add Run Method
	Set tSC=##class(AOC.Generator).AddRun(pYear,pDay,.tClass)
	If $$$ISERR(tSC) Quit
	
	// Save & Compile new class
	Set tSC=tClass.%Save()
	If $$$ISERR(tSC) Quit
	
	Set tSC=$SYSTEM.OBJ.Compile(tClass.Name)
	
	Quit tSC
}

ClassMethod CreateClass(pYear, pDay, ByRef pClass As %Dictionary.ClassDefinition) As %Status
{
	Set tSC=$$$OK
	
	// Create new class
	Set pClass=##class(%Dictionary.ClassDefinition).%New("AOC.Y"_pYear_".Day"_pDay)
	Set pClass.Super="AOC.Base"
	Set pClass.ProcedureBlock=1
	
	Quit tSC
}

ClassMethod AddParameter(pParameterName, pParameterValue, ByRef pClass As %Dictionary.ClassDefinition) As %Status
{
	Set tSC=$$$OK
	
	// Add Parameter
	Set tParameter=##class(%Dictionary.ParameterDefinition).%New(pClass.Name_":"_pParameterName)
	Set tParameter.Default=pParameterValue
	Set tSC=pClass.Parameters.Insert(tParameter)
	
	Quit tSC
}

ClassMethod AddPart(pYear, pDay, pPart, ByRef pClass As %Dictionary.ClassDefinition) As %Status
{
	Set tSC=$$$OK
	
	// Add PartN method
	Set tMethodName="Part"_pPart
	Set tMethod=##class(%Dictionary.MethodDefinition).%New(pClass.Name_"||"_tMethodName)
	
	Set tMethod.Name=tMethodName
	Set tMethod.ClassMethod=1
	Set tMethod.FormalSpec="pInput="""", pDebug=0, pWithUI=0"
	Set tMethod.ReturnType="%String"
	
	Do tMethod.Implementation.WriteLine($C(9)_"Do ##class("_pClass.Name_").GetInput(..#Day,.pInput)")
	Do tMethod.Implementation.WriteLine($C(9))
	Do tMethod.Implementation.WriteLine($C(9)_"set res=""""")
	Do tMethod.Implementation.WriteLine($C(9)_"set pos=$o(pInput(""""),1,l)")
	Do tMethod.Implementation.WriteLine($C(9)_"while pos'="""" {")
	Do tMethod.Implementation.WriteLine($C(9)_$C(9)_"do ##class("_pClass.Name_").ParseString(l,,.l)")
	Do tMethod.Implementation.WriteLine($C(9)_$C(9))
	Do tMethod.Implementation.WriteLine($C(9)_$C(9))
	Do tMethod.Implementation.WriteLine($C(9)_$C(9))
	Do tMethod.Implementation.WriteLine($C(9)_$C(9)_"set pos=$o(pInput(pos),1,l)")
	Do tMethod.Implementation.WriteLine($C(9)_"}")
	Do tMethod.Implementation.WriteLine($C(9))
	Do tMethod.Implementation.WriteLine($C(9)_"Quit res")
	
	Do pClass.Methods.Insert(tMethod)
	
	Quit tSC
}

ClassMethod AddRun(pYear, pDay, ByRef pClass As %Dictionary.ClassDefinition) As %Status
{
	Set tSC=$$$OK
	
	// Add Run method
	Set tMethodName="Run"
	Set tMethod=##class(%Dictionary.MethodDefinition).%New(pClass.Name_"||"_tMethodName)
	
	Set tMethod.Name=tMethodName
	Set tMethod.ClassMethod=1
	Set tMethod.FormalSpec="pInput="""", pDebug=0, pWithUI=0"
	Set tMethod.ReturnType="%String"
	
	Do tMethod.Implementation.WriteLine($C(9)_"Set tPart1=##class("_pClass.Name_").Part1(pInput,pDebug,pWithUI)")
	Do tMethod.Implementation.WriteLine($C(9)_"Set tPart2=##class("_pClass.Name_").Part2(pInput,pDebug,pWithUI)")
	Do tMethod.Implementation.WriteLine($C(9))
	Do tMethod.Implementation.WriteLine($C(9)_"Write ""Part 1:""_tPart1,!")
	Do tMethod.Implementation.WriteLine($C(9)_"Write ""Part 2:""_tPart2,!")
	Do tMethod.Implementation.WriteLine($C(9))
	Do tMethod.Implementation.WriteLine($C(9)_"Quit tPart1_"",""_tPart2")
	
	Do pClass.Methods.Insert(tMethod)
	
	Quit tSC
}

}
