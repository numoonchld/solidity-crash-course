// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract StructsMappingsPublicWallet {
    
    // function to view current balance
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    // function to receive funds into this contract 
    function receiveFunds() public payable {}
    
    // function to withdraw funds from contract into specified address
    function withdrawAllFunds(address payable _to) public {
        _to.transfer(address(this).balance);
    } 
    
}