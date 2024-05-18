// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12;
import "DefiClass/interfaces/IPair.sol";
import "DefiClass/interfaces/IRouter.sol";
import "DefiClass/libraries/Library.sol";
contract TaskMaster{
    address immutable router;
    address immutable factory;
    constructor(address _router) public {
        router=_router;
        factory=IUniswapV2Router01(_router).factory();
    }
    function PoolBalance(address tokenA, address tokenB) external view returns (uint amount0, uint amount1){
       (uint reserveA, uint reserveB)=UniswapV2Library.getReserves(factory, tokenA, tokenB);
        return (reserveA, reserveB);
    }

    function MaxSwap(address A, address B, address C, uint256 valA, uint256 valC) external {
        require(IERC20(A).transferFrom(msg.sender, address(this), valA), "failed to get A-coins");

        IERC20(A).approve(router, valA);

        address[] memory path = new address[](3);
        path[0] = A;
        path[1] = B;
        path[2] = C;

        uint[] memory amounts = IUniswapV2Router01(router).swapExactTokensForTokens(valA, valC, path, msg.sender, block.timestamp);

        require(amounts[2] <= valC, "Swap resulted in more than allowed token C");
    }
}
