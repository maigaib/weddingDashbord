import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weddingadministration/constants.dart';
import 'package:weddingadministration/modeles/mariage.dart';
import 'package:weddingadministration/services/mariageService.dart';
import 'package:weddingadministration/util/my_box.dart';
import 'package:weddingadministration/util/titre_add_bouton.dart';


class MariageScaffold extends StatefulWidget {
  const MariageScaffold({Key? key}) : super(key: key);

  @override
  State<MariageScaffold> createState() => _MariageScaffoldState();
}

class _MariageScaffoldState extends State<MariageScaffold> {
  StreamController<List<Mariage>> _listeMariagesController =
      StreamController<List<Mariage>>.broadcast();
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  void initState() {
    super.initState();
    _chargerListeMariages();
  }

  Future<void> _chargerListeMariages() async {
    MariageService mariageService = MariageService();
    List<Mariage> mariages = await mariageService.getlisteMariages();
    _listeMariagesController.add(mariages);
  }

  @override
  void dispose() {
    _listeMariagesController.close();
    super.dispose();
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
            myDrawer(context),

            Expanded(
              flex: 2,
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 6,
                    child: SizedBox(
                      width: double.infinity,
                      child: GridView.builder(
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return const MyBox(
                                titre: Text(
                                  'Produits',
                                  style: TextStyle(fontSize: 16),
                                ),
                                nombre: Text(
                                  '0023',
                                  style: TextStyle(fontSize: 24),
                                ),
                                cercle: MyContainerWidget(
                                  icon: Icons.room_service,
                                  cercleWidth: 50,
                                  cercleIconSize: 30,
                                ),
                              );
                            case 1:
                              return const MyBox(
                                titre: Text(
                                  'Clients',
                                  style: TextStyle(fontSize: 16),
                                ),
                                nombre: Text(
                                  '0023',
                                  style: TextStyle(fontSize: 24),
                                ),
                                cercle: MyContainerWidget(
                                  icon: Icons.supervisor_account,
                                  cercleWidth: 50,
                                  cercleIconSize: 30,
                                ),
                              );
                            case 2:
                              return const MyBox(
                                titre: Text(
                                  'Prestataires',
                                  style: TextStyle(fontSize: 16),
                                ),
                                nombre: Text(
                                  '0023',
                                  style: TextStyle(fontSize: 24),
                                ),
                                cercle: MyContainerWidget(
                                  icon: Icons.handshake,
                                  cercleWidth: 50,
                                  cercleIconSize: 30,
                                ),
                              );
                            default:
                              return const MyBox(
                                titre: Text(
                                  'Mariages',
                                  style: TextStyle(fontSize: 16),
                                ),
                                nombre: Text(
                                  '0023',
                                  style: TextStyle(fontSize: 24),
                                ),
                                cercle: MyContainerWidget(
                                  icon: Icons.favorite_rounded,
                                  cercleWidth: 50,
                                  cercleIconSize: 30,
                                ),
                              );
                          }
                        },
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left:50.0, top: 10.0, right: 10.0, bottom: 10.0),
                        child: MyButton(
                          titre: 'M A R I A G E S',
                          icon: Icons.add,
                          text: 'Ajouter',
                          onPressed: () {
                            print('Button Pressed!');
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 20),
                            Container(
                              width: 30,
                              child: const Center(
                                child: Text(
                                  'N°',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 250,
                              child: const Center(
                                child: Text(
                                  'Nom',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            //const SizedBox(width: 100),
                            Container(
                              width: 160,
                              child: const Center(
                                child: Text(
                                  'Lieu',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            //SizedBox(width: 130),
                            Container(
                              width: 160,
                              child: const Center(
                                child: Text(
                                  'Date',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 140,
                              child: const Row(
                                children: [
                                  SizedBox(width: 50),
                                  Center(
                                    child: Text(
                                      'Actions',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  StreamBuilder<List<Mariage>>(
                    stream: _listeMariagesController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return Text('Pas de données à afficher.');
                      }

                      List<Mariage> listes = snapshot.data as List<Mariage>;

                      return Expanded(
                        child: ListView.builder(
                          itemCount: listes.length,
                          itemBuilder: (context, index) {
                            Mariage mariage = listes[index];
                            int lineNumber = index + 1;
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[200],
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Container(
                                      width: 30,
                                      child: Text(
                                        lineNumber.toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 250,
                                      child: Center(
                                        child: Text(
                                          '${mariage.monsieur} & ${mariage.madame}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 160,
                                      child: Center(
                                        child: Text(
                                          mariage.lieu,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 160,
                                      child: Center(
                                        child: Text(
                                          DateFormat('dd MMMM yyyy')
                                              .format(mariage.date),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 140,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.blue,
                                            ),
                                          ),
                                    const SizedBox(width: 10),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                    const SizedBox(width: 10),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.info_outline,
                                              color: Colors.purple,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
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
                      child: TableCalendar(
                        locale: "fr_Fr",
                        rowHeight: 43,
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                        selectedDayPredicate: (day) => isSameDay(day, today),
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: today,
                        availableGestures: AvailableGestures.all,
                        onDaySelected: _onDaySelected,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset("assets/images/LogoV.png"),
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
