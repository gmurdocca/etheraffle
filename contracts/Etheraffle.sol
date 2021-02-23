// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.12;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Etheraffle is Ownable {

    event DepositReceived(address user, uint amount);

    mapping (address => uint256) public deposits;

    function processDeposit(address user) external payable {
        deposits[user] += msg.value;
    }

    function destroy() public onlyOwner {
        selfdestruct(payable(this.owner()));
    }

    receive() external payable {
        emit DepositReceived(msg.sender, msg.value);
        //processDeposit{value:msg.value}(msg.sender);
    }

}

