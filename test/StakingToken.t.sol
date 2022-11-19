// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";


import "../src/sampleStaking.sol";
import "../src/sampleERC20.sol";


contract StakingTokenTest is Test {
    SampleToken token;
    StakingToken staking;

    function setUp() public {
        //Initialize our token contract on a testnet
        token = new SampleToken("Sample Token", "TOK", 100 ether);
        
        //Initialize our staking contract on a testnet
        staking = new StakingToken("Staking Token", "STA", address(token));

        //Set access on the contracts
        token.grantRole(token.MINTERROLE(), address(staking));
        token.grantRole(token.BURNERROLE(), address(staking));
    }

    function testStaking() public {
        //confirm our contract is live and has the ether we expect
        assertEq(token.balanceOf(address(this)), 100 ether);
        console.log(address(token));
        
        // //confirm our contract is live and has the ether we expect
        assertEq(staking.balanceOf(address(this)), 0 ether);

        // //put ether into the staking contract
        staking.stake(5 ether);


        // //confirm that state change has ocurred
        assertEq(token.balanceOf(address(this)), 95 ether);
        // console.log(address(token.balanceOf(address(this))));


        // //confirm state change has ocurred
        assertEq(staking.balanceOf(address(this)), 5 ether);

    }

 

}
