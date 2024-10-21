// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../lib/forge-std/src/console2.sol";
import "../src/KingStakingPool.sol";
import "../src/KingToken.sol";
import "../src/KingCollections.sol";

contract KingStakingPoolTest is Test {
    KingToken public kingToken;
    KingCollections public kingCollections;
    KingStakingPool public stakingPool;

    address owner;
    address user1;
    address user2;

    function setUp() public {
        owner = address(this);
        user1 = address(0x1);
        user2 = address(0x2);
        
        kingToken = new KingToken("King Token", "KTK", 18, 100000);
        kingCollections = new KingCollections();
        stakingPool = new KingStakingPool();
    }

    function testAddPool() public {
        stakingPool.addPool("Test Pool", address(kingToken), address(kingCollections), 1e18, 86400);
        
        (string memory poolName, address stakingToken, address rewardToken, uint256 rewardRate, uint256 stakingTime, uint256 totalStaked) = stakingPool.pools(1);
        assertEq(poolName, "Test Pool");
        assertEq(stakingToken, address(kingToken));
    }

    function testStake() public {
        stakingPool.addPool("Test Pool", address(kingToken), address(kingCollections), 1e18, 86400);
        
        vm.prank(owner);
        kingToken.mint(user1, 100 ether);
        vm.prank(user1);
        kingToken.approve(address(stakingPool), 10 ether);
        
        vm.prank(user1);
        stakingPool.stake(1, 10 ether);

        uint256 stakedBalance = stakingPool.getStakedBalance(1, user1);
        assertEq(stakedBalance, 10 ether);
    }

    function testWithdrawAfterMaturity() public {
        stakingPool.addPool("Test Pool", address(kingToken), address(kingCollections), 1e18, 86400);
        
        vm.prank(owner);
        kingToken.mint(user1, 100 ether);
        vm.prank(user1);
        kingToken.approve(address(stakingPool), 10 ether);
        
        vm.prank(user1);
        stakingPool.stake(1, 10 ether);
        
        vm.warp(block.timestamp + 86400);
        
        vm.prank(user1);
        stakingPool.withdraw(1, 10 ether);

        uint256 stakedBalance = stakingPool.getStakedBalance(1, user1);
        assertEq(stakedBalance, 0);
    }

    function testCalculateReward() public {
        stakingPool.addPool("Test Pool", address(kingToken), address(kingCollections), 1e18, 86400);
        
        vm.prank(owner);
        kingToken.mint(user1, 100 ether);
        vm.prank(user1);
        kingToken.approve(address(stakingPool), 10 ether);
        
        vm.prank(user1);
        stakingPool.stake(1, 10 ether);
        
        vm.warp(block.timestamp + 43200);

        uint256 reward = stakingPool.calculateReward(1, user1);
        console.log(reward);
        // assert(reward > 0);
    }
}