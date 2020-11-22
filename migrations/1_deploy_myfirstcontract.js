const MyFirstContract = artifacts.require("MyFirstContract");

module.exports = function (deployer) {
  deployer.deploy(MyFirstContract);
};

