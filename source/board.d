// Standard Import(s)
import std.stdio : write;
import std.ascii : isUpper;

// Stores current state of the chessboard.
// uppercase character = white piece | lowercase character = black piece
private char[8][8] board;

// Puts the pieces back to their starting positions on the chessboard.
void resetBoard()
{
	board = [
		['r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'],
		['p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'],
		[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		['P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'],
		['R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R']
	];
}

// Writes the current state of the chessboard.
void writeBoard()
{
	foreach (row; board)
	{
		foreach (column; row)
		{
			write('[', column, ']');
		}

		write('\n');
	}
}

// Checks if the coordinate points to a piece and
// if the piece's color matches the player's color and
// if it can be moved.
bool isValidPiece(int[2] coordinate, bool isWhiteTurn)
{
	char square = board[coordinate[0]][coordinate[1]];

	if (square != ' ')
	{
		if (isUpper(square) == isWhiteTurn)
		{
			// Reminder: Put move logic.
			if (true)
			{
				return true;
			}
		}
	}

	return false;
}

// Returns the character that displays the wanted square.
char returnSquare(int[2] coordinate)
{
	return board[coordinate[0]][coordinate[1]];
}
