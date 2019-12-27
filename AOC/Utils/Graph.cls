Class AOC.Utils.Graph Extends %RegisteredObject
{

Property Nodes [ MultiDimensional ];

Property Edges [ MultiDimensional ];

Method AddNode(pName="",pValue="") As %Status
{
	Set tSC=$$$OK
	
	If pName="" {
		Set tSC=$$$ERROR("Node name cannot be empty")
	} ElseIf $Data(..Nodes(pName)) {
		Set tSC=$$$ERROR("Node name must be unique")
	} Else {
		Set ..Nodes(pName)=pValue
	}
	
	Quit tSC
}

Method RemoveNode(pName="") As %Status
{
	Set tSC=$$$OK
	
	Set tEdge=$o(..Edges(pName,""))
	While tEdge'="" {
		Do ..RemoveEdge(pName,tEdge)
		Set tEdge=$o(..Edges(pName,tEdge))
	}
	
	Kill ..Nodes(pName)
	
	Quit tSC
}

Method AddEdge(pNode1="", pNode2="", pDistance=0) As %Status
{
	Set tSC=$$$OK
	
	Set ..Edges(pNode1,pNode2)=pDistance
	Set ..Edges(pNode2,pNode1)=pDistance
	
	Quit tSC
}

Method RemoveEdge(pNode1, pNode2) As %Status
{
	Set tSC=$$$OK
	
	Kill ..Edges(pNode1,pNode2)
	Kill ..Edges(pNode2,pNode1)
	
	Quit tSC
}

Method ShortestDistance(pNode1,pNode2,pDistance=0,ByRef pTested) As %Integer
{
	Set tRes=1E18
	
	// Recurse through all of pNode1 Edges
	Set tNode=$o(..Edges(pNode1,""))
	While tNode'="" {
		If tNode=pNode2 {
			// Once pNode2 is found, return total distance
			Return pDistance+..Edges(pNode1,tNode)
		} ElseIf '$Data(pTested(pNode1,tNode)) {
			Merge tTested=pTested
			Set tTested(pNode1,tNode)=1
			Set tTested(tNode,pNode1)=1
			
			Set tTemp=..ShortestDistance(tNode,pNode2,pDistance+..Edges(pNode1,tNode),.tTested)
			// If tTemp has a lower value than tRes, update tRes
			Set:tTemp<tRes tRes=tTemp
		}
		Set tNode=$o(..Edges(pNode1,tNode))
	}
	
	Quit tRes
}

}