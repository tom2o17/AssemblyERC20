// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
//import "src/A20.sol";

contract CounterTest is Test {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;


    bool val1;
    bool val2;
    uint8 val3;

    function setUp() public {
        val1 = true;
        val2 = false;
        val3 = 8;

        _name = "Test";
    }

    function testCase() public {
        console.log(_get3rdVal());
    }

    function test_getslot() public {
        (uint256 slot, uint256 offset) = _getSlotAndOffset();
        console.log(slot, offset);
    }

    function test_getname() public {
       uint256 name;
        assembly {
            name := sload(_name.slot)

        }
        console.log(name);
    }

    function _get3rdVal() public view returns (uint8) {
        uint8 value;
        assembly {
            let tmp := sload(val3.slot)
            tmp := shr(mul(val3.offset, 8), tmp)
            value := tmp
        }
        return value;
    }

    function _getSlotAndOffset() public returns(uint256, uint256) {
        uint256 offset;
        uint256 slot;
        assembly {
            offset := sload(_name.offset)
            slot := sload(_name.slot)
        }
        return (slot, offset);
    }

    
}
