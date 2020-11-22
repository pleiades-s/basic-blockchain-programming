# basic-blockchain-programming
Basic solidity codes that you can play with truffle and ganache.
Truffle과 Ganache를 이용한 쉬운 블록체인 프로그래밍

## Introduction
본 레포지토리를 통해 여러분에게 블록체인 프로그래밍을 소개하고자 합니다. 막막했던 블록체인 프로그래밍의 첫 걸음이 될 수 있도록 최대한 쉽게 정리해보았습니다. 여러분이 따라하면서 블록체인에 코드를 배포하고 실행하는 방식을 이해하는데 도움이 되었으면 좋겠습니다. 스마트 컨트랙트는 Solidity 언어로, 배포 및 테스트 코드는 Javascript로 작성되어 있습니다. 각 언어의 문법에 대한 이해는 아래 튜토리얼에서 다루지 않으니 코드를 이해할 수 있는 정도만 숙지하고 계시면 되겠습니다.

### Truffle
Truffle은 스마트 컨트랙트 개발이 쉽도록 도와주는 Framework입니다. Truffle을 사용하여 여러분은 로컬 환경에서 스마트 컨트랙트를 컴파일, 배포 그리고 테스트까지 할 수 있습니다. Truffle의 기본 개발 환경은 `truffle init` 명령어를 통해 구성할 수 있습니다. 빈 디렉토리에서 해당 명령어를 입력하면 여러분은 아래와 같은 구조를 확인하실 수 있습니다.
```
.
├── contracts
│   └── Migrations.sol
├── migrations
│   └── 1_initial_migration.js
├── test
└── truffle-config.js
```
* contracts: Solidity로 작성된 스마트 컨트랙트 파일의 디렉토리; Truffle은 `contracts` 디렉토리 아래에 있는 `.sol` 파일을 모두 스마트 컨트랙트 파일로 간주하고 컴파일 하기 때문에 다른 위치에 있는 .sol 파일은 따로 컴파일하지 않습니다.

* migrations: 이더리움 네트워크에 배포할 때 사용되는 Javascript 파일의 디렉토리; 사용할 이더리움 네트워크는 `truffle-config.js`에서 지정한 후 명령어 옵션으로 선택할 수 있습니다.

* test: 배포한 스마트 컨트랙트를 테스트하는 Javascript 파일의 디렉토리

* truffle-config.js: Truffle 설정 파일; 이더리움 네트워크 및 solc compiler 설정할 수 있습니다.

본 레포지토리는 아래와 같은 구조를 가지고 있고, 현재 총 3개의 스마트 컨트랙트 소스 코드가 있고 각각의 컨트랙트 배포 및 테스트 파일이 존재합니다.

``` 
.
├── HELLOWORLD.md
├── MERKLETREE.md
├── README.md
├── TOKEN.md
├── contracts
│   ├── MerkleTree.sol
│   ├── MyFirstContract.sol
│   └── MyToken.sol
├── migrations
│   ├── 1_deploy_myfirstcontract.js
│   ├── 2_deploy_merkletree.js
│   └── 3_deploy_mytoken.js
├── package-lock.json
├── package.json
├── test
│   ├── merkletree_test.js
│   ├── myfirstcontract_test.js
│   └── mytoken_test.js
└── truffle-config.js
```

### Ganache
Ganche는 테스트용 이더리움 네트워크입니다. 메인넷 네트워크에 스마트 컨트랙트를 배포하기 전에, 로컬에서 Ganache를 통해 테스트용 이더리움 네트워크를 생성하고 테스트용 네트워크에 스마트 컨트랙트를 배포하고 테스트할 수 있습니다. 로컬에서만 동작하는 pseudo 이더리움 네트워크이기 때문에 트랜잭션 처리 속도도 Ropsten과 같은 다른 테스트넷보다 빠릅니다. 그리고 Ganache를 실행하면 100 Eth (물론 금전 가치 없음)를 가진 10개의 테스트 계정을 얻을 수 있습니다. 기본적으로 0번째 계정을 통해 스마트 컨트랙트 배포 및 테스트에 필요한 이더를 지불하게 됩니다.

## Prerequisites
본격적으로 코드와 놀기 전에 필요한 것들이 있습니다. 
*[NOTE] 만약 Windows OS 이신 분은 명령프롬프트(CMD) 창을 여시고 진행하시면 됩니다. Powershell로 하면 오류가 날 겁니다.*

