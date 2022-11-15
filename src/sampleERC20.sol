//SPDX-License-Identifier: GPL 3.0

pragma solidity >=0.7.0 <0.9.0;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "lib/openzeppelin-contracts/contracts/access/AccessControl.sol";

/**
* @title SampleERC20
* @dev Create a sample ERC20 standard token
 */

 contract SampleToken is ERC20, AccessControl {


    //Access Controls to mint and burn staking tokens
    bytes32 public constant MINTERROLE = keccak256("MINTERROLE");
    bytes32 public constant BURNERROLE = keccak256("BURNERROLE");


    constructor(string memory tokenName, string memory tokenSymbol, uint totalSupply) ERC20(tokenName, tokenSymbol) {
        _mint(msg.sender, totalSupply)
    }

    function mint(address _to, uint _amount) public {
        require(hasRole(MINTERROLE, msg.sender), "SampleToken: You do not have minter role");
        _mint(_to, _amount);
    }

    function burn(address _to, uint _amount) public {
        require(hasRole(BURNERROLE, msg.sender), "SampleToken: You do not have burner role");
        _burn(_to, _amount);
    }

 }