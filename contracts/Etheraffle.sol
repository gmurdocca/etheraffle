// SPDX-License-Identifier: agpl-3.0

pragma solidity ^0.6.12;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";


contract Etheraffle is Ownable {
    event Deposit(address user, uint amount);
    event Withdrawal(address user, uint amount);

    mapping (address => uint256) private deposits;
    uint min_gwei_deposit = 0;              // min amount depositable by competitors in this raffle
    uint max_gwei_deposit = 0;              // max amount depositable by competitors in this raffle
    uint draw_date;                         // draw function is only possible after a block is mined on or after this unix epoch date
    bool is_mutable = true;                 // allow min/max/draw_date to be adjustable after contract instantiation
    bool ended = false;                     // set to true when the raffle is ended and drawn

    constructor (uint _min_gwei_deposit, uint _max_gwei_deposit, uint _draw_date, bool _is_mutable) Ownable() public {
        set_max_gwei_deposit(_max_gwei_deposit);
        set_min_gwei_deposit(_min_gwei_deposit);
        set_draw_date(_draw_date);
        is_mutable = _is_mutable;
    }

    function destroy() public onlyOwner {
        selfdestruct(payable(this.owner()));
    }

    function process_deposit(address user) private {
        deposits[user] += msg.value;
    }

    function deposit() external payable {
        require(block.timestamp < draw_date, "Sorry, this raffle is not accepting any more deposits.");
        // ensure user does not exceed max deposit
        require(msg.value >= min_gwei_deposit - deposits[msg.sender], "Deposit would be less that the minimum deposit limit.");
        require(msg.value <= max_gwei_deposit - deposits[msg.sender], "Deposit would exceed the maximum deposit limit.");
        process_deposit(msg.sender);
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint withdraw_amount) external {
        // only allow withdrawal if the raffle is not ended.
        require(ended == false, "Sorry, this raffle has ended.");
        require(block.timestamp < draw_date, "Sorry, this raffle's draw date has passed and funds are pending delivery to winners.");
        require(deposits[msg.sender] >= withdraw_amount, "Insufficient balance for withdrawal request.");
        msg.sender.transfer(withdraw_amount);
        emit Withdrawal(msg.sender, withdraw_amount);
    }

    function get_balance() public view returns (uint) {
        // returns the balance for the sender's account
        return deposits[msg.sender];
    }

    function set_min_gwei_deposit(uint _min_gwei_deposit) public onlyOwner {
        // allow the contract owner to adjust the min deposit value
        require(is_mutable == true, "This raffle's settings can not be changed");
        require(_min_gwei_deposit < max_gwei_deposit, "min deposit must be less than max deposit");
        min_gwei_deposit = _min_gwei_deposit * 1000000000; // convert gwei to wei
    }

    function set_max_gwei_deposit(uint _max_gwei_deposit) public onlyOwner {
        // allow the contract owner to adjust the max deposit value
        require(is_mutable == true, "This raffle's settings can not be changed");
        require(_max_gwei_deposit > min_gwei_deposit, "max deposit must be greater than min deposit");
        max_gwei_deposit = _max_gwei_deposit * 1000000000; // convert gwei to wei
    }

    function set_draw_date(uint _draw_date) public onlyOwner {
        // allow the contract owner to adjust the draw date 
        require(is_mutable == true, "This raffle's settings can not be changed");
        require(_draw_date > block.timestamp, "Draw date must be in the future" );
        draw_date = _draw_date;
    }


    function draw_raffle() public {
        // TODO if current block time >= draw_date then pick some winners and pay them, and set ended = true
    }
}

