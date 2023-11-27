import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants.dart';
import '../util/my_box.dart';
import '../util/my_tile.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  DateTime today = DateTime.now(); 
 void _onDaySelected(DateTime day, DateTime focusedDay){
  setState(() {
    today = day;
  });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // open drawer
            myDrawer,

            // first half of page
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // first 4 boxes in grid
                  AspectRatio(
                    aspectRatio: 6,
                    child: SizedBox(
                      //height: 20,
                      width: double.infinity,
                      child: GridView.builder(
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return  const MyBox( 
                                titre:Text('Prestation',
                                style: TextStyle(fontSize: 16),) ,
                                nombre: Text('0023',
                                style: TextStyle(fontSize: 24),),
                               cercle: MyContainerWidget(icon: Icons.room_service, cercleWidth: 50, cercleIconSize: 30,) ,);
                            case 1:
                              return const MyBox(
                                 titre:Text('Clients',
                                style: TextStyle(fontSize: 16),) ,
                                nombre: Text('0023',
                                style: TextStyle(fontSize: 24),),
                                cercle: MyContainerWidget(icon: Icons.supervisor_account, cercleWidth: 50, cercleIconSize: 30,) ,);
                            case 2:
                              return const MyBox(
                                 titre:Text('Prestataires',
                                style: TextStyle(fontSize: 16),) ,
                                nombre: Text('0023',
                                style: TextStyle(fontSize: 24),),
                               cercle: MyContainerWidget(icon: Icons.handshake, cercleWidth: 50, cercleIconSize: 30,) ,);
                            default:
                              return const MyBox(
                                 titre:Text('Mariages',
                                style: TextStyle(fontSize: 16),) ,
                                nombre: Text('0023',
                                style: TextStyle(fontSize: 24),),
                                cercle: MyContainerWidget(icon: Icons.favorite_rounded, cercleWidth: 50, cercleIconSize: 30,) ,);
                          }
                          }
                      ),
                    ),
                  ),

                  // list of previous days
                  Expanded(
                    child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return const MyTile();
                      },
                    ),
                  ),
                ],
              ),
            ),
            // second half of page
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromRGBO(253, 139, 139, 1),
                      ),
                      //SizedBox(height: 10,),
                      child: TableCalendar(
                        locale: "fr_Fr",
                        rowHeight: 43,
                        headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true, ),
                        selectedDayPredicate: (day)=> isSameDay(day, today),
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: today,
                        availableGestures: AvailableGestures.all,
                        onDaySelected: _onDaySelected,
                        ) ,
                    ),
                  ),
                  // list of stuff
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red[200],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
