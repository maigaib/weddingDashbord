import 'package:flutter/material.dart';
import 'package:weddingadministration/constants.dart';
import 'package:weddingadministration/util/my_box.dart';
import 'package:weddingadministration/util/my_tile.dart';


class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      drawer: myDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // first 4 boxes in grid
            AspectRatio(
              aspectRatio: 1,
              child: SizedBox(
                width: double.infinity,
                child: GridView.builder(
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return  const MyBox( 
                                titre:Text('Prestation',
                                style: TextStyle(fontSize: 12),) ,
                                nombre: Text('0023',
                                style: TextStyle(fontSize: 18),),
                               cercle: MyContainerWidget(icon: Icons.room_service, cercleWidth: 30, cercleIconSize: 15,) ,);
                            case 1:
                              return const MyBox(
                                 titre:Text('Clients',
                                style: TextStyle(fontSize: 12),) ,
                                nombre: Text('0023',
                                style: TextStyle(fontSize: 18),),
                                cercle: MyContainerWidget(icon: Icons.room_service, cercleWidth: 30, cercleIconSize: 15,) ,);
                            case 2:
                              return const MyBox(
                                 titre:Text('Prestation',
                                style: TextStyle(fontSize: 12),) ,
                                nombre: Text('0023',
                                style: TextStyle(fontSize: 18),),
                               cercle: MyContainerWidget(icon: Icons.room_service, cercleWidth: 30, cercleIconSize: 15,) ,);
                            default:
                              return const MyBox(
                                 titre:Text('Prestation',
                                style: TextStyle(fontSize: 12),) ,
                                nombre: Text('0023',
                                style: TextStyle(fontSize: 18),),
                                cercle: MyContainerWidget(icon: Icons.room_service, cercleWidth: 30, cercleIconSize: 15,) ,);
                          }
                          }
                ),
              ),
            ),

            // list of previous days
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const MyTile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
