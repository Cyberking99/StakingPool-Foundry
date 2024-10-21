// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../lib/forge-std/src/console.sol";
import "../src/KingStakingPool.sol";
import "../src/KingToken.sol";
import "../src/KingCollections.sol";

contract DeployScript is Script {
    KingToken public kingToken;
    KingCollections public kingCollections;
    KingStakingPool public stakingPool;

    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        
        kingToken = new KingToken("King Token", "KTK", 18, 100000);
        kingCollections = new KingCollections();
        stakingPool = new KingStakingPool();

        console.log("KTK: ", address(kingToken));
        console.log("KC: ", address(kingCollections));
        console.log("KSP: ", address(stakingPool));

        vm.stopBroadcast();
    }
}
