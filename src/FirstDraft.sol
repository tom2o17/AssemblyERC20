// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ERC20_optimized {
    /**
     * 0x0          Name - Array size 
     * 0x20         Name - Array data 
     * 0x40         Symbol - array size 
     * 0x60         Symbol - array data 
     * 0x80         Decimals 
     * 0x100        Total Supply
     * // TODO
     * 0x120        Balances mapping 
     * 0x140        Allowances mapping
     */

    uint256[4] gap;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;



    constructor (string memory name_, string memory symbol_) {
        assembly {
            // Set Name 
            sstore(0x0, mload(name_))
            sstore(0x20, mload(add(name_, 0x20)))
            // Set Symbol
            sstore(0x40, mload(symbol_))
            sstore(0x60, mload(add(symbol_, 0x20)))
            // Set Decimals 
            sstore(0x80, 18)
        }
    }

    function totalSupply() public view returns(uint256 ts) {
        assembly {
            ts := sload(0x100)
        }
    }

    function symbol() public view returns (string memory s) {
        assembly {
            // s := mload(0x40)
            mstore(s, sload(0x40))
            mstore(add(s, 0x20), sload(0x60))
            mstore(0x40, add(s, 0x40))
        }
    }

    function decimals() public view returns(uint256 d) {
        assembly {
            d := sload(0x80)
        }
    }


    function name() public view returns (string memory n) {
        assembly {
            // n := mload(0x40)
            mstore(n, sload(0x0))
            mstore(add(n, 0x20), sload(0x20))
            mstore(0x40, add(n, 0x40))
        }
    }

    function transfer(address to, uint256 amount) public {
        address from = msg.sender;
        assembly {
            mstore(0x0, from)
            mstore(0x20, 0x120)
            let location := keccak256(0x0, 0x40)
            let v := sload(location)
            sstore(location, sub(v, amount))

            mstore(0x0, to)
            // mstore(0x20, 0x120)
            location := keccak256(0x0, 0x40)
            v := sload(location)
            sstore(location, add(v, amount))
        }
    }

    function mint(address user, uint256 amount) public {
        assembly {
            // Incrememnt the users balance 
            mstore(0x0, user)
            mstore(0x20, 0x120)
            let location := keccak256(0x0, 0x40)
            sstore(location, amount)

            // Increment total supply 
            let ts := sload(0x100)
            ts := add(ts, amount)
            sstore(0x100, ts)
        }
    }

    function balanceOf(address user) public view returns(uint256 b) {
        assembly {
            mstore(0x0, user)
            mstore(0x20, 0x120)
            let location := keccak256(0x0, 0x40)
            b := sload(location)
        }
    }

    function translate(string memory input) public pure returns(string memory t) {
        assembly {
            // t := mload(0x40)
            // let size := mload(input)
            // let data := mload(add(input, 0x20))
            // // Wtf is this pattern 
            // mstore(t, size)
            // mstore(add(t, 0x20), data)
            // // set the pointer to free memory
            // mstore(0x40, add(t, 0x40))

            mstore(t, mload(input))
            mstore(add(t, 0x20), mload(add(input, 0x20)))
            mstore(0x40, add(t, 0x40))

        }
    }
}
