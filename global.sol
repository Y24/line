pragma solidity ^0.4.0;

import "./line.sol";
import "./node.sol";

contract global {
    uint result;
    node[] nodes;
    line[] lines;
    constructor (uint nodeNum, uint lineNum, uint[] allLines) public{
        initNode(nodeNum);
        initLine(lineNum, allLines);
    }
    function getsPath() public view returns (uint){
        return result;
    }
    function calculatesPath(uint fromId, uint toId) public {
        updatesPath(toId);
        result=nodes[fromId].getCurrentsPath(toId);
    }
    function updatesPath(uint idToUpdate) internal{
        bool re=false;
        do {
            for(uint i=0;i<nodes.length;i++)
                if(i!=idToUpdate&&!nodes[idToUpdate].isNearby(i)){
                    uint tmp=nodes[i].getCurrentsPath(idToUpdate);
                    nodes[i].setCurrentsPath(idToUpdate,judge(i,idToUpdate));
                    if(tmp!=nodes[i].getCurrentsPath(idToUpdate))
                        re=true;
                }
        } while(re);
    }
    function judge(uint idToJudge,uint objectId) internal view returns (uint){
        uint[] memory nearbyNodes = nodes[idToJudge].getNearby();
        uint comparedResult=0;
        uint flag=0;
        for(uint i=0;i<nearbyNodes.length;i++){
            if(nodes[nearbyNodes[i]].PreDecided(objectId)){
                comparedResult=nodes[nearbyNodes[i]].getCurrentsPath(objectId)+nodes[idToJudge].getCurrentsPath(nearbyNodes[j]);
                flag=i;
                break;
            }
        }
        for(uint j=flag;j<nearbyNodes.length;j++){
            uint tmp=nodes[nearbyNodes[j]].getCurrentsPath(objectId)+nodes[idToJudge].getCurrentsPath(nearbyNodes[j]);
            if(nodes[nearbyNodes[j]].PreDecided(objectId)&&tmp<comparedResult)
                comparedResult=tmp;
        }
        return comparedResult;
    }
    function initOtherNode(uint objectId) internal{
        for(uint i=0;i<nodes.length;i++)
            if(i!=objectId&&!nodes[objectId].isNearby(i))
                nodes[i].setCurrentsPath(i,0);

    }
    function initNode(uint nodeNum) internal{
        nodes.length = nodeNum;
        for (uint i = 0; i < nodeNum; i++)
            nodes[i] = new node(i);
    }

    function initLine(uint lineNum, uint[] allLines) internal{
        lines.length = lineNum;
        for (uint i = 0; i < lineNum; i++)
            lines[i] = new line(allLines[3 * i], allLines[3 * i + 1], allLines[3 * i + 2]);
        initNearby();
    }

    function initNearby() internal{
        for (uint i = 0; i < lines.length; i++) {
            nodes[lines[i].getFirst()].addNearby(lines[i].getSecond(), lines[i].getCharge());
            nodes[lines[i].getSecond()].addNearby(lines[i].getFirst(), lines[i].getCharge());
        }
    }

    function getDirectPath(uint fromId, uint toId) public view returns (uint) {
        for (uint i = 0; i < lines.length; i++)
            if (lines[i].equals(fromId, toId))
                return lines[i].getCharge();
    }

    function changeLineCharge(uint first, uint second, uint newCharge) public {
        for (uint i = 0; i < lines.length; i++)
            if (lines[i].equals(first, second))
                lines[i].setCharge(newCharge);
        initNode(nodes.length);
        initNearby();
    }

    function deleteLine(uint first, uint second) public {

        for (uint i = 0; i < lines.length; i++)
            if (lines[i].equals(first, second)){
                for (uint j = i; j < lines.length - 1; j++)
                    lines[j] = lines[j + 1];
                break;
            }
        lines.length--;
        initNode(nodes.length);
        initNearby();

    }
}
