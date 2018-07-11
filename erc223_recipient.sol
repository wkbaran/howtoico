pragma solidity ^0.4.24;

interface ERC223_receiver is ERC20 {
    function tokenFallback(address _from, uint _value, bytes _data)
}
