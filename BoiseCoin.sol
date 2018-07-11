pragma solidity ^0.4.24;                                                        

contract BoiseCoin {

    mapping (address => uint256) public balanceOf;

    // Initialize contract with initial supply tokens assigned to
    // the creator of the contract
    constructor(uint256 initialSupply) public {
        balanceOf[msg.sender] = initialSupply;
    }

    function transfer(address _to, uint256 _value) public {
        // Check if the sender has enough
        require(balanceOf[msg.sender] >= _value);

	// Math is not safe, check for overflows
        require(balanceOf[_to] + _value >= balanceOf[_to]);

        // Subtract from the sender
        balanceOf[msg.sender] -= _value;

        // Add the same to the recipient
        balanceOf[_to] += _value;
    }
} 
