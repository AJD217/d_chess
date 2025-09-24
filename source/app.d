// Standard Import(s)
import std.stdio : write, readln;
import std.string : strip;

// Local Import(s)
import board;

// Checks if the input is Chess notation.
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

int[2] notationToCoordinate(string notation)
{
	int rowIndex = '8' - notation[1];
	int columnIndex = notation[0] - 'A';

	return [rowIndex, columnIndex];
}

// Decides whose turn it is.
// true = white | false = black
bool isWhiteTurn = true;

// Entry Point
void main()
{
	// Greets players.
	write("Welcome to D Chess!\n");

	// Stores the user's input.
	string userInput;

	// Program Loop
	do
	{
		// Resets board and sets the player's turn to be white at the start of the new game.
		resetBoard();
		isWhiteTurn = true;

		do
		{
			// Write the current state of the board at the start of the turn.
			writeBoard();

			// Writes whose turn it is.
			if (isWhiteTurn)
			{
				write("White's Turn\n");
			}
			else
			{
				write("Black's Turn\n");
			}

			int[2] pieceCoordinate;

			// Gets and stores the coordinate of the selected piece.
			do
			{
				do
				{
					write("Input notation of selected piece: ");
					userInput = strip(readln());
				}
				while (!isValidNotation(userInput));

				pieceCoordinate = notationToCoordinate(userInput);
			}
			while (!isValidPiece(pieceCoordinate, isWhiteTurn));

			// Displays selected piece
			write("Selected piece: ", returnSquare(pieceCoordinate),'\n');

			// Swaps player's turn once the current turn is done.
			isWhiteTurn = !isWhiteTurn;
		}
		while (true);

		// To exit the program.
		write("Input E to exit program.\n");
		userInput = strip(readln());
	}
	while (userInput != "E");
}
