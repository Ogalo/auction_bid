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

    mapping(uint256 => Campaign) public campaigns;

    uint256 public numberOfCampaigns = 0;

    function createCampaign(address _owner, string memory _title, string memory _description, uint256 _target, uint256 _deadline, string memory _image) public returns (uint256) {
        Campaign storage newCampaign = campaigns[numberOfCampaigns];

        // Is everything okay?
        require(newCampaign.deadline > block.timestamp, "Deadline must be in the future");
        newCampaign.owner = _owner;
        newCampaign.title = _title;
        newCampaign.description = _description;
        newCampaign.target = _target;
        newCampaign.deadline = _deadline;
        newCampaign.image = _image;
        newCampaign.amountCollected = 0;
        numberOfCampaigns++;

        return numberOfCampaigns - 1;

    }

    function bidToCampaign(uint256 _id) public payable {
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];

        campaign.bidders.push(msg.sender);
        campaign.bids.push(amount);
        (bool sent, ) = campaign.owner.call{value: amount}("");
        if(sent){
            // Do something
            campaign.amountCollected += amount;
        }


    }

    function getBidders(uint256 _id) public view returns (address[] memory, uint256[] memory) {
        Campaign storage campaign = campaigns[_id];
        return (campaign.bidders, campaign.bids);

    }

    function getCampaigns() public view returns (Campaign[] memory) {
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns);
        for (uint i = 0; i < numberOfCampaigns; i++) {
            allCampaigns[i] = campaigns[i];
        }
        return allCampaigns;

    }
}
