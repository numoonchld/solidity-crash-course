// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

contract Mapping {
    
    // mapping to mimic array of bools indexed by ints
    mapping(uint => bool) public myMapping;
    
    // mapping to whitelist addresses
    mapping(address => bool) public myAddressWhitelist;
    
    // function to set a myMapping value based on index 
    function setMyMappingValue(uint _index) public {
        myMapping[_index] = true;
    }
    
    // function to set whitelist value based on current address 
    function whitelistActiveAddress() public {
        myAddressWhitelist[msg.sender] = true;
    }
     
    // nested mapping
    mapping (uint => mapping(uint => bool)) uintUintBoolMapping;
    
    // setter for nested mapping
    function setUintUintBoolMapping(uint _index1, uint _index2, bool _value) public {
        uintUintBoolMapping[_index1][_index2] = _value;
    }
    
    // getter for nested mapping 
    function getUintUintBoolMapping(uint _index1, uint _index2) public view returns (bool) {
        return uintUintBoolMapping[_index1][_index2];
    }    
    
}