pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract QuackContract {

    uint private _totalSupply;
    string[] currentHolders;
    
    // event Transaction(address indexed custodial, string indexed senderId, string receiverId, uint amount);
    //stretch goal: view past transactions by hashing slackid on both sides

    mapping(string => uint) balances;

    constructor() public {
        _totalSupply = 10000;
    }

    function name() public pure returns (string memory) {
        return "Quack";
    }

    function symbol() public pure returns (string memory) {
        return "QAK";
    }

    function checkBalance(string memory _slackId) public view returns(uint amount){
        return balances[_slackId];
    }
    function sendQuack(string memory _sender, string memory _receiver, uint amount) public returns(bool success){
        uint senderBalance = balances[_sender];
        require(senderBalance >= amount, "You don't have enough Quacks to complete that transaction.");

        bool existingUser = _checkIfExistingUser(_receiver);
        if(!existingUser){
            currentHolders.push(_receiver);
            balances[_sender] += (amount/2);
            _totalSupply += (amount/2);
        }
        senderBalance = balances[_sender];
        balances[_sender] = senderBalance - amount;
        balances[_receiver] += amount;
        //emit an event to notify and to store in log
        return true;
    }
    function getTotalSupply() public view returns(uint total) {
        return _totalSupply;
    }

    function mintQuacks(string memory _minter, uint amount) public returns(bool success) {
        uint length = currentHolders.length;
        _totalSupply += amount;
        uint perHolder = amount/length;
        for(uint i = 0; i < length; i++){
            string memory _tempId = currentHolders[i];
            balances[_tempId] += perHolder;
        }
        uint minterBal = balances[_minter];
        balances[_minter] = minterBal - (perHolder/2);

        return true;
    }

    function burnQuacks(string memory _bernieId, uint amount) public returns(bool success) {
        uint bernieBalance = balances[_bernieId];
        require(bernieBalance >= amount, "You don't have enough Quacks to complete that transaction.");
        balances[_bernieId] = bernieBalance - amount;
        _totalSupply = _totalSupply - amount;
        return true;
    }


    ///////UTILS//////////////////////////////////////////
    function removeUser(uint index) public returns(bool success) {
        uint lastElement = currentHolders.length - 1;
        string memory _temp = currentHolders[lastElement];
        currentHolders[index] = _temp;
        currentHolders.pop();
        return true;
    }
    function _checkIfExistingUser(string memory _slackId) private view returns(bool success){
        bool isInArray = false;
        for(uint i = 0; i < currentHolders.length; i++){
            string memory _temp = currentHolders[i];
            if(keccak256(abi.encodePacked(_temp)) == keccak256(abi.encodePacked(_slackId))) isInArray = true;
        }
        return isInArray;
    }
    function getAccountList() public view returns(string[] memory) {
        string[] memory tempArr = currentHolders;
        return tempArr;
    }
    function distributeCoin(string memory _slackId,uint amount) public returns(bool success) {
        balances[_slackId] += amount;
        return true;
    }       




    /////////STRETCH AND ERC-20 COMPLIANT FUNCTIONS///////


    // function decimals() public view returns (uint8) {
    //     return 0;
    // }
    // function balanceOf(address custodial) public view returns (uint256 balance){
    //     return balances[slackId];
    // } 
    // function transfer(string memory _slackId, address _to, uint256 _value) public returns (bool success){
        //check if slack account has enough to withdrawl
        //attempt to make transfer to recipeints account
        //if successful, withdraw amount from slack account and send a success event back
        
    // }
    // function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
    // function approve(address _spender, uint256 _value) public returns (bool success)
    // function allowance(address _owner, address _spender) public view returns (uint256 remaining)


    //backend function
    // function(slackId) {
    //     //checks the balance
    //     //if the balance is 0
    //         // make a call to get accountList
    //         // find index of slackId
    //         //call solidity deleteIdAtIndex function
    // }
}