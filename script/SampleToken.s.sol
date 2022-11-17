// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import {SampleToken} from "src/sampleERC20.sol";
import {StakingToken} from "src/sampleStaking.sol";



contract SampleTokenScript is Script {

    SampleToken token;
    StakingToken staking;


    function setUp() public {}

    function run() public {
        vm.broadcast();
        token = new SampleToken("Sample Token", "TOK", 100 ether);
        staking = new StakingToken("Staking Token", "STA", address(token));

        token.grantRole(token.MINTERROLE(), address(staking));
        token.grantRole(token.BURNERROLE(), address(staking));
    }
}
