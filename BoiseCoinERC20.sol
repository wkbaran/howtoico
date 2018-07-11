pragma solidity ^0.4.24;

interface ERC20 {
    function name() constant external returns (string);
    function symbol() constant external returns (string);
    function decimals() constant external returns (uint8);
    function totalSupply() constant external returns (uint256);
    function balanceOf(
        address tokenOwner) view external returns (uint256);

    function transfer(address to, uint tokens
        ) external returns (bool success);

    function transferFrom(address from, address to, uint tokens
      ) external returns (bool success);
    function approve(address spender, uint tokens
      ) external returns (bool success);
    function allowance(address tokenOwner, address spender
      ) external view returns (uint remaining);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(
      address indexed tokenOwner, address indexed spender, uint tokens);
}

library SafeMath {
    function add(uint a, uint b) internal pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }                                                                           
    function sub(uint a, uint b) internal pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }

    function mul(uint a, uint b) internal pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }

    function div(uint a, uint b) internal pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

contract BoiseCoinERC20 is ERC20 {
    using SafeMath for uint;                                                    

    function name() constant external returns (string) {
        return "Boise's Best Token";
    }
    
    function symbol() constant external returns (string) {
        return "BCO";
    }
    
    function decimals() constant external returns (uint8) {
        return 0;
    }
    
    uint256 _totalSupply = 300000;
    
    function totalSupply() constant external returns (uint256) {
        return _totalSupply;
    }

    constructor () public {
        balances[msg.sender] = _totalSupply;
    }

    mapping(address => uint256) public balances;
    
    function balanceOf(address tokenOwner) view external returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        balances[msg.sender] = balances[msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    mapping(address => mapping(address => uint256)) allowed;

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        balances[from] = balances[from].sub(tokens);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }

    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }
}
