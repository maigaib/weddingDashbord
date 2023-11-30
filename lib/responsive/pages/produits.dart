import 'dart:async';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weddingadministration/constants.dart';
import 'package:weddingadministration/modeles/produit.dart';
import 'package:weddingadministration/services/produitService.dart';
import 'package:weddingadministration/util/my_box.dart';
import 'package:weddingadministration/util/titre_add_bouton.dart';


class ProduitsScaffold extends StatefulWidget {
  //final listContent;
  const ProduitsScaffold({Key? key,}) : super(key: key);

  @override
  State<ProduitsScaffold> createState() => _ProduitsScaffoldState();
}

class _ProduitsScaffoldState extends State<ProduitsScaffold> {
  StreamController<List<Produit>> _listeProduitsController = StreamController<List<Produit>>.broadcast();
  DateTime today = DateTime.now(); 
 void _onDaySelected(DateTime day, DateTime focusedDay){
  setState(() {
    today = day;
  });
 }
 @override
  void initState() {
    super.initState();
    // À ce stade, vous pouvez initialiser votre liste de Produits
    // par exemple, en appelant une méthode qui récupère les données de votre service
    _chargerListeProduits();
  }

  Future<void> _chargerListeProduits() async {
    // Chargez votre liste de Produits à partir de votre service ProduitService
    ProduitService produitService = ProduitService();
    List<Produit> produits = await produitService.getlisteProduits();

    // Émettez la liste dans le StreamController
    _listeProduitsController.add(produits);
  }

  @override
  void dispose() {
    _listeProduitsController.close();
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
                           child: MyButton(   titre: 'P R E S T A T I O N S',
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
                  StreamBuilder<List<Produit>>(
  stream: _listeProduitsController.stream,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }

    if (!snapshot.hasData || snapshot.data == null) {
      //print('Pas de données');
      return Text('Pas de données à afficher.');
    }

    // Utilisez les données du snapshot
    List<Produit> listes = snapshot.data as List<Produit>;

    return Expanded(
      child: ListView.builder(
        itemCount: listes.length,
        itemBuilder: (context, index) {
          Produit produit = listes[index];
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
                      produit.nom,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 80),

                    // Email widget
                    Text(
                      produit.prix as String,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 80),
                    Text(
                      '',
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
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          //color: Colors.red[20],
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
