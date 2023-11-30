import 'package:flutter/material.dart';
import 'package:weddingadministration/constants.dart';

import '../util/my_box.dart';
import '../util/my_tile.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
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
              aspectRatio: 4,
              child: SizedBox(
                width: double.infinity,
                child: GridView.builder(
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                   itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return  const MyBox( 
                                titre:Text('Prestation',
                                style: TextStyle(fontSize: 14),) ,
                                nombre: Text('0023',
                                style: TextStyle(fontSize: 20),),
                               cercle: MyContainerWidget(icon: Icons.room_service, cercleWidth: 40, cercleIconSize: 20,) ,);
                            case 1:
                              return const MyBox(
                                 titre:Text('Clients',
                                style: TextStyle(fontSize: 14),) ,
                                nombre: Text('0023',
                                style: TextStyle(fontSize: 20),),
                                cercle: MyContainerWidget(icon: Icons.room_service, cercleWidth: 40, cercleIconSize: 20,) ,);
                            case 2:
                              return const MyBox(
                                 titre:Text('Prestation',
                                style: TextStyle(fontSize: 14),) ,
                                nombre: Text('0023',
                                style: TextStyle(fontSize: 20),),
                               cercle: MyContainerWidget(icon: Icons.room_service, cercleWidth: 40, cercleIconSize: 20,) ,);
                            default:
                              return const MyBox(
                                 titre:Text('Prestation',
                                style: TextStyle(fontSize: 14),) ,
                                nombre: Text('0023',
                                style: TextStyle(fontSize: 20),),
                                cercle: MyContainerWidget(icon: Icons.room_service, cercleWidth: 40, cercleIconSize: 20,) ,);
                          }
                          }
                ),
              ),
            ),

            // list of previous days
            Expanded(
              child: ListView.builder(
                itemCount: 6,
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
