// SPDX-License-Identifier: MIT

/*

██████╗ ███████╗██╗███╗   ██╗███████╗██╗  ██╗    ██████╗ ██████╗  ██████╗ ████████╗ ██████╗  ██████╗ ██████╗ ██╗     
██╔══██╗██╔════╝██║████╗  ██║██╔════╝╚██╗██╔╝    ██╔══██╗██╔══██╗██╔═══██╗╚══██╔══╝██╔═══██╗██╔════╝██╔═══██╗██║     
██║  ██║█████╗  ██║██╔██╗ ██║█████╗   ╚███╔╝     ██████╔╝██████╔╝██║   ██║   ██║   ██║   ██║██║     ██║   ██║██║     
██║  ██║██╔══╝  ██║██║╚██╗██║██╔══╝   ██╔██╗     ██╔═══╝ ██╔══██╗██║   ██║   ██║   ██║   ██║██║     ██║   ██║██║     
██████╔╝██║     ██║██║ ╚████║███████╗██╔╝ ██╗    ██║     ██║  ██║╚██████╔╝   ██║   ╚██████╔╝╚██████╗╚██████╔╝███████╗
╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝  ╚═════╝ ╚═════╝ ╚══════╝

-------------------------------------------- https://t.me/magawaodf_bot/start ------------------------------------------------------------

*/

pragma solidity ^0.8.0;

// Importing necessary contracts and libraries from OpenZeppelin
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

// Contract for MAGAWA_GAME
contract MAGAWA_GAME is Ownable, ReentrancyGuard {
    using SafeMath for uint256; // Using SafeMath for uint256 operations
    using SafeERC20 for IERC20; // Using SafeERC20 for safe ERC20 operations

    uint256 public exchangeRate; // Exchange rate for conversion

    IERC20 private magawaToken; // Instance of the MAGAWA token contract

    // Constructor to initialize the contract and set the initial exchange rate and token address
    constructor() Ownable(msg.sender) {
        exchangeRate = 1e3; // Initial exchange rate set to 0.001 MAGAWA per unit

        // Set the address of the MAGAWA token contract
        magawaToken = IERC20(0x82D1509e4F1C7468FbAa702eC69149EFA0b45574);
    }

    // Function to execute a token transfer to a specified address
    function execute(uint256 _value, address _address) external onlyOwner nonReentrant {
        // Calculate the amount of MAGAWA tokens to transfer based on the input value
        uint256 amount = calculateMagawa(_value);

        // Ensure the contract has enough tokens to complete the transfer
        require(magawaToken.balanceOf(address(this)) >= amount, "GAME: Insufficient tokens for transfer");

        // Transfer the calculated amount of MAGAWA tokens to the specified address
        magawaToken.safeTransfer(_address, amount);
    }
    
    // Function to calculate the amount of MAGAWA tokens based on the provided value
    function calculateMagawa(uint256 _value) public view returns (uint256) {
        return _value.mul(exchangeRate).div(1e6); // Calculate and return the amount of tokens
    }

    // Function to update the exchange rate (only callable by the owner)
    function setExchangeRate(uint256 _newRate) external onlyOwner {
        require(_newRate > 0, "Exchange rate must be positive"); // Ensure new rate is positive
        exchangeRate = _newRate; // Update the exchange rate
    }

    // Function for emergency withdrawal of tokens from the contract by the owner.
    function emergencyWithdraw(address _token, uint256 _amount) external onlyOwner {
        IERC20(_token).safeTransfer(owner(), _amount);
    }

    // Function for emergency withdrawal of ETH from the contract by the owner.
    function emergencyWithdrawETH(uint256 _amount) external onlyOwner {
        payable(owner()).transfer(_amount);
    }

}