// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract AuctionBidder {
    struct Campaign {
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] bidders;
        uint256[] bids;
    }
}
