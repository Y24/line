pragma solidity ^0.4.0;
contract node {
    uint id;
    uint[] nearbyNode;
    uint sPath;
    constructor (uint assignId) public payable{
        id=assignId;
        nearbyNode.length=0;
        sPath=0;
    }
    function addNearby(uint idToAdd) public {
        nearbyNode[nearbyNode.length++]=idToAdd;
    }
    function isNearby(uint testId) public view returns (bool) {
        for (uint i = 0; i < nearbyNode.length; i++)
            if (nearbyNode[i] == testId) return true;
        return false;
    }
    function getNearby() public view returns (uint[]){
        uint[] memory near=new uint[](nearbyNode.length);
        for(uint i=0;i<near.length;i++)
            near[i]=nearbyNode[i];
        return near;
    }
    function getCurrentsPath() public constant returns (uint){
        return sPath;
    }

    function setCurrentsPath(uint newCharge) public {
        sPath = newCharge;
    }
    function PreDecided() public view returns (bool){
        return sPath!=0;
    }
}
