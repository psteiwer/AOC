Class AOC.Utils.Utils
{

ClassMethod ListCount(pList As %List, pValue) As %Integer
{
    Set tRes=0

    Set tPosition=$Listfind(pList,pValue,0)
    While tPosition'=0 {
        Set tRes=$I(tRes)
        Set tPosition=$Listfind(pList,pValue,tPosition)
    }

    Quit tRes
}

}
