// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract JointAction {
  function act(address alice, bytes calldata aliceInput, address bob, bytes calldata bobInput) external virtual;
}
