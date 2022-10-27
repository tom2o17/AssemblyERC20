// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/FirstDraft.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract CounterTest is Test {
    // string test;
    uint256 val;
    ERC20_optimized public a20;
    ERC20 baseline;

    function setUp() public {
        // test = "Test";
        a20 = new ERC20_optimized("A20","Better Coin");
        baseline = new ERC20("Base", "test");
    }

    // function testBaseName() public {
    //     console.log(baseline.name());
    // }
    // function testBaseSymbol() public {
    //     console.log(baseline.symbol());
    // }

    function test_name() public {
        console.log(a20.name());
    }


    function testsetVal() public {
        console.log(a20.symbol());
    }

    function test_string() public {
        console.log(
            a20.translate("Thomas")
        );
    }

    function test_decimals() public {
        console.log(
            a20.decimals()
        );
    }

    function test_mint() public {
        a20.mint(address(this), 100);
        console.log(
            a20.balanceOf(address(this))
        );
        console.log(
            "The Total Supply is",
            a20.totalSupply()
        );
    }

    function test_transfer() public {
        a20.mint(address(this), 100);
        a20.transfer(address(1), 50);
        console.log(a20.balanceOf(address(this)));
        console.log(a20.balanceOf(address(1)));
    }

    // function test_msg() public {
    //     a20.setmsg();
    //     console.log(a20.getSender());
    // }

    // function test_setter() public {
    //     a20.setName("test");
    //     console.log(a20._name());
    // }

    // function testWeirdCase() public {
    //     string memory s;
    //     assembly {
    //         s := sload(test.slot)
    //         mstore(add(s, 0x20), sload(add(test.slot, 0x20)))
    //         mstore(0x40, add(s, 0x40))
    //     }
    //     console.log(s);
    // }
}
