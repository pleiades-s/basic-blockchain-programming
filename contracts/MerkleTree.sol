// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

// MerkleProof is copied from node_modules/@openzeppelin/contracts/cryptography/MerkleProof.sol
// You can simply import the code but I just pasted it for the sake of better understanding.
library MerkleProof {
    /**
     * @dev Returns true if a `leaf` can be proved to be a part of a Merkle tree
     * defined by `root`. For this, a `proof` must be provided, containing
     * sibling hashes on the branch from the leaf to the root of the tree. Each
     * pair of leaves and each pair of pre-images are assumed to be sorted.
     */
    function verify(bytes32[] memory proof, bytes32 root, bytes32 leaf) internal pure returns (bool) {
        bytes32 computedHash = leaf;

        for (uint256 i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];

            if (computedHash <= proofElement) {
                // Hash(current computed hash + current element of the proof)
                computedHash = keccak256(abi.encodePacked(computedHash, proofElement));
            } else {
                // Hash(current element of the proof + current computed hash)
                computedHash = keccak256(abi.encodePacked(proofElement, computedHash));
            }
        }

        // Check if the computed hash (root) is equal to the provided root
        return computedHash == root;
    }
}

contract MerkleTree{

    bytes32 root;
    bytes32 leaf;
    bytes32[] proof;
    bytes32[] tree;

    constructor() public {

        tree.push(keccak256('a')); // tree[0]
        tree.push(keccak256('b')); // tree[1]
        tree.push(keccak256('c')); // tree[2]
        tree.push(keccak256('d')); // tree[3]

        // hashing(left_node, right_node) returns their parents node value.

        // Calculate a + b
        tree.push(hashing(tree[0], tree[1])); // tree[4] -> a + b

        // Calculte c + d
        tree.push(hashing(tree[2], tree[3])); // tree[5] -> c + d 

        // Calculate a + b + c + d -> root
        tree.push(hashing(tree[4], tree[5])); // tree[6] -> (a + b) + (c + d)
 
        root = tree[6]; // Merkle root: a + b + c + d 
        leaf = tree[0]; // Leaf node you want to verify: a
        
        // Generate the merkle proof
        proof.push(tree[1]); // b
        proof.push(tree[5]); // c + d

    }

    function hashing(bytes32 left, bytes32 right) private pure returns (bytes32) {
        if (left <= right) {
            return keccak256(abi.encodePacked(left, right));
        } else {
            return keccak256(abi.encodePacked(right, left));
        }
    }
    function doVerify() public view returns (bool) {
        return MerkleProof.verify(proof, root, leaf);
    }

}