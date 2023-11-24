// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC20} from "@solmate/tokens/ERC20.sol";

/**
 * @title OBC
 * @author GrayJiang
 * @notice just for learning,and do not use in production env~
 */

contract OBC is ERC20 {
    error ERC20__NOTOWNER();

    string private s_name; // token 名称
    string private s_symbol; // token 代号
    uint8 private s_decimals = 18; // 小数位数
    address private s_owner; // 合约地址

    modifier OnlyOwner() {
        if (msg.sender != s_owner) {
            revert ERC20__NOTOWNER();
        }
        _;
    }

    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_, s_decimals) {
        s_name = name_;
        s_symbol = symbol_;
        s_owner = msg.sender;
    }

    function transfer(address _recipient, uint256 _amount) public override returns (bool _success) {
        balanceOf[msg.sender] -= _amount;
        unchecked {
            balanceOf[_recipient] += _amount;
        }
        emit Transfer(msg.sender, _recipient, _amount);
        _success = true;
    }

    function approve(address _spender, uint256 _amount) public override returns (bool _isApproved) {
        unchecked {
            allowance[msg.sender][_spender] += _amount;
        }
        emit Approval(msg.sender, _spender, _amount);
        _isApproved = true;
    }

    function transferFrom(address _sender, address _recipient, uint256 _amount) public override returns (bool) {
        allowance[_sender][msg.sender] -= _amount;
        balanceOf[_sender] -= _amount;
        balanceOf[_recipient] += _amount;
        emit Transfer(_sender, _recipient, _amount);
        return true;
    }

    function mint(uint256 _amount) external OnlyOwner {
        balanceOf[msg.sender] += _amount;
        unchecked {
            totalSupply += _amount;
        }
        emit Transfer(address(0), msg.sender, _amount);
    }

    function burn(uint256 _amount) external {
        balanceOf[msg.sender] -= _amount;
        unchecked {
            totalSupply -= _amount;
        }
        emit Transfer(msg.sender, address(0), _amount);
    }

    // getter
    function getName() public view returns (string memory) {
        return s_name;
    }

    function getSymbol() public view returns (string memory) {
        return s_symbol;
    }

    function getDecimals() public view returns (uint256) {
        return s_decimals;
    }
}
