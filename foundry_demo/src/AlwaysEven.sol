// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

contract AlwaysEven {
    uint256 public alwaysEvenNumber;
    uint256 public hiddenValue;

    function setEvenNumber(uint256 inputNumber) public {
        if (inputNumber % 2 == 0) {
            alwaysEvenNumber += inputNumber;
        }

        // this condition will break the invariant that the number is always even

        if (hiddenValue == 8) {
            alwaysEvenNumber = 3;
        }
        // we set hiddenValue to inputNumber at the end of the function
        // in a stateful scenario, this value will be remembered in the next call

        hiddenValue = inputNumber;
    }
}

