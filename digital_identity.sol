pragma solidity ^0.8.0;

contract IdentityManagementSystem {
    // Struct to represent a user's identity information
    struct Identity {
        string name;
        string email;
        uint256 age;
        bool isVerified;
    }

    // Mapping to store the user's identity information
    mapping(address => Identity) public identities;

    // Event to notify when a new identity is registered
    event IdentityRegistered(
        address indexed user,
        string name,
        string email,
        uint256 age
    );

    // Function to register a new identity
    function registerIdentity(
        string memory _name,
        string memory _email,
        uint256 _age
    ) public {
        require(identities[msg.sender].age == 0, "Identity already registered");
        identities[msg.sender] = Identity(_name, _email, _age, false);
        emit IdentityRegistered(msg.sender, _name, _email, _age);
    }

    // Function to verify an identity
    function verifyIdentity(address _user) public {
        require(msg.sender == _user, "Only the owner can verify the identity");
        identities[_user].isVerified = true;
    }

    // Function to get the identity information of a user
    function getIdentity(address _user)
        public
        view
        returns (
            string memory,
            string memory,
            uint256,
            bool
        )
    {
        return (
            identities[_user].name,
            identities[_user].email,
            identities[_user].age,
            identities[_user].isVerified
        );
    }
}
