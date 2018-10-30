pragma solidity ^0.4.23;
// pragma experimental ABIEncoderV2;

// import "../node_modules/zeppelin-solidity/contracts/math/SafeMath.sol";
// import "../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract NodeList is Ownable {
    using SafeMath for uint256;

    struct NodeInfo {
        bytes16 ipAddr;
        uint16 portNumber;
    }

    // index to nodeID
    mapping(uint256=>uint256) private nodeIndex;
    // nodeID to index
    mapping(uint256=>uint256) private nodeIndexLookup;
    uint256 nodeIndexLength;
    NodeInfo[] private allNodes;

    event NodeRegisted(uint256 nodeID, bytes16 ipAddr, uint16 portNumber);
    event NodeUnregisted(uint256 nodeID);

    function registerNode(bytes16 ipAddr, uint16 portNumber) public onlyOwner {
        NodeInfo memory nodeInfo = NodeInfo(ipAddr, portNumber);
        allNodes.push(nodeInfo);
        uint256 nodeID = allNodes.length.sub(1);
        nodeIndex[nodeIndexLength] = nodeID;
        nodeIndexLookup[nodeID] = nodeIndexLength;
        nodeIndexLength = nodeIndexLength.add(1);
        emit NodeRegisted(nodeID, ipAddr, portNumber);
    }

    // function getNode() public view returns(NodeInfo[]) {
    //     NodeInfo[] memory availableNodeInfo = new NodeInfo[](nodeIndexLength);
    //     for (uint256 i = 0; i < nodeIndexLength; i++) {
    //         availableNodeInfo[i] = allNodes[nodeIndex[i]];
    //     }
    //     return availableNodeInfo;
    // }

    function getNodeLength() public view returns(uint256) {
        return nodeIndexLength;
    }

    function getNodeByIndex(uint256 index) public view returns(uint256, bytes16, uint16) {
        require(index < nodeIndexLength, "invalid index");
        return (
            nodeIndex[index],
            allNodes[nodeIndex[index]].ipAddr,
            allNodes[nodeIndex[index]].portNumber
        );
    }

    function unregisterNode(uint256 nodeID) public onlyOwner {
        uint256 unregisterNodeIndex = nodeIndexLookup[nodeID];
        require(nodeIndex[unregisterNodeIndex] == nodeID, "nodeID not found");
        uint256 lastNodeID = nodeIndex[nodeIndexLength.sub(1)];
        uint256 lastNodeIndex = nodeIndexLookup[lastNodeID];
        nodeIndex[unregisterNodeIndex] = lastNodeIndex;
        nodeIndexLookup[lastNodeID] = unregisterNodeIndex;
        nodeIndexLength = nodeIndexLength.sub(1);
        emit NodeUnregisted(nodeID);
    }
}
