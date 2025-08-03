// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

/// @title SimpleDapp
/// @notice this contract allows users to deposit and withdraw ETH
contract SimpleDapp {
    mapping(address => uint256) public balances;

    /// @notice deposit ETH into the contract
    /// @dev this function deposits ETH into the contract and updates the mapping balances.abi
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    /// @notice withdraw ETH from the contract
    /// @dev this function withdraws ETH from the contract and updates the mapping balances.
    /// @param _amount the amount of ETH to withdraw
    function withdraw(uint256 _amount) external {
        require(balances[msg.sender] >= _amount, "balance is not enough");
        balances[msg.sender] -= _amount;//Wrong example: Deduct from balances first
        (bool success, ) = msg.sender.call{value: _amount}("");//Wrong example: Then call msg.sender's call function, send _amount of ETH to msg.sender's address
        // if the transfer fails, revert, but balances[msg.sender] has already been deducted, so the value of balances[msg.sender] will be negative, this is a security issue
        require(success, "withdraw failed");
    }
    // the correct way to handle this is to first check if the balance is enough, then deduct the balance, then transfer the ETH, if the transfer fails, then restore the balance
    //  require(balances[msg.sender] >= _amount, "balance is not enough");
    //   balances[msg.sender] -= _amount;  // deduct the balance first
    //    (bool success, ) = msg.sender.call{value: _amount}("");
    //    if (!success) {
    //        balances[msg.sender] += _amount;  // restore the balance if the transfer fails
    //        revert(unicode"withdraw failed");
}

