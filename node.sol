pragma solidity ^0.4.0;
contract node {
    uint id;
    uint[] nearbyNode;
    mapping(uint => uint) sPath;
    constructor (uint assignId) public{
        id=assignId;
        nearbyNode.length=0;
    }
    function addNearby(uint idToAdd,uint charge) public {
        nearbyNode[nearbyNode.length++]=idToAdd;
        sPath[idToAdd]=charge;
    }
    function isNearby(uint testId) public view returns (bool) {
        for (uint i = 0; i < nearbyNode.length; i++)
            if (nearbyNode[i] == testId) return true;
        return false;
    }
    function getNearby() public view returns (uint[]){
        return nearbyNode;
    }
    function getCurrentsPath(uint testId) public constant returns (uint){
        return sPath[testId];
    }

    function setCurrentsPath(uint testId, uint newCharge) public {
        sPath[testId] = newCharge;
    }
    function PreDecided(uint testId) public view returns (bool){
        return sPath[testId]!=0;
    }
}
