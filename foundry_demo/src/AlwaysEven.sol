// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

contract AlwaysEven {
    uint256 public alwaysEvenNumber;
    uint256 public hiddenValue;

    function setEvenNumber(uint256 inputNumber) public {
        if (inputNumber % 2 == 0) {
            alwaysEvenNumber += inputNumber;
        }

        // 此条件会打破必定为偶数的不变性

        if (hiddenValue == 8) {
            alwaysEvenNumber = 3;
        }
        // 我们在函数结束时将 hiddenValue 设置为 inputNumber
        // 在有状态的场景中，此值将在下一次调用中记住

        hiddenValue = inputNumber;
    }
}

