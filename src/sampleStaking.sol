//SPDX-License-Identifier: GPL 3.0

pragma solidity >=0.7.0 <0.9.0;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "./sampleERC20.sol";


/**
* @title SampleERC20
* @dev Create a sample ERC20 staking token
 */

 contract StakingToken is ERC20 {


    uint public deployTimestamp; 

    SampleToken sampleToken;
    constructor(string memory tokenName, string memory tokenSymbol, address _sampleToken) ERC20(tokenName, tokenSymbol) {
        deployTimestamp = block.timestamp;
        sampleToken = SampleToken(_sampleToken);
    }

    function stake(uint amountInBaseToken) public {
        uint amountInStakedToken =  amountInBaseToken / (((block.timestamp - deployTimestamp) / 1 hours) +1);
        _mint(msg.sender, amountInStakedToken);
        sampleToken.burn(msg.sender, amountInBaseToken);
    }

    function unstake(uint amountInStakedToken) public {
        uint amountInBaseToken =  amountInStakedToken  * ((block.timestamp - deployTimestamp) / 1 hours);
        sampleToken.mint(msg.sender, amountInBaseToken);
        _burn(msg.sender, amountInStakedToken);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) override internal {
        require(from == address(0) || to == address(0), "Staking: Transfer is not possible" );
        super._beforeTokenTransfer(from, to, amount);
    }

 }