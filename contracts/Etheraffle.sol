// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.6.12;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Etheraffle is Ownable {
    event Deposit(address user, uint amount);
    event Withdrawal(address user, uint amount);

    mapping (address => uint256) private deposits;

    // TODO make below values settable in this subclass constructor
    uint public max_deposit = 1 ether;
    uint public draw_date = 1616681778;

    function destroy() public onlyOwner {
        selfdestruct(payable(this.owner()));
    }

    function process_deposit(address user) private {
        deposits[user] += msg.value;
    }

    function deposit() public payable {
        require(block.timestamp < draw_date, "Sorry, this raffle is not accepting any more deposits.");
        // ensure user does not exceed max deposit
        require(msg.value <= max_deposit - deposits[msg.sender], "Deposit would exceed the maximum deposit limit."); //XXX tell them what the limit is
        process_deposit(msg.sender);
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint withdraw_amount) public {
        require(deposits[msg.sender] >= withdraw_amount, "Insufficient balance for withdrawal request."); //XXX tell them their balance
        msg.sender.transfer(withdraw_amount);
        emit Withdrawal(msg.sender, withdraw_amount);
    }

    function get_balance() public view returns (uint) {
        return deposits[msg.sender];
    }

    function draw_raffle() public {
        // TODO if current block time >= draw_date then pick some winners and pay them
    }
}

