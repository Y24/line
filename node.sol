pragma solidity ^0.4.0;

import "./global.sol";
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
    function isNearby(uint testId) public returns (bool) {
        for (uint i = 0; i < nearbyNode.length; i++)
            if (nearbyNode[i] == testId) return true;
        return false;
    }
    function getCurrentsPath(uint testId) public constant returns (uint){
        return sPath[testId];
    }

    function setCurrentsPath(uint testId, uint newCharge) public {
        sPath[testId] = newCharge;
    }
}
