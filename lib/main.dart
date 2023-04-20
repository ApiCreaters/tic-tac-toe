import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // primaryColor: Colors.black
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var grid =[' ',' ',' ',' ',' ',' ',' ',' ',' ']; //<== -
  var currentplayer = 'X';
  var winner = "";

  void drawxo(i) {
    if (grid[i] == ' ') {                   //<== -
      setState(() {
        grid[i] = currentplayer;
        currentplayer = currentplayer == 'X' ? '0' : 'X';
        findWinner(grid[i]);
      });
    }
  }
  bool checkMove(i1,i2,i3,sign){
      if(grid[i1] == sign && grid[i2] == sign && grid[i3] == sign){
        return true;
      }
      return false;
  }
  void findWinner(currentsign){
    if(checkMove(0,1,2,currentsign)  || checkMove(3,4,5,currentsign) || checkMove(6,7,8,currentsign) ||
        checkMove(0,3,6,currentsign) || checkMove(1,4,7,currentsign) || checkMove(2,5,8,currentsign) ||
        checkMove(0,4,8,currentsign) || checkMove(2,4,6,currentsign) )
    {
      // print("$currentsign Won");
      winner = currentsign;
      setState(() {

      });
    }
  }

  void reset(){
    setState(() {
      winner = "";
      grid =[' ',' ',' ',' ',' ',' ',' ',' ',' '];        //<== -
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff36454f),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            if(winner != "") Text('$winner won the game', style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),

            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight:600,
                  maxWidth: 600,
                  minHeight: 200,
                  minWidth: 200
                ),
                padding: EdgeInsets.all(20),
                color: Color(0xff36454f),
                child: GridView.builder( shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
                ), itemBuilder: (context,index) => Material(
                  color: Color(0xff323441),
                  child: InkWell(
                    splashColor: Color(0xff301934),
                    onTap: () => drawxo(index),
                      child: Center(child: Text(grid[index],style: TextStyle(fontSize: 50),))),
                ),
                itemCount: grid.length,
                ),
              ),
            ),

            ElevatedButton.icon(onPressed: reset, icon: Icon(Icons.refresh), label: Text("Play again"))
          ],
        ),
      )
    );
  }
}
