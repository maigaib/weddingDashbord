import 'dart:async';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weddingadministration/constants.dart';
import 'package:weddingadministration/modeles/client.dart';
import 'package:weddingadministration/services/clientService.dart';
import 'package:weddingadministration/util/my_box.dart';

import 'package:weddingadministration/util/titre_add_bouton.dart';


class ClientScaffold extends StatefulWidget {
  //final listContent;
  const ClientScaffold({Key? key,}) : super(key: key);

  @override
  State<ClientScaffold> createState() => _ClientScaffoldState();
}

class _ClientScaffoldState extends State<ClientScaffold> {
  StreamController<List<Client>> _listeClientsController = StreamController<List<Client>>.broadcast();
  DateTime today = DateTime.now(); 
 void _onDaySelected(DateTime day, DateTime focusedDay){
  setState(() {
    today = day;
  });
 }
 @override
  void initState() {
    super.initState();
    // À ce stade, vous pouvez initialiser votre liste de prestataires
    // par exemple, en appelant une méthode qui récupère les données de votre service
    _chargerListeClients();
  }

  Future<void> _chargerListeClients() async {
    // Chargez votre liste de prestataires à partir de votre service PrestataireService
    ClientService clientService = ClientService();
    List<Client> clients = await clientService.getlisteClients();

    // Émettez la liste dans le StreamController
    _listeClientsController.add(clients);
  }

  @override
  void dispose() {
    _listeClientsController.close();
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
            // open drawer
            myDrawer(context) ,

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
                                titre:Text('Produits',
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
                     Column(
                       children: [
                           SizedBox(height: 10),
                         Padding(
                           padding: EdgeInsets.all(10.0),
                           child: MyButton(   titre: 'C L I E N T S',
                                       icon: Icons.add,
                                       text: 'Ajouter',
                                       onPressed: () {
                                         // Fonction à exécuter lorsque le bouton est pressé
                                         print('Button Pressed!');
                                       },
                                     ),
                         ),
                           SizedBox(height: 10),

                         Container(
                           decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,  // Couleur de la bordure
                                  width: 1.0,           // Largeur de la bordure
                                ),
                              ),
                            ),
                           child: const Row(
                                           children: [
                                             SizedBox(width: 50),
                                             // ID widget
                                             Text(
                                               'N°',
                                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                             ),
                                             SizedBox(width: 60),
                                             // Name widget
                                             Text(
                                               'Nom',
                                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                             ),
                                             SizedBox(width: 100),
                                             // Email widget
                                             Text(
                                               'Email',
                                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                             ),
                                             SizedBox(width: 130),
                                             // Téléphone widget
                                             Text(
                                               'Téléphone',
                                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                             ),
                                             SizedBox(width: 100),
                                             // Actions widget (e.g., buttons)
                                             Row(
                                               children: [
                                                 SizedBox(width: 50),
                                                 Text(
                                                   'Actions',
                                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                 ),
                                               ],
                                             ),
                                           ],),
                         )
                       ],
                     ),

                     
                  // list of previous days
                  StreamBuilder<List<Client>>(
  stream: _listeClientsController.stream,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }

    if (!snapshot.hasData || snapshot.data == null) {
      //print('Pas de données');
      return Text('Pas de données à afficher.');
    }

    // Utilisez les données du snapshot
    List<Client> listes = snapshot.data as List<Client>;

    return Expanded(
      child: ListView.builder(
        itemCount: listes.length,
        itemBuilder: (context, index) {
          Client client = listes[index];
            int lineNumber = index + 1;
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: Center(
                child: Row(
                  children: [
                    const SizedBox(width: 50),
                    // ID widget
                    Text(
                      lineNumber.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 60),

                    // Name widget
                    Text(
                      client.nom ,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 80),

                    // Email widget
                    Text(
                      client.email,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 80),
                    Text(
                      client.telephone,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 80),

                    // Actions widget (e.g., buttons)
                    Row(
                      children: [
                        // Edit button
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit, color: Colors.blue,),
                        ),
                        const SizedBox(width: 20),
                        // Delete button
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete, color: Colors.red,),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.info_outline, color: Colors.purple,),
                        ),
                      ],
                    ),
                  ],
                ),
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
                      child: Card(
                          elevation: 4,
                          color: Colors.white, // L'élévation de la carte
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Les coins arrondis de la carte
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              //color: Colors.,
                            ),
                            child: Image.asset("assets/images/LogoV.png"),
                          ),
                        )

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
