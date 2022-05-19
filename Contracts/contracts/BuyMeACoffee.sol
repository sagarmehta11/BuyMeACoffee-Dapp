//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Deployed to 0x4aA22d276EE8119CccBf9e23FaF5715F9b1504aB

contract BuyMeACoffee {
    // Event to emit when a Memo is created.
    event NewMemo(
        address indexed from,
        uint256 timestamp, 
        string name,
        string message
    );

    //Memo struct.
    struct Memo{
        address from;
        uint256 timestamp; 
        string name;
        string message;
    }

    //List of all memos received from friends.
    Memo[] memos;

    //Address of contract deployer.
    address payable owner;

    //Deploy logic.
    constructor(){
        owner = payable(msg.sender);
    }

    /*
    * @dev buy a coffee for contract owner
    * @parameter _name name of the coffee buyer
    * @parameter _message a nice message from the coffee buyer
    */
    function buyCoffee(string memory _name, string memory _message) public payable{
        require(msg.value > 0, "can't buy me a coffee with 0 eth");

        //Add the memo to storage!
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a log event when a new memo is created!
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /*
    * @dev send the entire balance stored in this contract to the owner
    */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }
    /*
    * @dev send the entire balance stored in this contract to the owner
    */
    function getMemos() public view returns(Memo[] memory){
        return memos;
    }
}
