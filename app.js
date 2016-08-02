var local= true;
var Web3 = require('web3');
//var web3 = new Web3();
if (typeof web3 !== 'undefined') {
  var web3 = new Web3(web3.currentProvider);
} else {
  // set the provider you want from Web3.providers
  if(local){

  		var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
}
else
{
		var web3 = new Web3(new Web3.providers.HttpProvider("http://65.52.189.129:8545"));

}
web3.eth.defaultAccount = web3.eth.accounts[0];
document.getElementById('account').innerText = web3.eth.defaultAccount;

var ABI=[{"constant":true,"inputs":[{"name":"bookID","type":"uint256"}],"name":"verifyLicense","outputs":[{"name":"license","type":"uint256"}],"type":"function"},{"constant":true,"inputs":[{"name":"listingID","type":"uint256"}],"name":"getListing","outputs":[{"name":"bookID","type":"uint256"},{"name":"isNew","type":"bool"},{"name":"price","type":"uint256"},{"name":"seller","type":"address"},{"name":"bookName","type":"string"},{"name":"authorName","type":"string"},{"name":"imageURL","type":"string"},{"name":"bookURL","type":"string"},{"name":"numOwners","type":"uint256"},{"name":"numLicensees","type":"uint256"}],"type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"books","outputs":[{"name":"bookName","type":"string"},{"name":"authorName","type":"string"},{"name":"imageURL","type":"string"},{"name":"bookURL","type":"string"},{"name":"price","type":"uint256"},{"name":"numOwners","type":"uint256"},{"name":"numLicensees","type":"uint256"}],"type":"function"},{"constant":false,"inputs":[{"name":"bookID","type":"uint256"}],"name":"list","outputs":[],"type":"function"},{"constant":true,"inputs":[],"name":"getNumberOfBooks","outputs":[{"name":"","type":"uint256"}],"type":"function"},{"constant":true,"inputs":[],"name":"getNumberOfListings","outputs":[{"name":"","type":"uint256"}],"type":"function"},{"constant":false,"inputs":[{"name":"listingID","type":"uint256"}],"name":"buyUsed","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"listingID","type":"uint256"}],"name":"buy","outputs":[],"type":"function"},{"constant":true,"inputs":[{"name":"bookID","type":"uint256"}],"name":"verifyOwnership","outputs":[{"name":"ownership","type":"uint256"}],"type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"listings","outputs":[{"name":"bookID","type":"uint256"},{"name":"isNew","type":"bool"},{"name":"price","type":"uint256"},{"name":"seller","type":"address"}],"type":"function"},{"constant":true,"inputs":[{"name":"bookID","type":"uint256"}],"name":"getBook","outputs":[{"name":"bookName","type":"string"},{"name":"authorName","type":"string"},{"name":"imageURL","type":"string"},{"name":"bookURL","type":"string"},{"name":"price","type":"uint256"},{"name":"numOwners","type":"uint256"},{"name":"numLicensees","type":"uint256"}],"type":"function"},{"constant":false,"inputs":[{"name":"bookName","type":"string"},{"name":"authorName","type":"string"},{"name":"imageURL","type":"string"},{"name":"bookURL","type":"string"},{"name":"price","type":"uint256"}],"name":"register","outputs":[{"name":"bookID","type":"uint256"}],"type":"function"},{"inputs":[{"name":"platformCommission","type":"uint256"}],"type":"constructor"}]
;
var i=0;
var Dindle = web3.eth.contract(ABI);
if(local){
var dindle = Dindle.at("0x2e952778010b5a02c781596f6cf2866cdcdf409f");
}
else
{
var dindle = Dindle.at("0x8322b607f7872eca33f4d52a78101ad10410f6af");	
}
}
