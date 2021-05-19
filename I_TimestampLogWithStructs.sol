// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

// structs are used to create custom data types like Objects in Python 
contract Structs{
    
    // Struct to hold a Payment 
    struct Payment {
        uint amount;
        uint timestamp;
    }
    
    // Struct to hold Balance, and Payment Details
    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }
    
    // Mapping to Hold Balance 
    mapping(address => Balance) public balanceReceived;
    
    // Function to view Contract Balance
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    // Function to receive funds into contract
    function receiveFunds() public payable {
        balanceReceived[msg.sender].totalBalance += msg.value;
        
        Payment memory payment = Payment(msg.value, block.timestamp);
        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;
        balanceReceived[msg.sender].numPayments++;
    }
    
    // Function to Withdraw Funds from Account
    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender].totalBalance, 'Insufficient Funds!');
        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    } 
    
    // Function to Withdraw All Funds from Account
    function withdrawAllMoney(address payable _to) public {
        uint balanceToSend = balanceReceived[msg.sender].totalBalance;
        balanceReceived[msg.sender].totalBalance = 0;
        _to.transfer(balanceToSend);
    }
}