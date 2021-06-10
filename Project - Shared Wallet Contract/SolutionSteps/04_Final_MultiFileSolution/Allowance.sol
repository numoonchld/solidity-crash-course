// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

// Workbench for https://ethereum-blockchain-developer.com/040-shared-wallet-project/00-overview/

// Load Ownable Library from Open Zeppelin: 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";

// create an Allowance middle-base contract based on the imported Ownable base contract
contract Allowance is Ownable {
      
    // define event for allowance change 
    event AllowanceChanged(address indexed _forWho, address indexed _byWhom, uint _oldAllowance, uint _newAllowance);
    
    // owner view function
    function isOwner() internal view returns(bool) {
       return owner() == msg.sender;
    }
      
    // mapping to store various account allowances
    mapping(address => uint) public allowance;
    
    // function to set allowance; 
    // `onlyOwner` is a modifier made available by the `Ownable` base contract
    function setAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }
    
    // modifier to set allowance based and owner based withdrawal restrictions 
    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, 'Only owner may withdraw all the funds!');
        _;
    }
    
    // function to reduce allowance balance after a withdraw by non-owner 
    function deductFromAllowance(address _who, uint _amount) internal ownerOrAllowed(_amount) {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who] - _amount);
        allowance[_who] -= _amount;
    }
}


