pragma solidity >=0.4.0 <0.7.0;

contract Election{
    address public owner;
    string public nameoFElection;
    
    event Vote(string candidateName, uint voteCount);
    
    struct Candidate {
        string name;
        uint voteCount;
    }
    
    struct Voter{
        bool authorized;
        bool voted;
        uint vote; // candidate id
    }
    
    uint public totalVotes;
    Candidate[] public candidates;
    mapping(address => Voter) public voters;
    
    modifier ownerOnly(){
        require(owner == msg.sender, "Only owner is permitted to do this");
        _;
    }
    
    constructor(string memory _name) public {
        owner = msg.sender;
        nameoFElection = _name;
    }
    
    function getNumCandidates() public view returns(uint){
        return candidates.length;
    }
    
    function addCandidates(string memory _name) public ownerOnly {
        candidates.push(Candidate(_name, 0));
    }
    
    function authorize(address _voter) public ownerOnly{
        require(!voters[_voter].voted, "Voter already voted");
        voters[_voter].authorized = true;
    }
    
    function vote(uint _candidate) public payable {
        require(!voters[msg.sender].voted, "Voter already voted");
        require(voters[msg.sender].authorized, "Not authorized to vote");
        require(_candidate < candidates.length, "Not a valid candidate");
        
        voters[msg.sender].vote = _candidate;
        voters[msg.sender].voted = true;
        
        totalVotes += 1;
        candidates[_candidate].voteCount += 1;
        emit Vote(candidates[_candidate].name, candidates[_candidate].voteCount);
    }
    
    // function winningProposal() public view returns (uint _candidate){
    //     uint winningVoteCount = 0;
    //     for (uint p = 0; p < candidates.length; p++) {
    //         if (candidates[p].voteCount > winningVoteCount) {
    //             winningVoteCount = candidates[p].voteCount;
    //             _candidate = p;
    //         }
    //     }
    // }
    
    // function winnerName() public view returns (string memory  _candidate){
    //     _candidate = candidates[winningProposal()].name;
    // }
}