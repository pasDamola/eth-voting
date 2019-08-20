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
        require(owner == msg.sender, "Only owner of contract is allowed to do this");
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
        require(voters[_voter].voted, "Voter has already voted");
        voters[_voter].authorized = true;
    }
}