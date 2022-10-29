pragma solidity ^0.8.13;

import "lib/openzeppelin-contracts/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";
import "forge-std/Test.sol";

contract BaselineTest is Test {
    ERC20PresetMinterPauser public e20;
    function setUp() public {
        // test = "Test";
        e20 = new ERC20PresetMinterPauser("A20","Better Coin");
    }
    function test_name() public {
        console.log(e20.name());
    }

    function testsetVal() public {
        console.log(e20.symbol());
    }

    function test_decimals() public {
        console.log(
            e20.decimals()
        );
    }

    function test_mint() public {
        e20.mint(address(this), 100);
        e20.mint(address(this), 200);
        console.log(
            e20.balanceOf(address(this))
        );
        console.log(
            "The Total Supply is",
            e20.totalSupply()
        );
    }

    function test_approve() public {
        e20.mint(address(this), 100);
        e20.approve(address(1), 100);
        console.log("The approved amount is:", e20.allowance(address(this), address(1)));
    }

    function test_transferFrom() public {
        e20.mint(address(this), 100);
        e20.approve(address(1), 10);
        vm.prank(address(1));
        e20.transferFrom(address(this), address(1), 10);
        console.log(e20.balanceOf(address(1)));
        console.log(e20.balanceOf(address(this)));
    }


    function test_transferFrom_fail() public {
        e20.mint(address(this), 100);
        e20.approve(address(1), 10);
        vm.prank(address(1));
        e20.transferFrom(address(this), address(1), 100000);
        console.log(e20.balanceOf(address(1)));
        console.log(e20.balanceOf(address(this)));
    }


    function test_transferFrom_alt_fail() public {
        e20.mint(address(this), 100);
        e20.approve(address(1), 100000);
        vm.prank(address(1));
        e20.transferFrom(address(this), address(1), 10);
        console.log(e20.balanceOf(address(1)));
        console.log(e20.balanceOf(address(this)));
    }


    function test_transfer() public {
        e20.mint(address(this), 100);
        e20.transfer(address(1), 50);
        console.log(e20.balanceOf(address(this)));
        console.log(e20.balanceOf(address(1)));
    }

    function test_balanceOf() public {
        console.log(
            e20.balanceOf(address(this))
        );
    }

}