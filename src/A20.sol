// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ERC20_optimized {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;

    bytes32 nameSize = keccak256("_name");
    bytes32 nameData = keccak256("name");

    string private _symbol;

    constructor (string memory name_, string memory symbol_) {
        // bytes32 nameSize_ = nameSize;
        // bytes32 nameData_ = nameData;
        // assembly {
        //     sstore(nameSize_, mload(name_))
        //     sstore(nameData_, mload(add(name_, 0x20)))
        // }

        _name = name_;
        _symbol = symbol_;
        
        // assembly{
        //     sstore(_name.slot, mload(name_))
        //     // sstore(add(_name.slot, 32), mload(add(name_,32)))
        // }
        
    }

    function setSymbol(string memory sym) public {

    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }


    function name() public view returns (string memory p) {
        // bytes32 nameSize_ = nameSize;
        // bytes32 nameData_ = nameData;
        // assembly {
        //     p := mload(0x40)
        //     mstore(p, sload(nameSize_))
        //     mstore(add(p, 0x20), sload(nameData_))
        //     mstore(0x40, add(p, 0x40))
        // }

        

        return _name;
    }
}
