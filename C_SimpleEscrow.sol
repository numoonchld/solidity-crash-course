// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

contract SimpleEscrow {
    
    uint public balanceReceived;
    uint public lockedUntil;
    
    // function to receive payments in this smart contract
    function receiveMoney() public payable {
        balanceReceived += msg.value;
        lockedUntil = block.timestamp + 1 minutes;
    }
    
    // function to get balance in this smart contract
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    // withdraw money
    function withdrawMoney() public {
        if (lockedUntil < block.timestamp) {
            address payable to = payable(msg.sender);
            to.transfer(this.getBalance());
        }
    }
    
    // send to particular address 
    function withdrawMoneyTo(address payable _to) public {
        if (lockedUntil < block.timestamp) {
            _to.transfer(this.getBalance());
        }
        
    }
}