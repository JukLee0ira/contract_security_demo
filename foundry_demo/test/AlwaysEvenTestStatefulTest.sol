// SPDX-License-Identifier: MIT

import {Test} from "forge-std/Test.sol";
import {AlwaysEven} from "../src/AlwaysEven.sol";

// 我们需要从 forge-std 导入不变性合约
import {StdInvariant} from "forge-std/StdInvariant.sol";

pragma solidity ^0.8.12;

contract AlwaysEvenTestStatefulTest is StdInvariant, Test {
    AlwaysEven alwaysEven;

    function setUp() public {
        alwaysEven = new AlwaysEven();
        targetContract(address(alwaysEven));
    }

    function invariant_testsetEvenNumber() public view {
        assert(alwaysEven.alwaysEvenNumber() % 2 == 0);
    }
}

