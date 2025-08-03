pragma solidity ^0.4.25;
contract Suicidal{
    function kill() public{
        selfdestruct(msg.sender);
    }
}
