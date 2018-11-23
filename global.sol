pragma solidity ^0.4.0;

import "./line.sol";
import "./node.sol";

contract global {
    uint result;
    node[] nodes;
    line[] lines;
    constructor (uint nodeNum, uint lineNum, uint[] allLines) public payable{
        initNode(nodeNum);
        initLine(lineNum, allLines);
    }
    function getsPath() public view returns (uint){
        return result;
    }
    function calculatesPath(uint fromId, uint toId) public {
        initOtherNode(toId);
        updatesPath(toId);
        result=nodes[fromId].getCurrentsPath();
        initNode(nodes.length);
        initNearby();
    }
    function updatesPath(uint idToUpdate) internal{
        bool re=false;
        do {
            re=false;
            for(uint i=0;i<nodes.length;i++)
                if(i!=idToUpdate){
                    uint tmp=nodes[i].getCurrentsPath();
                    nodes[i].setCurrentsPath(judge(i,idToUpdate));
                    if(tmp!=nodes[i].getCurrentsPath()||nodes[i].getCurrentsPath()==0)
                        re=true;
                }
        } while(re);
    }
    function judge(uint idToJudge,uint objectId) internal view returns (uint){
        uint[] memory nearbyNodes = nodes[idToJudge].getNearby();
        uint comparedResult=nodes[idToJudge].getCurrentsPath();
        uint startFlag=0;
        if(comparedResult==0)
            for(uint i=0;i<nearbyNodes.length;i++)
                if(nearbyNodes[i]!=objectId&&nodes[nearbyNodes[i]].PreDecided()){
                    comparedResult=nodes[nearbyNodes[i]].getCurrentsPath()+getDirectPath(idToJudge,nearbyNodes[i]);
                    startFlag=i+1;
                    break;
                }
        for(uint j=startFlag;j<nearbyNodes.length;j++){
            if(nearbyNodes[j]!=objectId){
                uint tmp=nodes[nearbyNodes[j]].getCurrentsPath()+getDirectPath(idToJudge,nearbyNodes[j]);
                if(nodes[nearbyNodes[j]].PreDecided()&&tmp<comparedResult)
                    comparedResult=tmp;
            }
        }
        return comparedResult;
    }
    function initOtherNode(uint objectId) internal{
        for(uint i=0;i<nodes.length;i++)
            if(i!=objectId){
                if (!nodes[objectId].isNearby(i))
                    nodes[i].setCurrentsPath(0);
                else nodes[i].setCurrentsPath(getDirectPath(i,objectId));
            }
    }
    function initNode(uint nodeNum) internal{
        nodes.length=nodeNum;
        for (uint i = 0; i < nodeNum; i++)
            nodes[i] = new node(i);
    }

    function initLine(uint lineNum, uint[] allLines) internal{
        lines.length=lineNum;
        for (uint i = 0; i < lineNum; i++)
            lines[i] = new line(allLines[3 * i], allLines[3 * i + 1], allLines[3 * i + 2]);
        initNearby();
    }

    function initNearby() internal{
        for (uint i = 0; i < lines.length; i++) {
            nodes[lines[i].getFirst()].addNearby(lines[i].getSecond());
            nodes[lines[i].getSecond()].addNearby(lines[i].getFirst());
        }
    }

    function getDirectPath(uint fromId, uint toId) public view returns (uint) {
        for (uint i = 0; i < lines.length; i++)
            if (lines[i].equals(fromId, toId))
                return lines[i].getCharge();
        return 0;
    }

    function changeLineCharge(uint first, uint second, uint newCharge) public {
        for (uint i = 0; i < lines.length; i++)
            if (lines[i].equals(first, second)) {
                lines[i].setCharge(newCharge);
                break;
            }
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
