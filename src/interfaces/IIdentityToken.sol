// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IAttributeRegistry} from "./IAttributeRegistry.sol";
import {ITrustGraph} from "./ITrustGraph.sol";
import {ISocialRecovery} from "./ISocialRecovery.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IIdentityToken is IERC721, IAttributeRegistry, ITrustGraph, ISocialRecovery {
    function mint() external returns (uint256);
}