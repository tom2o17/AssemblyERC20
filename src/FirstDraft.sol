// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ERC20_Assembly {
    /**
     * 0x0          Name - Array size 
     * 0x20         Name - Array data 
     * 0x40         Symbol - array size 
     * 0x60         Symbol - array data 
     * 0x80         Decimals 
     * 0x100        Total Supply
     * 0x120        Balances mapping 
     * 0x140        Allowances nested mapping
     */

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
            mstore(n, sload(0x0))
            mstore(add(n, 0x20), sload(0x20))
            mstore(0x40, add(n, 0x40))
        }
    }

    function transfer(address to, uint256 amount) public {
        address from = msg.sender;
        assembly {
            // Load the current balance of `from`
            mstore(0x0, from)
            mstore(0x20, 0x120)
            let location := keccak256(0x0, 0x40)
            let v := sload(location)
            // Check to see if balance >= amount -> case 1
            let isValid := or(gt(v, amount), eq(v, amount))
            switch isValid
            case 1 {
                // decrement the `from` balance
                sstore(location, sub(v, amount))
            } default {
                stop()
            }
            // Load the balance of `to`
            mstore(0x0, to)
            location := keccak256(0x0, 0x40)
            v := sload(location)
            // Increment the `to` balance
            sstore(location, add(v, amount))
        }
    }

    function mint(address user, uint256 amount) public {
        assembly {
            // Load the balance of `user`
            mstore(0x0, user)
            mstore(0x20, 0x120)
            let location := keccak256(0x0, 0x40)
            let v := sload(location)
            // Increment the `user` balance 
            sstore(location, add(amount, v))

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

    function approve(address spender, uint256 amount) public {
        address owner = msg.sender;
        assembly{
            // Require that the owner has the amount
            mstore(0x0, owner)
            mstore(0x20, 0x120)
            let location := keccak256(0x0, 0x40)
            let v := sload(location)
            // If their balance is >= amout -> case 1
            let isValid := or(gt(v, amount), eq(v, amount))
            switch isValid
            case 1 {
                // Get the hash of the slot and the owner addr
                mstore(0x0, owner)
                mstore(0x20, 0x140)
                let location1 := keccak256(0x0, 0x40)
                // Get the hash of `location1` and the spender addr
                mstore(0x0, location1)
                mstore(0x40, spender)
                let location2 := keccak256(0x0, 0x40)
                // Store to memeory
                sstore(location2, amount)
            } default {
                stop()
            }
        }
    }

    function allowances(address owner, address spender) public view returns(uint256 a) {
        assembly{
            mstore(0x0, owner)
            mstore(0x20, 0x140)
            let location1 := keccak256(0x0, 0x40)
            mstore(0x0, location1)
            mstore(0x40, spender)
            let location2 := keccak256(0x0, 0x40)
            a := sload(location2)
        }
    }

    function transferFrom(address from, address to, uint256 amount) public {
        address spender = msg.sender;
        assembly {
            // Get the hash of the slot and the owner addr
            mstore(0x0, from)
            mstore(0x20, 0x140)
            let location1 := keccak256(0x0, 0x40)
             // Get the hash of `location1` and the spender addr
            mstore(0x0, location1)
            mstore(0x40, spender)
            let location2 := keccak256(0x0, 0x40)
            // Store to memeory
            let v := sload(location2)
            // If their balance is >= amout -> case 1
            let isValid := or(gt(v, amount), eq(v, amount))
            switch isValid
            case 1 {
                // Get the balance of the sender
                mstore(0x0, from)
                mstore(0x20, 0x120)
                let location := keccak256(0x0, 0x40)
                let b := sload(location)
                // Decrement their balance
                sstore(location, sub(b, amount))
                // Get the balance of the recipient
                mstore(0x0, to)
                mstore(0x20, 0x120)
                let locationTo := keccak256(0x0, 0x40)
                let y := sload(locationTo)
                // Increment their balance
                sstore(locationTo, add(y, amount))
            } default {
                stop()
            }
        }
    }
}
