contract Dindle{
	address contractOwner = msg.sender;
	mapping(uint => Book) public books;
	mapping(uint => Listing) public listings;
	uint numBooks;
	uint numListings;

	modifier noether { if (msg.value > 0) throw; _ }
	modifier onlyLicensee(uint bookID) { if (books[bookID].licensees[msg.sender] == 0) throw; _ }

	struct Book{
		string bookName;
		string authorName;
		string imageURL;
		uint price;
		mapping (address => uint) owners;
		mapping (address => uint) licensees; //0=dont ownn 1=licensed 2=selling
		uint numOwners;
		uint numLicensees;
	}

	struct Listing{
		uint256 bookID;
		bool isNew;
		uint256 price;
		address seller;
	}

	function Dindle (uint platformCommission) noether  {
		register("The legend of Simba","Jesus Christ","https://images-na.ssl-images-amazon.com/images/I/51Q0R48W6PL.jpg",1);
		register("Sin city","Frank miller","https://upload.wikimedia.org/wikipedia/en/d/da/Sin_City_Hard_Goodbye.jpg",2);
		list(1);
	}

	function register (
		string bookName,
		string authorName,
		string imageURL,
		uint price
		) noether public returns (uint bookID)
	{	bookID=numBooks;
		numBooks++;
		books[bookID]=Book(bookName,authorName, imageURL, 
			price, 0,0);
		uint listingID=numListings;
		numListings++;
		listings[listingID]=Listing(bookID, true, price,msg.sender );
		Book b = books[bookID];
		// 		uint stake=100.0;
		b.owners[msg.sender]=100;
		b.numOwners=1;
		b.licensees[msg.sender]=2;
		b.numLicensees=1;
	}

	function buy(uint listingID)
	{
		Listing l = listings[listingID];
		Book b = books[l.bookID];
		b.licensees[msg.sender]=1;
		//b.licensees[serial]=Licensee(licenseeAddress_);
	}

	function buyUsed(uint listingID)
	{
		Listing l = listings[listingID];
		Book b = books[l.bookID];
		b.licensees[msg.sender]=1;
		delete listings[listingID];
		//b.licensees[serial]=Licensee(licenseeAddress_);
	}

	function list(uint bookID) onlyLicensee(bookID)
	{
		books[bookID].licensees[msg.sender]=2;
		listings[numListings++]=Listing(bookID,false,books[bookID].price,msg.sender);

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
	function getNumberOfListings() constant public returns(uint256)
	{
		return numListings;
	}
	//"a","a","a","a",1,1,1
	function getBook(uint bookID) constant public returns
	(string bookName,
		string authorName,
		string imageURL,
		uint256 price,
		uint256 numOwners,
		uint256 numLicensees)
	{
		Book book=books[bookID];
		bookName=book.bookName;
		authorName=book.authorName;
		imageURL=book.imageURL;
		price=book.price;
		numOwners=book.numOwners;
		numLicensees=book.numLicensees;

	}
	function getListing(uint listingID) constant public returns
	(uint bookID,
		bool isNew,
		uint price,
		address seller,
		string bookName,
		string authorName,
		string imageURL,
		uint256 numOwners,
		uint256 numLicensees)
	{	Listing l = listings[listingID];
		bookID=l.bookID;
		isNew=l.isNew;
		price=l.price;
		seller=l.seller;
		Book book=books[bookID];
		bookName=book.bookName;
		authorName=book.authorName;
		imageURL=book.imageURL;
		price=book.price;
		numOwners=book.numOwners;
		numLicensees=book.numLicensees;
	}
}