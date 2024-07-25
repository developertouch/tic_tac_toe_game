import 'package:flutter/material.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  // border state to keep track of the moves
  final List<String> board = List.filled(9, "");

  // variable to store the winner
  String winner = "";

  // flag to indicate tie
  bool isTie = false;

  // function to handle player's moves
  player(int index) {
    if (winner != '' || board[index] != "") {
      return; //if the game is already won or the cell is not empty do nothing
    }
    setState(() {
      board[index] =
          currentPlayer; //set the current cell to current player symbol
      currentPlayer =
          currentPlayer == "x" ? "0" : "x"; //switch to one to another player
      checkForWinner();
    });
  }

  // Function for check for winner or toe
  checkForWinner() {
    List<List<int>> lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    //   check each winner combination
    for (List<int> line in lines) {
      String player1 = board[line[0]];
      String player2 = board[line[1]];
      String player3 = board[line[2]];
      if (player1 == "" || player2 == "" || player3 == "") {
        continue; //if any cell in  combination is empty skip this combination
      }
      ;
      if (player1 == player2 && player2 == player3) {
        winner =
            player1; //if all cell in the combination are same set the winner
        return;
      }
      //   check for tie
      if(!board.contains("")) {
        setState(() {
          isTie =
              true; //if no cell is empty and there is no winner then it's tie
        });
      }
    }
  }

  // function for to reset the game state and start new game
  resetGame() {
    setState(() {
      board.fillRange(0, 9, ''); //clear the board
      currentPlayer = "x";
      winner = ''; // clear the winner
      isTie = false; //clear the tie flag
    });
  }

  // current play x or 0
  String currentPlayer = "x";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: currentPlayer == "x"
                        ? Colors.amber
                        : Colors.transparent,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 3,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 55,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "player 1",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "x",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.08,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: currentPlayer == "0"
                        ? Colors.amber
                        : Colors.transparent,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 3,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 55,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "player 2",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "0",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          // display the winner
          if (winner!= "")
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  winner,
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "WON!",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          // display tie message
          if(isTie)
            Text(
              "It's a tie!",
              style: TextStyle(
                  fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),
            ),

          // for game board
          Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: 9,
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    player(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black38),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          //   reset button
          if (winner!=""||isTie)
            ElevatedButton(
                onPressed: () {
                  resetGame();
                },
                child: Text("Play Again"))
        ],
      ),
    );
  }
}
