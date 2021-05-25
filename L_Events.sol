// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract Events {
    
    // account balance tracker mapping
    mapping(address => uint) public tokenBalances;
    
    // define event with the values to be sent to the outside world as arguments
    event TokensSent(address _from, address _to, uint _amount);
    
    // initialize tokens for contract creator 
    constructor() {
        tokenBalances[msg.sender] = 100;
    }
    
    // function to tranfer tokens to other accounts 
    function sendToken(address _to, uint _amount) public returns(bool) {
        
        // put in require and assert checks 
        require(tokenBalances[msg.sender] >= _amount, "Insufficient tokens!");
        assert(tokenBalances[_to] + _amount >= tokenBalances[_to]);
        assert(tokenBalances[msg.sender] - _amount <= tokenBalances[msg.sender]);
        
        // perform transfer
        tokenBalances[msg.sender] -= _amount;
        tokenBalances[_to] += _amount;
        
        // emit event that the transfer is complete 
        emit TokensSent(msg.sender, _to, _amount);
        
        // return value for function
        return true;
        
    }
    
}