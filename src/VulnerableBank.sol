// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;
pragma abicoder v2;

contract VulnerableBank {
    // Estructura para almacenar los saldos de los usuarios
    mapping(address => uint256) private balances;

    // Variable de configuración (por ejemplo, tasa de interés)
    uint256 public interestRate;

    // Hash de la contraseña para cambiar la configuración
    bytes32 private passwordHash;

    // Evento para registrar los depósitos
    event Deposit(address indexed user, uint256 amount);

    // Evento para registrar los retiros
    event Withdrawal(address indexed user, uint256 amount);

    // Constructor que inicializa el contrato con una tasa de interés y una contraseña
    constructor(uint256 initialInterestRate, string memory password) {
        interestRate = initialInterestRate;
        passwordHash = keccak256(abi.encodePacked(password));
    }

    // Función para depositar fondos
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Función para retirar fondos
    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdrawal amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    // Función para consultar el saldo del usuario
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // Función para actualizar la tasa de interés, requiere la contraseña
    function updateInterestRate(uint256 newInterestRate, string memory password) public {
        if (keccak256(abi.encodePacked(password)) == passwordHash) {
            interestRate = newInterestRate;
        } else {
            revert("Incorrect password");
        }
    }

    // Función para calcular los intereses ganados por un usuario
    function calculateInterest(address user) public view returns (uint256) {
        return (balances[user] * interestRate) / 100;
    }
}
