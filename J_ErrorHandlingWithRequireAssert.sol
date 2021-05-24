// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract ErrorHandling {
    // account balance holder
    mapping(address => uint64) public balanceReceived;

    // receive payments into contract
    function receiveMoney() public payable {
        assert(
            balanceReceived[msg.sender] + uint64(msg.value) >=
                balanceReceived[msg.sender]
        );
        balanceReceived[msg.sender] += uint64(msg.value);
    }

    // withdraw funds from contract - if implementation -------------------------------------------
    // function withdrawMoney(address payable _to, uint _amount) public {
    //     if (balanceReceived[msg.sender] >= _amount) {
    //         balanceReceived[msg.sender] -= _amount;
    //         _to.transfer(_amount);
    //     }
    // }
    // this yields a successful txn with no errors raised if withdrawl amount is more than in wallet
    // there is no error handling there

    // withdraw funds from contract - require implmentation ---------------------------------------
    function withdrawMoney(address payable _to, uint256 _amount) public {
        require(balanceReceived[msg.sender] >= _amount, "Insufficient Funds!");
        assert(
            balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount
        );
        balanceReceived[msg.sender] -= uint64(_amount);
        _to.transfer(_amount);
    }
    // send 10 ETH twice into this contract and it will error out
}
