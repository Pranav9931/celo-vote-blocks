// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingContract {
    address public admin;
    bool public votingOpen;
    
    mapping(address => bool) public voters;
    mapping(address => bool) public hasVoted;
    mapping(string => uint256) public voteCount;
    
    string[] public candidateList = ["PartyA", "PartyB", "PartyC"];

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    modifier onlyDuringVoting() {
        require(votingOpen, "Voting is closed");
        _;
    }

    modifier onlyRegisteredVoter() {
        require(voters[msg.sender], "Sender is not a registered voter");
        _;
    }

    modifier hasNotVoted() {
        require(!hasVoted[msg.sender], "Voter has already voted");
        _;
    }

    constructor() {
        admin = msg.sender;
        votingOpen = true;
    }

    function registerVoter(address _voter) external onlyAdmin {
        voters[_voter] = true;
    }

    function endVoting() external onlyAdmin {
        votingOpen = false;
    }

    function isAdmin() external view returns (bool) {
        return msg.sender == admin;
    }

    function getVoteCount(string memory _candidate) external view returns (uint256) {
        return voteCount[_candidate];
    }

    function getCandidateList() external view returns (string[] memory) {
        return candidateList;
    }

    function getVoterStatus() external view returns (bool) {
        return voters[msg.sender];
    }

    function submitVote(string memory _candidate) external onlyDuringVoting onlyRegisteredVoter hasNotVoted {
        require(bytes(_candidate).length > 0, "Candidate name cannot be empty");
        voteCount[_candidate]++;
        hasVoted[msg.sender] = true;
    }

    function getFinalResult() external onlyAdmin view returns (string[] memory, uint256[] memory) {
        require(!votingOpen, "Voting is still open");
        
        uint256[] memory result = new uint256[](candidateList.length);
        for (uint256 i = 0; i < candidateList.length; i++) {
            result[i] = voteCount[candidateList[i]];
        }

        return (candidateList, result);
    }
}