1. node.js 설치
    [링크](https://nodejs.org/ko/)를 통해 현재 환경에 맞게 설치해주세요.
    설치가 다 되셨다면, 아래 명령어를 터미널/CMD(for Windows)에 입력해보세요.
    ```
    $ node -v
    v12.18.3

    $ npm -v
    6.14.8
    ```

2. solc 설치
    Solidity 컴파일러인 solcjs를 설치는 방법은 쉽습니다. 아래 명령어 한 줄로 설치하시면 됩니다.
    ```
    $ npm install -g solc
    ```
    만약 `npm WARN checkPermissions Missing write access to /usr/local/lib/node_modules/solc` 이라고 뜬다면, [링크](https://stackoverflow.com/a/54170648)를 확인해보세요. 
    그리고 아래 명령어를 통해 설치 여부를 알 수 있습니다.
    ```
    $ solc --version
    solc, the solidity compiler commandline interface
    Version: 0.7.0+commit.9e61f92b.Darwin.appleclang
    ```
    
3. truffle 설치
    아래 명령어로 쉽게 설치해보세요.
    ```
    $ npm install -g truffle
    ```
    아래 명령어로 설치 여부를 확인할 수 있습니다.
    ```
    $ truffle version
    Truffle v5.1.37 (core: 5.1.37)
    Solidity v0.5.16 (solc-js)
    Node v12.18.3
    Web3.js v1.2.1
    ```

4. ganache 설치
    똑같은 방법으로 ganache 까지 설치하고 설치 여부를 확인해봅시다. * 현재 환경이 mac os 이시면 GUI 버전을 [설치](https://www.trufflesuite.com/ganache)할 수 있습니다. *
    ```
    $ npm install -g ganache-cli
    ```
    ```
    $ ganache-cli --version
    Ganache CLI v6.12.0 (ganache-core: 2.13.0)
    ```

준비 운동 끝!

## Tutorials
본격적으로 시작해봅시다.

1. 코드 가져오기
    ```
    $ git clone https://github.com/pleiades-s/basic-blockchain-programming.git
    $ cd basic-blockchain-programming
    ```
    
2. 필요한 것들 설치하기
    아래 명령어를 입력하실 때, 현재 위치는 basic-blockchain-programming 디렉토리이어야 합니다.
    ```
    $ npm install
    ```
3. ganache-cli
    터미널(CMD for Windows) 새 창을 띄우시고, 아래 명령어를 입력합니다. 이 명령어를 통해 로컬 이더리움 네트워크를 실행합니다. 아래처럼 성공적으로 네트워크를 생성하셨으면 이 터미널 창은 잠시 옆으로 치워주시면 됩니다.
    ```
    $ ganache-cli -u 0
    Ganache CLI v6.12.0 (ganache-core: 2.13.0)

    Available Accounts
    ==================
    (0) 0xbD79CD192ee3de491c493a35012878B4Beea3327 (100 ETH)
    (1) 0x3c3754D01ED38dc8AD7E23fdE9e172f62DC122DE (100 ETH)
    (2) 0xBc1e0237228541F709b39653FF794A1cE80B9E3c (100 ETH)
    (3) 0x1316db14D45497f40644DBe7611C3267450D8838 (100 ETH)
    (4) 0x66E46C4561E49dD771E190a253c856Ae54445A94 (100 ETH)
    (5) 0x87219736Dfa004c86F77dF2D40151b4f3Ae79648 (100 ETH)
    (6) 0x9AE83EC1ae04269e2C2bc958a6177FCcE2f2350D (100 ETH)
    (7) 0xaE5e82Ba343Ae10B94652a54d29054CB8d8A0548 (100 ETH)
    (8) 0xE235622434D5469bf2D21E34fD8E7998FB3dB8F9 (100 ETH)
    (9) 0xcA209650F3755879Fb6a2e8B8d2d01D0F3CCcb38 (100 ETH)

    Private Keys
    ==================
    (0) 0x0b30a9cdf28128a11bf568c820644de0209dea4c03b17e8c55da44cb9317b597
    (1) 0xc7d8f6266f7110c61e00ce7dbbe57b70c1e29a85cf0d3565a680a874d472ad6f
    (2) 0x6f6f2eca1e73f743aa066d8ae7154b7cc1989bc0fc6368541f5d9a52f78ca9b7
    (3) 0x5d7b5a530aa12dfee80b54736b32f9508f38b77988fd169b5d241965f61b3795
    (4) 0x85e57f7e1ccfe9f49eb874eaa5e4faad180fca5b73220cf4343b0f9c27444d7f
    (5) 0x5833d16b314c64846b9c518b6f485b28c4339c5da983d6f5b186afca3642f078
    (6) 0xfc90b60e59f5176ad58d67c8191ca5da6c18b832e9814a969f048f753d689400
    (7) 0x67673627d116389e3ad1b6ee33f32573bdbba6abeb491e609cd62490e86c56b7
    (8) 0x26831a2e8c31655a25323d3075577aa0a2ef9dd6677a2ea1a473c96e178fa14d
    (9) 0x40e0a0354717c3dbad91ea4921f647d331d1ea2f4b67436379818879eafd50e9

    HD Wallet
    ==================
    Mnemonic:      method hair market birth jar tray hammer off loan blue floor fire
    Base HD Path:  m/44'/60'/0'/0/{account_index}

    Gas Price
    ==================
    20000000000

    Gas Limit
    ==================
    6721975

    Call Gas Limit
    ==================
    9007199254740991

    Listening on 127.0.0.1:8545
    ```

이제 본격적으로 예제 코드와 놀아봅시다 :)

### Hello World!
블록체인에서 어떻게 Hello World! 할까? [여기](https://github.com/pleiades-s/basic-blockchain-programming/blob/main/HELLOWORLD.md)를 클릭해주세요.

### Merkle Tree
머클 트리를 생성하고 증명하는 법! [여기](https://github.com/pleiades-s/basic-blockchain-programming/blob/main/MERKLETREE.md)를 클릭해주세요.

### ERC20 Token
나만의 ERC20 토큰 만들고, 메타마스크에서 확인해보자! [여기](https://github.com/pleiades-s/basic-blockchain-programming/blob/main/TOKEN.md)를 클릭해주세요.

### Final Note
따라하시다가 오류가 있거나 더 궁금한 점이 있으시면, 이슈 남겨주시거나 rudobco@g.skku.edu로 메일 보내주세요! 🤩
