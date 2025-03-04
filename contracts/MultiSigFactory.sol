// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "hardhat/console.sol";
import "./MultiSigWallet.sol"; // Ensure this file exists at the specified path

contract MultiSigFactory {
    // --------------- STORAGE ----------------
    uint256 id; // 256 bit to store the id of the wallet
    mapping(uint256 => address) public multiSigWalletInstances; // Hash function to mapping the id to the wallet address
    mapping(address => mapping(address => bool)) public ownerWallets; // check if the owner has the wallet

    // --------------- EVENT ----------------
    /*
            createdBy: the address that created the wallet
            idWallet: the id of the wallet
            addressWallet: the address of the wallet
            owners: the owners of the wallet
            required: the number of owners required to sign a transaction
    */
    event WalletCreated(
        address createdBy,
        uint256 idWallet,
        address addressWallet,
        address[] owners,
        uint256 required
    );

    function createWallet(
        address[] calldata _owners,
        uint256 _required
    ) external {
        MultiSigWallet newMultiSigWalletContract = new MultiSigWallet(
            _owners,
            _required,
            address(this)
        );

        id += 1;
        multiSigWalletInstances[id] = address(newMultiSigWalletContract);

        for (uint256 i; i < _owners.length; i++) {
            ownerWallets[_owners[i]][address(newMultiSigWalletContract)] = true;
        }
        emit WalletCreated(
            msg.sender,
            id,
            address(newMultiSigWalletContract),
            _owners,
            _required
        );
    }

    function updateOwner(
        address _owner,
        address _multiSigContractAddress,
        bool _isAdd
    ) external {
        if (_isAdd) {
            ownerWallets[_owner][address(_multiSigContractAddress)] = true;
        } else {
            ownerWallets[_owner][address(_multiSigContractAddress)] = false;
        }
    }

    /*
     public: call inside and outside the contract
     external: call only outside the contract, only call inside contract with keyword this

    */
}
