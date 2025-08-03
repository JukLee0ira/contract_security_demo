// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

/// @title SimpleDapp
/// @notice 此合约允许用户存入和提取 ETH
contract SimpleDapp {
    mapping(address => uint256) public balances;

    /// @notice 将 ETH 存入合约
    /// @dev 此函数将 ETH 存入合约并更新映射 balances.abi
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    /// @notice 从合约提取 ETH
    /// @dev 此函数将从合约中提取 ETH 并更新映射 balances。
    /// @param _amount 要提取的 ETH 数量
    function withdraw(uint256 _amount) external {
        require(balances[msg.sender] >= _amount, unicode"余额不足");
        balances[msg.sender] -= _amount;//Wrong example: Deduct from balances first
        (bool success, ) = msg.sender.call{value: _amount}("");//Wrong example: Then call msg.sender's call function, send _amount of ETH to msg.sender's address
        // if the transfer fails, revert, but balances[msg.sender] has already been deducted, so the value of balances[msg.sender] will be negative
        require(success, unicode"withdraw failed");
    }
    // 正确处理：先判断余额是否足够，再扣除余额，再转账，如果转账失败，则恢复余额
    //  require(balances[msg.sender] >= _amount, unicode"余额不足");
    //   balances[msg.sender] -= _amount;  // 先扣减余额
    //    (bool success, ) = msg.sender.call{value: _amount}("");
    //    if (!success) {
    //        balances[msg.sender] += _amount;  // 转账失败时恢复余额
    //        revert(unicode"提取失败");
}

