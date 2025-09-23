// Standard Import(s)
import std.stdio;
import std.string;

// Checks if the input is valid Chess notation.
bool isValidNotation(string input)
{
	if (input.length == 2)
	{
		char file = input[0];
		char rank = input[1];

		if (file >= 'A' && file <= 'H' && rank >= '1' && rank <= '8')
		{
			return true;
		}
	}

	return false;
}

// Returns a coordinate from a notation used for finding the wanted square.
Coordinate notationToCoordinate(string notation)
{
	int rowIndex = 8 - (notation[1] - '0');
	int columnIndex = notation[0] - 'A';
	Coordinate coordinate = [rowIndex, columnIndex];

	return coordinate;
}


// Represents a piece in Chess.
struct Piece
{
	// Possible piece names in Chess.
	enum Name
	{
		pawn,
		knight,
		bishop,
		rook,
		queen,
		king
	}

	// Stores the piece's name.
	Name name;
	// Stores the piece's color.
	// true = white
	// false = black
	bool isWhite;

	// Return the character used to display this piece.
	char returnDisplay()
	{
		char display;

		final switch (name)
		{
			case Name.pawn:
				display = 'p';

				break;
			case Name.knight:
				display = 'n';

				break;
			case Name.bishop:
				display = 'b';

				break;
			case Name.rook:
				display = 'r';

				break;
			case Name.queen:
				display = 'q';

				break;
			case Name.king:
				display = 'k';

				break;
		}

		if (isWhite)
		{
			display = cast(char) (display - 'a' + 'A');
		}

		return display;
	}
}

// Represents a square's row and column index on a 2d array.
alias Coordinate = int[2];
// A map of the pieces on the chessboard by it's coordinates.
Piece[Coordinate] pieces;

// Displays the current chessboard state to the console.
void writeBoard()
{
	char[8][8] board = [
		[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
	];

	foreach (coordinate, piece; pieces)
	{
		board[coordinate[0]][coordinate[1]] = piece.returnDisplay();
	}

	foreach (row; board)
	{
		foreach (column; row)
		{
			write('[', column, ']');
		}

		writeln();
	}
}

// Possible states of a Chess game.
enum GameState
{
	normal,
	stalemate,
	checkmate
}

// Stores the user's input.
string userInput;

// Stores who's player's turn it is.
// true = white
// false = black
bool isWhiteTurn = true;

// Checks if the selected piece is able to be used by the player.
bool isValidPiece(Coordinate coordinate)
{
	if (coordinate in pieces)
	{
		Piece piece = pieces[coordinate];

		if (piece.isWhite == isWhiteTurn)
		{
			return true;
		}
	}

	return false;
}

// Return the game state used to check the outcome.
// Reminder: Actually add the logic.
GameState returnGameState()
{
	return GameState.normal;
}

// Entry Point
void main()
{
	// Greeting
	writeln("Welcome to D Chess!");

	// Stores the start order of the major pieces.
	Piece.Name[8] majorOrder = [
		Piece.Name.rook,
		Piece.Name.knight,
		Piece.Name.bishop,
		Piece.Name.queen,
		Piece.Name.king,
		Piece.Name.bishop,
		Piece.Name.knight,
		Piece.Name.rook,
	];

	// Program Loop
	// Exits when the user types E.
	do
	{
		// Resets the board at the start of the game.
		pieces = null;

		// Stores the nessecary values for adding pieces.
		Piece.Name pieceName;
		bool isWhite;
		Coordinate coordinate;

		for (int columnIndex; columnIndex < 8; columnIndex++)
		{
			// Pawn Initalization
			pieceName = Piece.Name.pawn;

			isWhite = false;
			coordinate = [1, columnIndex];
			pieces[coordinate] = Piece(pieceName, isWhite);

			isWhite = true;
			coordinate = [6, columnIndex];
			pieces[coordinate] = Piece(pieceName, isWhite);

			// Major Piece Initalization
			pieceName = majorOrder[columnIndex];

			isWhite = false;
			coordinate = [0, columnIndex];
			pieces[coordinate] = Piece(pieceName, isWhite);

			isWhite = true;
			coordinate = [7, columnIndex];
			pieces[coordinate] = Piece(pieceName, isWhite);
		}

		// Exits when the game ends in a stalemate or checkmate.
		do
		{
			// Game Loop
			// Displays the current chessboard state.
			writeBoard();

			if (isWhiteTurn)
			{
				writeln("White's turn");
			}
			else
			{
				writeln("Black's turn");
			}

			// Stores the player's selected piece.
			Coordinate pieceCoordinate;

			// Gets and stores the player's selected piece.
			// Exits when the piece's color matches the player's color.
			do
			{
				// Exits when the user input is valid Chess notation.
				do
				{
					write("Please input the notation of the selected piece: ");
					userInput = strip(readln());
				}
				while (!isValidNotation(userInput));

				pieceCoordinate = notationToCoordinate(userInput);
			}
			while (!isValidPiece(pieceCoordinate));

			// Display's selected piece to player.
			writeln("Selected Piece: ", pieces[pieceCoordinate].returnDisplay());

			// Switches the player's turn.
			isWhiteTurn = !isWhiteTurn;
		}
		while (returnGameState() == GameState.normal);

		write("Type E to exit program: ");
		userInput = strip(readln());
	}
	while (userInput != "E");
}
