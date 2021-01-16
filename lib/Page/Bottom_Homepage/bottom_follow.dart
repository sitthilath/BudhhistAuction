
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomFollow extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomFollowState();
  }

}

class _BottomFollowState extends State<BottomFollow> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       centerTitle: true,
       title: Text(
         'ຕິດຕາມ',
         style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
       ),
       elevation: 0.0,
       backgroundColor: Colors.transparent,
     ),
     body: ListView(

       children: <Widget>[
         Divider(),
         Container(
           margin: EdgeInsets.fromLTRB(10,20,10,20),
           child: Row(children: [
             Text('2 ລາຍການ'),
             Spacer(),
             Icon(Icons.apps),
           ],),
         ),
         Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey), bottom:BorderSide(color: Colors.grey) ),
              ),

            height: MediaQuery.of(context).size.width * 0.285,

             child:Row(children: [

               Expanded(
                 flex:1,
                 child: Image.asset(
                   "asset/gif/loading.gif",
                   fit: BoxFit.fill,
                 ),
               ),

               Expanded(
                 flex:2,
                 child: Container(
                   margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

                       Row(children: [
                         Text('ອັດຕະປື',style: TextStyle(fontSize: 11),),
                         Spacer(),
                         Text('3 ມື້',style: TextStyle(fontSize: 11),),
                       ],),
                       Text('ພະສົມເດັດມະຫາເສດຖີ ລຸ້ນ 9',style: TextStyle(fontSize: 16),),
                       SizedBox(height: 3,),
                       Text('2,000,000 KIP',style: TextStyle(fontSize: 12),),
                       SizedBox(height: 1,),
                       Text('ເຈົ້າກຳລັງນຳ',style: TextStyle(fontSize: 12),),
                     ],),
                 ),
               ),
             ],)
         ),
         Container(
             decoration: BoxDecoration(
               border: Border(top: BorderSide(color: Colors.grey), bottom:BorderSide(color: Colors.grey) ),
             ),
             height: MediaQuery.of(context).size.width * 0.285,

             child:Row(children: [
               Expanded(
                 flex:1,
                 child: Image.asset(
                   "asset/gif/loading.gif",
                   fit: BoxFit.fill,
                 ),
               ),

               Expanded(
                 flex:2,
                 child: Container(
                   margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

                       Row(children: [
                         Text('ອັດຕະປື',style: TextStyle(fontSize: 11),),
                         Spacer(),
                         Text('3 ມື້',style: TextStyle(fontSize: 11),),
                       ],),
                       Text('ພະສົມເດັດມະຫາເສດຖີ ລຸ້ນ 9',style: TextStyle(fontSize: 16),),
                       SizedBox(height: 3,),
                       Text('2,000,000 KIP',style: TextStyle(fontSize: 12),),
                       SizedBox(height: 1,),
                       Text('ເຈົ້າກຳລັງນຳ',style: TextStyle(fontSize: 12),),
                     ],),
                 ),
               ),
             ],)
         ),

       ],

     ),
   );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}