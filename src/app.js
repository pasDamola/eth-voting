App = {
  loading: false,
  contracts: {},

  load: async () => {
    await App.loadWeb3();
    await App.loadAccount();
    await App.loadContract();
    App.loadUI();
  },

  // https://medium.com/metamask/https-medium-com-metamask-breaking-change-injecting-web3-7722797916a8
  loadWeb3: async () => {
    if (typeof web3 !== "undefined") {
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      window.alert("Please connect to Metamask.");
    }
    // Modern dapp browsers...
    if (window.ethereum) {
      window.web3 = new Web3(ethereum);
      try {
        // Request account access if needed
        await ethereum.enable();
        // Acccounts now exposed
        web3.eth.sendTransaction({
          /* ... */
        });
      } catch (error) {
        // User denied account access...
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = web3.currentProvider;
      window.web3 = new Web3(web3.currentProvider);
      // Acccounts always exposed
      web3.eth.sendTransaction({
        /* ... */
      });
    }
    // Non-dapp browsers...
    else {
      console.log(
        "Non-Ethereum browser detected. You should consider trying MetaMask!"
      );
    }
  },

  loadAccount: async () => {
    // Set the current blockchain account
    App.votersAccount = web3.eth.accounts[0];
    console.log(App.votersAccount);
  },

  loadContract: async () => {
    // Create a JavaScript version of the smart contract
    const election = await $.getJSON("Election.json");
    App.contracts.election = TruffleContract(election);
    App.contracts.election.setProvider(App.web3Provider);

    // Hydrate the smart contract with values from the blockchain
    App.election = await App.contracts.election.deployed();
  },

  loadUI: function() {
    var electionInstance;
    App.contracts.election
      .deployed()
      .then(function(instance) {
        electionInstance = instance;
        return electionInstance.nameoFElection.call();
      })
      .then(function(name) {
        $("#election-name")[0].innerHTML = name;
        return electionInstance.candidates.call(0);
      })
      .then(function(candidate1) {
        $("#results #candidate-name").children()[0].innerHTML = candidate1[0];
        $("#results #vote-count").children()[0].innerHTML = candidate1[1];
        return electionInstance.candidates.call(1);
      })
      .then(function(candidate2) {
        $("#results #candidate-name").children()[1].innerHTML = candidate2[0];
        $("#results #vote-count").children()[1].innerHTML = candidate2[1];
      })
      .catch(function(err) {
        console.log(err.message);
      });
    return App.bindEvents();
  },

  bindEvents : function() {
    $('.vote').on('click', function(){
      var voteIndex = $(this).attr("data-index");
      App.submitVote(voteIndex);
    })
  },

  submitVote : function(){
    App.contracts.election.deployed().then(function(instance){
      return instance.vote(voteIndex, {from : web3.eth.accounts[0]})
    })
  }
};

$(() => {
  $(window).load(() => {
    App.load();
  });
});
