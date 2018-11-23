pragma solidity ^0.4.0;
//import "remix_tests.sol"; // this import is automatically injected by Remix.
import "./global.sol";

contract test {
    global globalToTest;
    function beforeAll () public {
        uint[] memory lines= new uint[](15);
        for(uint i=2;i<=5;i++)
            lines[3*i-1]=1;
        lines[2]=100;
        for(uint j=0;j<4;j++){
            lines[3*j]=j;
            lines[3*j+1]=j+1;
        }
        lines[12]=4;
        lines[13]=0;

        //[0, 1, 100, 1, 2, 1, 2, 3, 1, 3, 4, 1,  4 , 0 , 1]
        globalToTest = new global(5,5,lines);
        globalToTest.calculatesPath(0,1);
    }
    function checksPathWithReturnValue () public constant returns (bool) {
        return globalToTest.getsPath() == uint(4);
    }
}
