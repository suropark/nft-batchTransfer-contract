// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

interface ERC721Partial {
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;
    
     function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;
}

contract BatchTransfer {
    /// @notice msg.sender 에서 하나의 recipient로 ERC721 batch transfer 하기.

    // transferFrom을 사용하기 때문에 EOA로 보내야 함, Contract로 보낼 시에는 ERC721 Received 가 있는 주소에 SafeTransferFrom
    ///         실행하기 전에 ERC721 Contract에  setApprovalForAll 해야함 .
    /// @param  tokenContract ERC721 Contract address
    /// @param  recipient     받을 사람
    /// @param  tokenIds      보낼 token Id 배열
    function batchTransferToOne(
        ERC721Partial tokenContract,
        address recipient,
        uint256[] memory tokenIds
    ) external {
        uint256 length = tokenIds.length;
        for (uint256 index; index < length; ++index) {
            tokenContract.safeTransferFrom(msg.sender, recipient, tokenIds[index]);
        }
    }

    /// @notice msg.sender 에서 여러 recipient로 ERC721 batch transfer 하기.
    function batchTransferToMany(
        ERC721Partial tokenContract,
        address[] memory recipients,
        uint256[] memory tokenIds
    ) external {
        require(recipients.length == tokenIds.length, "recipient length must be equal to tokenIds length");
        uint256 length = tokenIds.length;
        for (uint256 index; index < length; ++index) {
            tokenContract.safeTransferFrom(msg.sender, recipients[index], tokenIds[index]);
        }
    }
}
