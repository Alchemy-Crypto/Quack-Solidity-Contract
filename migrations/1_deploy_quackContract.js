const quackContract = artifacts.require("quackContract");

module.exports = function (deployer) {
    deployer.deploy(quackContract);
};
