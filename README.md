
# VulnerableBank Smart Contract

## Descripción

Este proyecto incluye un contrato inteligente simple denominado VulnerableBank y una serie de tests para verificar su funcionamiento. El contrato permite a los usuarios depositar y retirar fondos, así como consultar su saldo. Además, incluye una funcionalidad para actualizar la tasa de interés, protegida por una contraseña.
## Contenido

- Descripción del Contrato
- Funciones Principales
- Eventos
- Requisitos
- Instalación
- Ejecución de Tests
- Seguridad

## Descripción del contrato
VulnerableBank es un contrato en Solidity que permite la gestión de depósitos y retiros de fondos para múltiples usuarios. Además, incluye la capacidad de actualizar la tasa de interés mediante el uso de una contraseña segura.
## Funciones principales

- Constructor: Inicializa el contrato con una tasa de interés inicial y una contraseña.
- deposit: Permite a los usuarios depositar fondos en el contrato.
- withdraw: Permite a los usuarios retirar fondos del contrato.
- getBalance: Consulta el saldo actual del usuario.
- updateInterestRate: Permite actualizar la tasa de interés usando una contraseña.
- calculateInterest: Calcula el interés ganado por un usuario.

#### Depósitos y retiros:
Los usuarios pueden depositar fondos utilizando la función deposit, que incrementa su saldo.
Pueden retirar fondos utilizando la función withdraw, que decrece su saldo y transfiere el monto solicitado.
#### Consultas de saldo:
Los usuarios pueden consultar su saldo actual con la función getBalance.
#### Configuración de la tasa de interés:
La tasa de interés inicial se establece en el constructor.
Se puede actualizar la tasa de interés utilizando la función updateInterestRate, que requiere una contraseña. Aquí es donde está la vulnerabilidad: si la contraseña es conocida por un atacante, este podría cambiar la configuración del contrato.
#### Cálculo de intereses:
La función calculateInterest calcula los intereses acumulados para un usuario en base a su saldo y la tasa de interés configurada.
## Eventos
- Deposit: Se emite cuando un usuario realiza un depósito.
- Withdrawal: Se emite cuando un usuario realiza un retiro.
## Requisitos

### IDE

Se recomienda utilizar un entorno de desarrollo integrado (IDE) como Visual Studio Code o Remix para interactuar con el contrato, además es necesario instalar la extensiones de solídity para un desarrollo óptimo.

## ¿Por qué Foundry?
- Es un framework rápido y eficiente.
- Permite escribir tests y scripts directamente en Solidity.
- Incluye múltiples cheatcodes para testing y debugging.





## Instalación de Foundry
## Paso a Paso

Instalación básica:

```bash
  curl -L https://foundry.paradigm.xyz | bash
```
Añadir Foundry al PATH:

```bash
  source /home/user/.bashrc 
  foundryup
```
Añadir Foundry al PATH:

```bash
forge --version
```

## Instalación

### Clonar el repositorio:

```bash
git clone https://github.com/tu-repo/VulnerableBank.git
cd VulnerableBank

```
### Instalar dependencias:

```bash
forge install foundry-rs/forge-std --no-commit
```

### Compilar el proyecto:

```bash
forge build

```
## Ejecución de Test
Para ejecutar los tests, utilizamos Foundry. Los tests se encuentran en la carpeta /test y validan el funcionamiento de las funciones principales del contrato.

### Comandos de Ejecución

### · Ejecutar todos los tests:
```bash
forge test -vvvv

```
## Tests Incluidos
- testDeposit: Verifica que un usuario pueda depositar fondos correctamente.
- testWithdraw: Verifica que un usuario pueda retirar fondos correctamente.
- testWithdrawInsufficientBalanceRevert: Verifica que no se puedan retirar más fondos de los disponibles.
- testUpdateInterestRateWithCorrectPassword: Verifica que la tasa de interés se pueda actualizar con la contraseña correcta.
- testUpdateInterestRateWithIncorrectPasswordRevert: Verifica que la tasa de interés no se pueda actualizar con una contraseña incorrecta.
- testCalculateInterest: Calcula los intereses ganados por un usuario.
- testDepositRevertIfZero: Verifica que no se puedan depositar 0 fondos.
- testWithdrawRevertIfZero: Verifica que no se puedan retirar 0 fondos.
## Seguridad

El contrato está diseñado para ser un ejemplo educativo y contiene varias vulnerabilidades que pueden ser explotadas. Se recomienda revisar el contrato y realizar una auditoría exhaustiva antes de utilizarlo en un entorno de producción.

### Posibles Vulnerabilidades

* Desbordamiento de enteros: Usar una versión anterior a Solidity 0.8.0 puede permitir desbordamientos de enteros.
* Acceso no autorizado: Asegurarse de que las funciones críticas están adecuadamente protegidas.
* Reentrancy Attack: Verificar que las funciones de retiro son seguras contra ataques de reentrada.
## Conclusión
Este proyecto proporciona una introducción práctica a la seguridad en contratos inteligentes con Solidity. A través del análisis del contrato y la ejecución de tests, los desarrolladores pueden comprender mejor cómo construir y asegurar contratos inteligentes en la blockchain.

Para más detalles, consulte el código fuente del contrato y los tests incluidos en el repositorio.