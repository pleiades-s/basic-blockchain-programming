# Hello World를 화면에 출력하는 법

## MyFirstContract
```
contract MyFirstContract {
    constructor() public {}
    function printHelloWorld() public view returns(string memory){
        return "Hello World!";
    }
}
```
`contracts/MyFirstContract.sol`의 코드에 printHelloWorld() 함수가 있습니다. 이 함수를 통해 우리는 콘솔에 Hello World! 를 출력할 수 있습니다. 이 함수의 파라미터는 없고 "Hello World!" 문자열을 반환하는 함수입니다. 

## Compile
```
$ truffle compile

Compiling your contracts...
===========================
> Compiling ./contracts/MerkleTree.sol
> Compiling ./contracts/MyFirstContract.sol
> Artifacts written to /Users/username/Workspace/basic-blockchain-programming/build/contracts
> Compiled successfully using:
   - solc: 0.6.11+commit.5ef660b1.Emscripten.clang
```
위의 명령어를 통해 코드를 컴파일 할 수 있습니다. Truffle은 *contracts* 디렉토리 아래 모든 `.sol` 파일을 컴파일 하는 것을 알 수 있습니다.

## Deploy
compile 명령어와 마찬가지로 `truffle migrate`도 *migrations* 디렉토리 아래 모든 `.js` 파일을 통해 스마트 컨트랙트를 배포하는 것을 알 수 있습니다. 여기서 배포한다는 의미는 쉽게 말해 작성한 코드를 이더리움 네트워크에 전송하여 저장한다는 의미로 이해해도 좋을 것 같습니다.
```
$ truffle migrate


Compiling your contracts...
===========================
> Compiling ./contracts/MerkleTree.sol
> Artifacts written to /Users/pleiadex/Workspace/basic-blockchain-programming/build/contracts
> Compiled successfully using:
   - solc: 0.6.11+commit.5ef660b1.Emscripten.clang



Starting migrations...
======================
> Network name:    'development'
> Network id:      1606043634322
> Block gas limit: 6721975 (0x6691b7)


1_deploy_myfirstcontract.js
===========================

   Deploying 'MyFirstContract'
   ---------------------------
   > transaction hash:    0x05f208f1189d081983913b4893a577925be43d4b6d95cdd112cc2759490dbd3e
   > Blocks: 0            Seconds: 0
   > contract address:    0xE2EDa82B103F3A4dD54c2A8f94d99E0f22CDF58C
   > block number:        39
   > block timestamp:     1606059346
   > account:             0xbD79CD192ee3de491c493a35012878B4Beea3327
   > balance:             99.51949564
   > gas used:            115009 (0x1c141)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00230018 ETH

   > Saving artifacts
   -------------------------------------
   > Total cost:          0.00230018 ETH


2_deploy_merkletree.js
======================

   Replacing 'MerkleTree'
   ----------------------
   > transaction hash:    0x6047896d9bc90d9b6c013a88571fb08e67d26bf5eeb9f7cd90ac72309b78e28d
   > Blocks: 0            Seconds: 0
   > contract address:    0x859A71c1357A5A3805013E74C56d2219B4637916
   > block number:        40
   > block timestamp:     1606059346
   > account:             0xbD79CD192ee3de491c493a35012878B4Beea3327
   > balance:             99.5104908
   > gas used:            450242 (0x6dec2)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00900484 ETH

   > Saving artifacts
   -------------------------------------
   > Total cost:          0.00900484 ETH


3_deploy_mytoken.js
===================

   Replacing 'MyToken'
   -------------------
   > transaction hash:    0x550faa0dad10edea7272a6618b6cb0156ba0c90f806bf7fc7082457a7d8ada5b
   > Blocks: 0            Seconds: 0
   > contract address:    0x04177fA2DaAd7041bdD2F1a0ADcE46E388633986
   > block number:        41
   > block timestamp:     1606059346
   > account:             0xbD79CD192ee3de491c493a35012878B4Beea3327
   > balance:             99.48792238
   > gas used:            1128421 (0x1137e5)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.02256842 ETH

   > Saving artifacts
   -------------------------------------
   > Total cost:          0.02256842 ETH


Summary
=======
> Total deployments:   3
> Final cost:          0.03387344 ETH
```

## Test
```
contract('MyFirstContract', () => {
    before(async () => {
        myfirstcontract = await MyFirstContract.new(); // Deploy new MyFirstContract contract before testing.
    })

    it('Should deploy a smart contract properly', async () => {
        // console.log(myfirstcontract.address);
        assert(myfirstcontract.address != ''); // The deployed contract's address should not be null.
    })

    it('Should return hello world', async () => {
        const result = await myfirstcontract.printHelloWorld();
        console.log(result);
        assert(result === 'Hello World!'); // The return string of getStr() should be "Hello World".

    })
})
```

`test/myfirstcontract_test.js` 코드의 일부분입니다. Truffle 테스트 코드를 통해 쉽게 배포된 스마트 컨트랙트의 변수 값을 확인하거나 함수를 실행할 수 있습니다. 위 테스트 코드에서는 2 가지를 확인하는데, 하나는 배포된 컨트랙트의 주소가 `null` 아닌지 확인하고 이로써 배포 성공 여부를 확인합니다. 두번째는 `printHelloWorld()` 함수를 실행시키고 그 결과 값을 `result`라는 변수에 저장합니다. 그리고 `result`가 "Hello World!"를 가지고 있는지 확인합니다.


테스트 코드는 아래 명령어로 실행할 수 있습니다. 테스트 결과, 두 케이스 모두 통과하였고 `console.log(result);`를 통해 콘솔에 "Hello World!"를 성공적으로 출력해보았습니다.
```
$ truffle test test/myfirstcontract_test.js
Using network 'development'.


Compiling your contracts...
===========================
> Compiling ./contracts/MerkleTree.sol
> Artifacts written to /var/folders/wj/_8d_tlzs7jl_c_qtv72j7rs40000gn/T/test--48597-Jv6nvvgvKnF0
> Compiled successfully using:
   - solc: 0.6.11+commit.5ef660b1.Emscripten.clang



  Contract: MyFirstContract
    ✓ Should deploy a smart contract properly
Hello World!
    ✓ Should return hello world (40ms)


  2 passing (294ms)
```