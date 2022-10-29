// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/ERC20Assembly.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract CounterTest is Test {
    // string test;
    uint256 val;
    ERC20_Assembly public a20;
    ERC20 baseline;

    function setUp() public {
        // test = "Test";
        a20 = new ERC20_Assembly("A20","Better Coin");
        baseline = new ERC20("Base", "test");
    }

    function test_name() public {
        console.log(a20.name());
    }

    function testsetVal() public {
        console.log(a20.symbol());
    }

    function test_decimals() public {
        console.log(
            a20.decimals()
        );
    }

    function test_mint() public {
        a20.mint(address(this), 100);
        a20.mint(address(this), 200);
        console.log(
            a20.balanceOf(address(this))
        );
        console.log(
            "The Total Supply is",
            a20.totalSupply()
        );
    }

    function test_approve() public {
        a20.mint(address(this), 100);
        a20.approve(address(1), 100);
        console.log("The approved amount is:", a20.allowances(address(this), address(1)));
    }

    function test_transferFrom() public {
        a20.mint(address(this), 100);
        a20.approve(address(1), 10);
        vm.prank(address(1));
        a20.transferFrom(address(this), address(1), 10);
        console.log(a20.balanceOf(address(1)));
        console.log(a20.balanceOf(address(this)));
    }


    function test_transferFrom_fail() public {
        a20.mint(address(this), 100);
        a20.approve(address(1), 10);
        vm.prank(address(1));
        a20.transferFrom(address(this), address(1), 100000);
        console.log(a20.balanceOf(address(1)));
        console.log(a20.balanceOf(address(this)));
    }


    function test_transferFrom_alt_fail() public {
        a20.mint(address(this), 100);
        a20.approve(address(1), 100000);
        vm.prank(address(1));
        a20.transferFrom(address(this), address(1), 10);
        console.log(a20.balanceOf(address(1)));
        console.log(a20.balanceOf(address(this)));
    }


    function test_transfer() public {
        a20.mint(address(this), 100);
        a20.transfer(address(1), 50);
        console.log(a20.balanceOf(address(this)));
        console.log(a20.balanceOf(address(1)));
    }

    function test_balanceOf() public {
        console.log(
            a20.balanceOf(address(this))
        );
    }


}
