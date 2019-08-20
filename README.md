# eth-voting
exploring the power of blockchain with a voting application, using the ethereun blockchain platform

Blockchain-based voting has its advantages in terms of preventing rigging and establishing security. 
This is because the rules of voting are specified in the smart contract which could be that someone under 18 should not be allowed to vote,
Also because of the nature of the blockchain tech, once someone casts his or her vote, the transaction is stored on the blockchain and 
they can neither be removed nor can they be updated. This maintains the integrity and security of the votes.

Various functions in this contract are described below:

### getNumCandidates():
 This function returns the number of candidates up for the election

### addCandidates():
 This function takes a "name" parameter and permits ONLY the owner/admin of this contract to add candidates to the Candidate array
 
### authorize():
 This is where the owner/admin of the contract authorizes voters based on whatever rules are specified in the contract
 
### vote():
 An authorized voter can vote, if he has not already voted
 
### winningProposal():
 This function returns the calculates the candidate the with highest voteCount

### winnerName():
 Declares the name of the winner

