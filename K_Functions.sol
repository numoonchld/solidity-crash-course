// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract Functions {
    
    // hold balance of accounts that deposit funds into this contract 
    mapping(address => uint) public accountBalances;
    
    // contract deployer address
    address public owner; 
    
    // set owner address at contract deployment
    constructor() {
        owner = msg.sender;
    }
    
    // (view function): function to get owner address 
    function getOwner() public view returns(address) {
        return owner;
    }
    
    // (pure function): function to convert WEI to ETH 
    function convertWEItoETH(uint _amountWEI) public pure returns(uint) {
        return _amountWEI / 1 ether;
    }
    
    // function to receive funds into contract
    function receiveFunds() public payable {
        assert(accountBalances[msg.sender] + msg.value >= accountBalances[msg.sender] );
        accountBalances[msg.sender] += msg.value;
    }
    
    // function to withdraw funds from contract to a target address
    function withdrawFunds(address payable _to, uint _amount) public {
        require(accountBalances[msg.sender] >= _amount, 'Insufficient Funds available Contract Account!');
        assert(accountBalances[msg.sender] - _amount <= accountBalances[msg.sender] );
        _to.transfer(_amount);
    }
    
    // function to self destroy Contract
    function destroySelf() public {
        require(msg.sender == owner, "You're not the contract owner");
        selfdestruct(payable(owner));
    }
    
    // FALLBACK: receive()
    receive() external payable {
        receiveFunds();
    }
}