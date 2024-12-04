// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    struct Proposal {
        string name;
        uint voteCount;
    }

    Proposal[] public proposals;
    mapping(uint => mapping(address => bool)) public hasVoted;

    function createProposal(string memory _proposalName) public {
        proposals.push(Proposal({
            name: _proposalName, 
            voteCount: 0
        }));
    }

    function vote(uint _proposalId) public {
        require(_proposalId < proposals.length, "Invalid proposal id");
        require(!hasVoted[_proposalId][msg.sender], "You have already voted for this proposal");

        hasVoted[_proposalId][msg.sender] = true;
        proposals[_proposalId].voteCount++;
    }

    function getWinningProposal() public view returns (string memory winnerName, uint winnerVotes) {
        uint winningVoteCount = 0;
        uint winningProposalId = 0;

        for (uint i = 0; i < proposals.length; i++) {
            if(proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposalId = i;
            }
        }

        winnerName = proposals[winningProposalId].name;
        winnerVotes = proposals[winningProposalId].voteCount;
    }
}
