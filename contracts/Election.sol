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
}