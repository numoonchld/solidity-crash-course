// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

// simple shared wallet contract
contract SimpleSharedWallet {
    
    // owner account 
    address public owner;
    
    // constructor for initializing owner
    constructor () {
        owner = msg.sender;
    }
    
    // track current contract balance
    uint public contractBalance;
    
    // track each account's balance allowance 
    mapping(address => uint) public allowance;
    
    // deposit function 
    function depositFunds() public payable {
        assert(contractBalance + msg.value >= contractBalance);
        contractBalance += msg.value;
    }
    
    // withdraw function 
    function withdrawFunds(address payable _to, uint _amount) public {
        
        // check if contract has enough funds balance for withdrawl
        require(_amount <= contractBalance, 'Insufficient funds in contract!');
        
        // check if owner if withdraw amount is the full amount 
        if (_amount == contractBalance ) {
            
            // check if owner making withdrawl 
            require(msg.sender == owner, 'Only owner may withdraw all funds!');
            
            // sanity check for overflow situations
            assert(contractBalance - _amount <= contractBalance);
            
            // process owner withdrawl
            contractBalance -= _amount;
            _to.transfer(_amount);
            
        } 
        
        // allow withdraw based on allowance limit
        else if (_amount < contractBalance) {
            
            // owner has no allowance limit 
            if (msg.sender == owner) {
                
                // sanity check for overflow situations
                assert(contractBalance - _amount <= contractBalance);  
                
                // process owner withdrawl
                contractBalance -= _amount;
                _to.transfer(_amount);

            }
            
            // non-owner withdrawl
            else {
               
                // get available allowance for withdrawl by non-owner 
                uint currentAllowanceBalance = allowance[msg.sender];
            
                // require enough allowance avaialbity for withdrawl
                require(_amount <= currentAllowanceBalance, 'You have exhausted your allowance!');
                
                // sanity check for overflow situations
                assert(contractBalance - _amount <= contractBalance);  
                
                // process withdrawl
                contractBalance -= _amount;
                allowance[msg.sender] -= _amount;
                _to.transfer(_amount); 
                
            }
            
        }
        
    }
    
    // change allowance
    function changeAllowance(address _targetAccount, uint _newAllowance) public {
        
        // only onwer can set allowance
        require(msg.sender == owner, 'Only owner may set allownace!');
        
        // allowance can only be less that current contract balance 
        require(_newAllowance <= contractBalance, 'Allowance cannot be set to more than current contract balance!');
        
        // set new allowance
        allowance[_targetAccount] = _newAllowance;
        
    }
    
    // fallback function for data and funds 
    fallback() external {
        
    }
    
    // fallback function for funds 
    receive() external payable {
        contractBalance += msg.value;
    }
    
}