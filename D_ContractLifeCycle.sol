// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

contract ContractLifeCycle {
    
    // variable to store original contract deployer
    address public deployer;
    
    // variable for paused state
    bool public paused;
    
    // constructor function to save the deployer information
    constructor() {
        deployer = msg.sender;
    }
    
    // payable function to receive funds into contract
    function receiveFunds() public payable {}
    
    // function to pause the contract
    function pauseContract(bool _pause) public {
        require(msg.sender == deployer, "Only owner can pause!");
        paused = _pause;
    }
    
    // withdraw funds to account passed as parameter
    function withdrawFundsTo(address payable _to) public {
        require(msg.sender == deployer, "You cannot withdraw!");
        require(!paused, 'Contract currently paused!');
        _to.transfer(address(this).balance);
    }
    
    // destroy this smart contract and pass on contract balance to input address
    function destroy(address payable _to) public {
        require(msg.sender == deployer, "You cannot destroy!");
        selfdestruct(_to);
    }
}