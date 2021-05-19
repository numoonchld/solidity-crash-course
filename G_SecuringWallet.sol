// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract StructsMappingsTowardsSecureWallet {
    
    // mapping variable to track address balances
    mapping(address => uint) public addressBalance;
    
    // function to route received funds into mapping
    function receiveMoney() public payable {
        addressBalance[msg.sender] += msg.value;
    }
    
    //  function to view contact balance 
    function viewContractBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    // function to view individual account balance
    function viewAccountBalanceInContract(address _viewAddress) public view returns(uint) {
        return addressBalance[_viewAddress];
    }
    
    // function to withdraw to given address from sender's account in contract
    function withdrawEntireAccountBalance(address payable _to) public {
        uint accountFundsAvailable = addressBalance[msg.sender];
        addressBalance[msg.sender] = 0;
        _to.transfer(accountFundsAvailable);
    }
}