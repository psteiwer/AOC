Class AOC.Utils.Graph Extends %RegisteredObject
{

Property Vertices [ MultiDimensional ];

Property Edges [ MultiDimensional ];

Property ShortestDistances [ MultiDimensional ];

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

Method ShortestDistance(pVertex1,pVertex2) As %Integer
{
	Quit:$Data(..ShortestDistances(pVertex1,pVertex2)) ..ShortestDistances(pVertex1,pVertex2)
	
	Set tRes=1E18
	Set tCurrentVertex=pVertex1
	Set tLastDistance=0
	Set tTempGraph(pVertex1)=0
	
	While 1 {
		Set tVertex=$o(..Edges(tCurrentVertex,""))
		While tVertex'="" {
			If '$Data(tTempGraph(tVertex)) {
				Set tTempGraph(tVertex)=..Edges(tCurrentVertex,tVertex)+tLastDistance
			}
			Set tVertex=$o(..Edges(tCurrentVertex,tVertex))
		}
		
		If $Data(tTempGraph(pVertex2)) {
			Set tRes=tTempGraph(pVertex2)
			Set ..ShortestDistances(pVertex1,pVertex2)=tRes
			Set ..ShortestDistances(pVertex2,pVertex1)=tRes
			Quit
		}
		
		Set tShortestVertexName=""
		Set tShortestVertexDistance=1E18
		Set tVertex=$o(tTempGraph(""))
		While tVertex'="" {
			If (tTempGraph(tVertex)<tShortestVertexDistance)&&('$Data(tShortestGraph(tVertex))) {
				Set tShortestVertexDistance=tTempGraph(tVertex)
				Set tShortestVertexName=tVertex
			}
			Set tVertex=$o(tTempGraph(tVertex))
		}
		
		Set tShortestGraph(tShortestVertexName)=tShortestVertexDistance
		Set ..ShortestDistances(pVertex1,tShortestVertexName)=tShortestVertexDistance
		Set ..ShortestDistances(tShortestVertexName,pVertex1)=tShortestVertexDistance
		
		Set tLastDistance=tShortestVertexDistance
		Set tCurrentVertex=tShortestVertexName
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