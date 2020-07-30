import 'package:flutter/material.dart';

import 'Tile_model.dart';
import 'data.dart';
void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ("11111"),
      theme: ThemeData(
        primarySwatch:Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<TileModel>visiblePairs=new List<TileModel>();

  @override
  void initState(){
  super.initState();
  pairs= getPairs();
  pairs.shuffle();
  visiblePairs=pairs;  
  selected=true;
  Future.delayed(const Duration(seconds: 5),(){
    setState((){
      
    visiblePairs=getQuestions();
    selected=false;
    });
});
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.symmetric(vertical:30,horizontal:20),
        child:Column(
          children: <Widget>[
            Text("$points/1200",style: TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
            Text("Points"),
            SizedBox(height:20),
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                
                mainAxisSpacing:0.0,maxCrossAxisExtent:100,
              ),

              children:List.generate(pairs.length, (index){
                 return  Tile(
                   imageAssetPath:visiblePairs[index].getImageAssetPath(),
                   parent:this,
                   tileIndex: index,
                 );   
                }
            )
            )
          ],
        )
      )
      
    );
  }
}
class Tile extends StatefulWidget {
  String imageAssetPath;
  
  _HomePageState parent;
  int tileIndex;
 Tile({this.imageAssetPath,this.parent,this.tileIndex});
  @override
  
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
     if(!selected){
       if(selectedImageAssetpath!=""){
         if(selectedImageAssetpath==pairs[widget.tileIndex].getImageAssetPath()){
           print("correct");
           Future.delayed(const Duration (seconds:2),(){
              points=points+100;
              setState((){
              });
             widget.parent.setState((){
               pairs[widget.tileIndex].setImageAssetPath("");
               pairs[selectedTileIndex].setImageAssetPath("");

             });
             selectedImageAssetpath="";
           });
         }else{ print("wrong choice");
         selected:true;
          Future.delayed(const Duration (seconds:2),(){
            selected:false;
            widget.parent.setState(() { 
           pairs[widget.tileIndex].setIsSelected(false);
           pairs[selectedTileIndex].setIsSelected(false);
  });
  selectedImageAssetpath="";
          });
         }
         }else{
           selectedTileIndex=widget.tileIndex;
           selectedImageAssetpath=pairs[widget.tileIndex].getImageAssetPath();
         }
         setState(() {
           pairs[widget.tileIndex].setIsSelected(true);
         });
         print("You clicked me");
     }
     }, 
     child: Container(
       margin:EdgeInsets.all(5),
       child :pairs [widget.tileIndex].getImageAssetPath() !=""  ?
 Image.asset(pairs[widget.tileIndex].getIsSelected()?
 pairs[widget.tileIndex].getImageAssetPath():
       widget.imageAssetPath) :  Image.asset("images/14.png")
     ),
     );
    
    
       }
  }



