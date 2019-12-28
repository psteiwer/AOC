Class AOC.Utils.Graph Extends %RegisteredObject
{

Property Vertices [ MultiDimensional ];

Property Edges [ MultiDimensional ];

Method AddVertex(pName="",pValue="") As %Status
{
	Set tSC=$$$OK
	
	If pName="" {
		Set tSC=$$$ERROR("Vertex name cannot be empty")
	} ElseIf $Data(..Vertices(pName)) {
		Set tSC=$$$ERROR("Vertex name must be unique")
	} Else {
		Set ..Vertices(pName)=pValue
	}
	
	Quit tSC
}

Method RemoveVertex(pName="") As %Status
{
	Set tSC=$$$OK
	
	Set tEdge=$o(..Edges(pName,""))
	While tEdge'="" {
		Do ..RemoveEdge(pName,tEdge)
		Set tEdge=$o(..Edges(pName,tEdge))
	}
	
	Kill ..Vertices(pName)
	
	Quit tSC
}

Method AddEdge(pVertex1="", pVertex2="", pDistance=0) As %Status
{
	Set tSC=$$$OK
	
	Set ..Edges(pVertex1,pVertex2)=pDistance
	Set ..Edges(pVertex2,pVertex1)=pDistance
	
	Quit tSC
}

Method RemoveEdge(pVertex1, pVertex2) As %Status
{
	Set tSC=$$$OK
	
	Kill ..Edges(pVertex1,pVertex2)
	Kill ..Edges(pVertex2,pVertex1)
	
	Quit tSC
}


Method ShortestDistance(pVertex1,pVertex2,pDistance=0,ByRef pTested) As %Integer
{
	Set tRes=1E18
	
	// Recurse through all of pVertex1 Edges
	Set tVertex=$o(..Edges(pVertex1,""))
	While tVertex'="" {
		If tVertex=pVertex2 {
			// Once pVertex2 is found, return total distance
			Return pDistance+..Edges(pVertex1,tVertex)
		} ElseIf '$Data(pTested(pVertex1,tVertex)) {
			Merge tTested=pTested
			Set tTested(pVertex1,tVertex)=1
			Set tTested(tVertex,pVertex1)=1
			
			Set tTemp=..ShortestDistance(tVertex,pVertex2,pDistance+..Edges(pVertex1,tVertex),.tTested)
			// If tTemp has a lower value than tRes, update tRes
			Set:tTemp<tRes tRes=tTemp
		}
		Set tVertex=$o(..Edges(pVertex1,tVertex))
	}
	
	Quit tRes
}

Method GetListOfVertices() As %List
{
	Set tRes=""
	
	Set tVertex=$o(..Vertices(""))
	While tVertex'="" {
		Set tRes=tRes_$lb(tVertex)
		Set tVertex=$o(..Vertices(tVertex))
	}
	
	Quit tRes
}

}