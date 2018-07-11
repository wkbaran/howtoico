pragma solidity ^0.4.24;                                                        

contract BoiseCoinPurchasable {

    // tokens left
    uint256 public uncirculated;
    
    // wei per token
    uint256 public exchangeRate;
    
    address owner;
    
    mapping (address => uint256) public balanceOf;

    // Initialize contract with initial supply and exchange rate,
    // the cost of each token in wei
    constructor(uint256 initialSupply, uint256 xchange) public {
        uncirculated = initialSupply;
        exchangeRate = xchange;
        owner = msg.sender;
    }
    
    function buy () payable public {
        // Check enough remaining
        require(msg.value / exchangeRate < uncirculated);

        uncirculated -= msg.value / exchangeRate;
        balanceOf[msg.sender] += msg.value / exchangeRate;
    }
    
    modifier onlyOwner() {
        if (msg.sender == owner) {
            _;
        }
    }

    function setExchangeRate(uint256 xchange) onlyOwner public {
        exchangeRate = xchange;
    }
    
    function mint(uint256 x) onlyOwner public {
        // test for overflow
        require(uncirculated + x > 0);
        uncirculated += x;
    }
    
    function burn(uint256 y) onlyOwner public {
        require(uncirculated > y);
        uncirculated -= y;
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
