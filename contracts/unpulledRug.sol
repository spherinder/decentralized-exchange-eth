// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12;
import "contracts/erc20.sol";

contract UnpulledRug is IERC20{
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowances;
    uint _totalSupply=10_000;
    uint8 _decimals=3;
    string _name="UnpulledRug";
    string _symbol="URG";
    constructor() {
        balances[msg.sender]=_totalSupply;
    }
    function name() external view returns (string memory){return _name;}
    function symbol() external view returns (string memory){return _symbol;}
    function decimals() external view returns (uint8){return _decimals;}
    function totalSupply() external view returns (uint){return _totalSupply;}

    function balanceOf(address owner) external view returns (uint){
        return balances[owner];
    }
    function allowance(address owner, address spender) external view returns (uint){
        return allowances[owner][spender];
    }

    function approve(address spender, uint value) external returns (bool){
        allowances[msg.sender][spender]=value;
        emit Approval(msg.sender, spender, value);
        return false;
    }
    function transfer(address to, uint value) external returns (bool){
        if(balances[msg.sender]<value) return false;
        balances[msg.sender]-=value;
        balances[to]+=value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    function transferFrom(address from, address to, uint value) external returns (bool){
        if(balances[from]<value) return false;
        if(allowances[from][msg.sender]<value) return false;
        allowances[from][msg.sender]-=value;
        balances[from]-=value;
        balances[to]+=value;
        emit Transfer(from, to, value);
        return true;
    }

    //event Transfer(address indexed _from, address indexed _to, uint256 _value);
    //event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
