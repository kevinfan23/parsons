pragma solidity ^0.4.0;

contract SignUp {
    // non-dynamic array due to deploy charges
    address[] signedUpAddresses;
    uint pos;

    function SignUp() public {
        // 20 people capacity
        signedUpAddresses = new address[](20);
        pos = 0;
    }

    function signUp() public {
        // better with msg.sender
        signedUpAddresses[pos] =  msg.sender;
        pos += 1;
    }

    function getCount() public constant returns (uint) {
        return pos;
    }

    function getAddresses() public constant returns (address[]) {
        return signedUpAddresses;
    }
}
