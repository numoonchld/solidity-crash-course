// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

// Workbench for https://ethereum-blockchain-developer.com/040-shared-wallet-project/00-overview/

// Load Ownable Library from Open Zeppelin: 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";

// extent the `Ownable` base contract
contract SharedWallet is Ownable {
    
    // owner view function
    function isOwner() internal view returns(bool) {
       return owner() == msg.sender;
    }
    
    // mapping to store various account allowances
    mapping(address => uint) public allowance;
    
    // function to set allowance; 
    // `onlyOwner` is a modifier made available by the `Ownable` base contract
    function setAllowance(address _who, uint _amount) public onlyOwner {
        allowance[_who] = _amount;
    }
    
    // modifier to set allowance based and owner based withdrawal restrictions 
    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, 'Only owner may withdraw all the funds!');
        _;
    }
    
    // function to reduce allowance balance after a withdraw by non-owner 
    function deductFromAllowance(address _who, uint _amount) internal ownerOrAllowed(_amount) {
        allowance[_who] -= _amount;
    }
    
    // function to withdraw funds from contract
    function withdrawFunds(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance, 'Insufficient funds in contract');
        if(!isOwner()) {
            deductFromAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }
    
    // catch all payment receive function 
    receive() external payable {
        
    }
}
