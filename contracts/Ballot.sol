pragma solidity >=0.4.21 <0.6.0;

contract Ballot {
    uint public voteCount = 0;

     struct Voter {
        uint id;
        string name;
        bool voted;
  }

  constructor() public {
        vote("You have successfully voted");
   }

    event VoterCreated(
    uint id,
    string name,
    bool voted
  );

  mapping(uint => Voter) public voters;

  function vote(string memory _name) public {
    voteCount ++;
    voters[voteCount] = Voter(voteCount, _name, false);
    emit VoterCreated(voteCount, _name, false);
  }
}