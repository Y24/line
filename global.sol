pragma solidity ^0.4.0;

import "./line.sol";
import "./node.sol";

contract global {
    node[] nodes;
    line[] lines;
    constructor (uint nodeNum, uint lineNum, uint[] allLines) public{
        initNode(nodeNum);
        initLine(lineNum, allLines);
    }
    function getsPath(uint fromId, uint toId) public returns (uint) {
        return 0;
    }

    function initNode(uint nodeNum){
        nodes.length = nodeNum;
        for (uint i = 0; i < nodeNum; i++)
            nodes[i] = new node(i);
    }

    function initLine(uint lineNum, uint[] allLines){
        lines.length = lineNum;
        for (uint i = 0; i < lineNum; i++)
            lines[i] = new line(allLines[3 * i], allLines[3 * i + 1], allLines[3 * i + 2]);
        initNearby();
    }

    function initNearby() {
        for (uint i = 0; i < lines.length; i++) {
            nodes[lines[i].getFirst()].addNearby(lines[i].getSecond(), lines[i].getCharge());
            nodes[lines[i].getSecond()].addNearby(lines[i].getFirst(), lines[i].getCharge());
        }
    }

    function getDirectPath(uint fromId, uint toId) public returns (uint) {
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
