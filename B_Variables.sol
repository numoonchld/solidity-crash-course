// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

contract WorkingWithVariables {
    
    // Unsigned Integer Variable
    uint256 public myUInt;
    
    function setMyUInt(uint _myUInt) public {
        myUInt = _myUInt;
    }
    
    // Boolean Variable
    bool public myBool;
    
    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }
    
    // Unsigned integer wrap around
    uint8 public myUInt8;
    
    function incrementUInt8() public {
        myUInt8++;
    }
    
    function decrementUInt8() public {
        myUInt8--;
    }
    
    // Address 
    address public myAddress;
    
    function setAddress(address _address) public {
        myAddress = _address;
    }
    
    function getBalanceOfAddress() public view returns(uint) {
        return myAddress.balance;
    }
    
    // String
    string public myString;
    
    function setMyString(string memory _myString) public {
        myString = _myString;
    }
    
}