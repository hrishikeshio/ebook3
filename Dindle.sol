/**/
contract Dindle{
 	address contractOwner = msg.sender;
 	bool public _success = true;
	mapping(uint => Book) public books;
	uint numBooks;
  modifier noether { if (msg.value > 0) throw; _ }
  modifier onlyLicensee(uint bookID) { if (books[bookID].licensees[msg.sender] == 0) throw; _ }

	struct Book{
		uint serial;
		string bookName;
		string authorName;
		string imageURL;
		string bookURL;
		uint price;
		uint resellPrice;
		uint resellCommission;
		mapping (address => uint) owners;
		mapping (address => uint) licensees; //0=dont ownn 1=licensed 2=selling
		uint numOwners;
		uint numLicensees;
	}

	struct Owner{
		string ownerName;
		address ownerAddress;
		uint stake;
	}

 	struct Licensee{
 		//string licenseeName;
 		address licenseeAddress;
 	}


	function Dindle (uint platformCommission) noether  {
		uint totalBooks=0;
		//register("a","a","a","a",1,1,1);
		//platformCommission;
	}

	function register (
		string bookName,
		string authorName,
		string imageURL,
		string bookURL,
		uint price,
		uint resellPrice,
		uint resellCommission
		) noether public returns (uint bookID)
	{
		bookID=numBooks++;
		books[bookID]=Book(0,bookName,authorName, imageURL, bookURL, price, resellPrice, resellCommission,0,0);
		Book b = books[bookID];
// 		uint stake=100.0;
		b.owners[msg.sender]=100;
		b.numOwners=1;
		b.licensees[msg.sender]=1;
		b.numLicensees=1;
	}

  function list(uint bookID) onlyLicensee(bookID)
  {
    books[bookID].licensees[msg.sender]=2;
  }
  function verifyLicense(uint bookID) constant public returns (uint license)
  {
    license=books[bookID].licensees[msg.sender];
  }
  function verifyOwnership(uint bookID) constant public returns (uint ownership)
  {
    ownership=books[bookID].owners[msg.sender];
  }
	function getNumberOfBooks() constant public returns(uint256)
	{
		return numBooks;
	}
//"a","a","a","a",1,1,1
	function getBook(uint bookID) constant public returns
  (string bookName,
  string authorName,
  string imageURL,
  string bookURL,
  uint256 price,
  uint256 resellPrice,
  uint256 resellCommission,
  uint256 numOwners,
  uint256 numLicensees)
	{
	    Book book=books[bookID];
	    bookName=book.bookName;
	    authorName=book.authorName;
	    imageURL=book.imageURL;
	    bookURL=book.bookURL;
	    price=book.price;
	    resellPrice=book.resellPrice;
	    resellCommission=book.resellCommission;
	    numOwners=book.numOwners;
	    numLicensees=book.numLicensees;

	}

	function sell(uint bookID_, address licenseeAddress_)
	{
	    Book b = books[bookID_];
	    uint256 serial = b.serial;
	    b.serial=serial++;
	    b.licensees[licenseeAddress_]=1;
	    //b.licensees[serial]=Licensee(licenseeAddress_);

	}

	function resell(uint bookID_, address newLicenseeAddress_)
  {

	    Book b = books[bookID_];
	    if (b.licensees[msg.sender]!=1)
	    {
	        throw;
	    }
	    b.licensees[msg.sender]=0;
	    b.licensees[newLicenseeAddress_]=1;

	}

}

/*0x8aaf6462cad9a13489813406e3bcfc6aac37ae53
0x47938cd57f6f77e296f6972f2f95635d6ef224d6
0x5de054536c84d036e68c61e80e5da4a3eb5df00a
0xb6e1975612b19c13dd74429077eda48b6b6e85cf
0xbde87d26cb80d890d560a4deb5e4d20b55ed3d0f
0x215ceaabaa58ab2d1ab76df6eb2920c29ec40bae
0x62450b14f5d010a943e4dfd6c3ace56d5a4ed5bb
0x47c4b670a24296885736686a4b3537f81bced70f
0xbcc3175fbac8fbf076f8b29adbcb65feef910b96
0x98e9f8affa93ea2283136625a6cfdf60d5934d12
http://d.gr-assets.com/books/1327656754l/11.jpg
*/
