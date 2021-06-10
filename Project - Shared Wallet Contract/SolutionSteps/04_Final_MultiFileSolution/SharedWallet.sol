// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

// Workbench for https://ethereum-blockchain-developer.com/040-shared-wallet-project/00-overview/

// import allowance base project
import "./Allowance.sol";

// extend the `Allowance` middle-base contract
contract SharedWallet is Allowance {
    
    event FundsSent(address indexed _beneficiary, uint _amount);
    event FundsReceived(address indexed _from, uint _amount);
    
    // function to withdraw funds from contract
    function withdrawFunds(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance, 'Insufficient funds in contract');
        if(!isOwner()) {
            deductFromAllowance(msg.sender, _amount);
        }
        emit FundsSent(_to, _amount);
        _to.transfer(_amount);
    }
    
    // function to renounce ownsership
    function renounceOwnership() public override view onlyOwner {
        revert('Renouncing Ownership not allowed for this contract!');
    }
    
    // catch all payment receive function 
    receive() external payable {
        emit FundsReceived(msg.sender, msg.value);
    }
}

