pragma solidity ^0.4.24;

contract TokenReg {
    struct Token {
        address addr;
        string tla;
        uint base;
        string name;
        address owner;
        mapping (bytes32 => bytes32) meta;
    }

    function unregister(uint _id);

    function setFee(uint _fee) only_owner { fee = _fee; }

    function tokenCount() constant returns (uint) { return tokens.length; }

    function token(uint _id) constant returns (
        address addr, string tla, uint base, string name, address owner);

    function fromAddress(address _addr) constant returns (
        uint id, string tla, uint base, string name, address owner);

    function fromTLA(string _tla) constant returns (
        uint id, address addr, uint base, string name, address owner);

    event Registered(
        string indexed tla,
        uint indexed id,
        address addr,
        string name);

    event Unregistered(
        string indexed tla,
        uint indexed id);

    event MetaChanged(
        uint indexed id,
        bytes32 indexed key,
        bytes32 value);

    function register(
        address _addr,
        string _tla,
        uint _base,
        string _name) returns (bool);

    function registerAs(
        address _addr,
        string _tla,
        uint _base,
        string _name,
        address _owner) returns (bool);
}
