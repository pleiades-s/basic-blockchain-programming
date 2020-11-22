const MyToken = artifacts.require("MyToken");

module.exports = function (deployer) {
  const _name = "My Token";
  const _symbol = "MTK";
  deployer.deploy(MyToken, _name, _symbol);
};
