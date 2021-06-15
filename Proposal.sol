// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "JointAction.sol";

contract Proposal {
  address _proposer;
  address _proposee;
  bytes _proposerInput;
  bytes _proposeeInput;
  address _action;
  uint _accepted;

  constructor(address proposee_, bytes memory proposerInput_, address action_) {
    _proposer = msg.sender;
    _proposee = proposee_;
    _proposerInput = proposerInput_;
    _action = action_;
    _accepted = 0;
  }

  function accept(bytes calldata proposeeInput_) external {
    require(msg.sender == _proposee, "Only the proposee can accept the proposal");
    require(_accepted == 0, "You can only accept or reject once");
    _proposeeInput = proposeeInput_;
    _accepted = 1;
    JointAction(_action).act(_proposer, _proposerInput, _proposee, _proposeeInput);
  }

  function decline() external {
    require(msg.sender == _proposee, "Only the proposee can accept the proposal");
    require(_accepted == 0, "You can only accept or reject once");
    _accepted = 2;
  }

  function accepted() external view returns (bool) {
    return _accepted == 1;
  }

  function rejected() external view returns (bool) {
    return _accepted == 2;
  }

  function unanswered() external view returns (bool) {
    return _accepted == 0;
  }
}
