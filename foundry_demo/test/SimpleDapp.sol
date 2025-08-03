// SPDX-License-Identifier: MIT

import {Test} from "forge-std/Test.sol";
import {SimpleDapp} from "../src/SimpleDapp.sol";

pragma solidity ^0.8.23;

/// @title SimpleDapp 合约测试
/// @notice 此合约实现对 SimpleDapp 的模糊测试
contract SimpleDappTest is Test {
    SimpleDapp simpleDapp;
    address public user;

    ///@notice 通过部署 SimpleDapp 设置测试
    function setUp() public {
        simpleDapp = new SimpleDapp();
        user = address(this);
    }

/// @notice 存款和提取功能的模糊测试
    /// @dev 测试用户无法提取超过他们存入的资金这一不变性
    /// @param depositAmount 存入的 ETH 数量
    /// @param withdrawAmount 提取的 ETH 数量
    function testDepositAndWithdraw(
        // 我们将 depositAmount 和 withdrawAmount 设置为输入参数 👇👇👇
        uint256 depositAmount,
        uint256 withdrawAmount
    )
        public
        payable
    // Foundry 将为输入参数生成随机值 👆👆👆
    {
        // 确保用户有足够的以太坊来覆盖存款
        uint256 initialUserBalance = 100 ether;
        vm.deal(user, initialUserBalance);

        // 仅当用户的余额足够时才尝试存款
        if (depositAmount <= initialUserBalance) {
            simpleDapp.deposit{value: depositAmount}();

            if (withdrawAmount <= depositAmount) {
                simpleDapp.withdraw(withdrawAmount);
                assertEq(
                    simpleDapp.balances(user),
                    depositAmount - withdrawAmount,
                    unicode"提取后的余额应与预期值匹配"
                );
            } else {
                // 预计因余额不足而回滚
                vm.expectRevert(unicode"余额不足");
                simpleDapp.withdraw(withdrawAmount);
            }
        }
    }
}