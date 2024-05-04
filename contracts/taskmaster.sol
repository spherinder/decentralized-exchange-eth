// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12;
import "DefiClass/interfaces/IPair.sol"
import "DefiClass/interfaces/IRouter.sol"
import "DefiClass/libraries/Library.sol";
contract TaskMaster{
    address immutable router;
    address immutable factory;
    constructor(address _router){
        router=_router;
        factory=IUniswapV2Router(_router).factory();
    }
    function PoolBalance(address tokenA, address tokenB) external view returns (uint amount0, uint amount1){
       (uint reserveA, uint reserveB)=UniswapV2Library.getReserves(factory, tokenA, tokenB);
    }
    function MaxSwap(address A, address B, address C, uint256 valA, uint256 valC) external{

    }
}
