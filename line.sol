pragma solidity ^0.4.0;

contract line {
    uint firstId;
    uint secondId;
    uint charge;

    constructor (uint first, uint second, uint c) public payable{
        firstId = first;
        secondId = second;
        charge = c;
    }
    function getFirst() public constant returns (uint){
        return firstId;
    }
    function getSecond() public constant returns (uint){
        return secondId;
    }
    function getCharge() public constant returns (uint) {
        return charge;
    }

    function setCharge(uint newCharge) public {
        charge = newCharge;
    }

    function equals(uint first, uint second) public view returns (bool){
        return (firstId == first && secondId == second) || (firstId == second && secondId == first);
    }
}
