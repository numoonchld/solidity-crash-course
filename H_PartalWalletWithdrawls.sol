// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract PartialWithdrawl {
    
    // account-balance mapping database variable
    mapping(address => uint) public accountBalance;
    
    // function to view entire contract balance
    function viewContractBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    // function to receive funds into contract
    function receiveFunds() public payable {
        accountBalance[msg.sender] += msg.value;
    }
    
    // function to withdraw partial funds from active address to target address
    function withdrawPartials(address payable _to, uint _amount) public {
        require(accountBalance[msg.sender] >= _amount, 'Insufficient Funds in your Contract Account!');
        accountBalance[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    
}