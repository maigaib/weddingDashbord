import 'dart:async';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weddingadministration/modeles/prestataire.dart';
import 'package:weddingadministration/modeles/types.dart';
import 'package:weddingadministration/responsive/pages/prestataire_add.dart';
import 'package:weddingadministration/responsive/pages/prestataire_mod.dart';
import 'package:weddingadministration/services/prestataireServices.dart';
import 'package:weddingadministration/util/titre_add_bouton.dart';
import '../constants.dart';
import '../util/my_box.dart';

class DesktopScaffold extends StatefulWidget {
  //final listContent;
  const DesktopScaffold({Key? key,}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  StreamController<List<Prestataire>> _listePrestatairesController = StreamController<List<Prestataire>>.broadcast();
   TextEditingController nomController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController telephoneController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

  // Liste des catégories à récupérer depuis Firestore
  List<String> categories = [];
   // Catégorie sélectionnée
  String selectedCategory = 'Bijoux';
  TypesService typesService = TypesService();
  PrestataireService prestataireService = PrestataireService();
  DateTime today = DateTime.now(); 
 void _onDaySelected(DateTime day, DateTime focusedDay){
  setState(() {
    today = day;
  });
 }
 @override
  void initState() {
    super.initState();
    _getTypesList();
    _chargerListePrestataires();
  }
  void _getTypesList() async {
    try {
      List<Type> typesList = await typesService.getTypesList();
      //print(typesList.map((type) => type.nom).toList());
      setState(() {
        // Mettez à jour la liste des catégories avec les types récupérés
        categories = typesList.map((type) => type.nom).toList();
      });
    } catch (e) {
      print('Erreur lors de la récupération des types: $e');
    }
  }
  Future<void> _chargerListePrestataires() async {
    // Chargez votre liste de prestataires à partir de votre service PrestataireService
    PrestataireService prestataireService = PrestataireService();
    List<Prestataire> prestataires = await prestataireService.getlistePrestataires();

    // Émettez la liste dans le StreamController
    _listePrestatairesController.add(prestataires);
  }

  @override
  void dispose() {
    _listePrestatairesController.close();
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
                           child: MyButton(   titre: 'P R E S T A T A I R E S',
                                       icon: Icons.add,
                                       text: 'Ajouter',
                                       onPressed: () {
                                         showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                        title: Text('Ajouter un prestataire'),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              // Champs de texte
                                              TextField(
                                                controller: nomController,
                                                
                                                decoration: InputDecoration(
                                                  labelText: 'Nom',
                                                ),
                                              ),
                                              TextField(
                                                controller: emailController,
                                                decoration: InputDecoration(
                                                  labelText: 'Email',
                                                ),
                                              ),
                                              TextField(
                                                controller: telephoneController,
                                                decoration: InputDecoration(
                                                  labelText: 'Telephone',
                                                ),
                                              ),
                                              TextField(
                                                controller: descriptionController,
                                                decoration: InputDecoration(
                                                  labelText: 'Description',
                                                ),
                                              ),
                                              //selecteur ici 
                                            
                                              // Champ de sélection
                                              Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Container(
                                                //width: 250,
                                                child: DropdownButton<String>(
                                                  value: selectedCategory,
                                                  menuMaxHeight: 200,
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      selectedCategory = newValue!;
                                                    });
                                                  },
                                                  items: categories.map<DropdownMenuItem<String>>((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  hint: Text('Sélectionner une catégorie'),
                                                ),
                                              ),
                                            ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          // Bouton d'annulation
                                          TextButton(
                                            child: Text('Annuler'),
                                            onPressed: () {
                                              // Ferme le modal
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          // Bouton de validation
                                          TextButton(
                                            child: Text('Valider'),
                                            onPressed: () async {
                                              final nom = nomController.text;
                                              final email = emailController.text;
                                              final description = descriptionController.text;
                                              final telephone = telephoneController.text;

                                            final prestataire = Prestataire(
                                                    prestataireId:'',
                                                    nom: nom ,
                                                    email:email ,
                                                    description: description ,
                                                    tel: telephone ,
                                                    note:0,
                                                    typesId: selectedCategory,
                                                  );
                                                  prestataire.create(); 
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(content: Text("Envoi en cours ..."))
                                                    );
                                                      await   _chargerListePrestataires();
                                                    FocusScope.of(context).requestFocus(FocusNode());
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );

                                       });
                                         
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
                            //SizedBox(width: 10),
                            Container(
                              width: 200,
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
                                  'Email',
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
                                  'Telephone',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(width: 30),
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

                     
                  // list of previous days
                  StreamBuilder<List<Prestataire>>(
  stream: _listePrestatairesController.stream,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }

    if (!snapshot.hasData || snapshot.data == null) {
      //print('Pas de données');
      return Text('Pas de données à afficher.');
    }

    // Utilisez les données du snapshot
    List<Prestataire> listes = snapshot.data as List<Prestataire>;

    return Expanded(
      child: ListView.builder(
        itemCount: listes.length,
        itemBuilder: (context, index) {
          Prestataire prestataire = listes[index];
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
                    const SizedBox(width: 20),
                    // ID widget
                    Container(
                      width:30,
                      child: Text(
                        lineNumber.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Name widget
                    Container(
                      width: 200,
                      child: Text(
                        prestataire.nom,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Email widget
                    Container(
                      width: 160,
                      child: Text(
                        prestataire.email,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      width: 140,
                      child: Text(
                        prestataire.tel,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Actions widget (e.g., buttons)
                    Container(
                      width: 170,
                      child: Row(
                        children: [
                          // Edit button
                          IconButton(
                            onPressed: () {
                              showDialog(
                                            context: context,
                                            builder: (context) => ModifierPrestataire(prestataire : prestataire),
                                          );
                            },
                            icon: const Icon(Icons.edit, color: Colors.blue,),
                          ),
                          const SizedBox(width: 10),
                          // Delete button
                          IconButton(
                            onPressed: () {
                      
                              showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmation'),
                                content: Text('Voulez-vous vraiment supprimer cet élément ?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Ferme la boîte de dialogue
                                    },
                                    child: Text('Non'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await prestataireService.delete(prestataire.prestataireId??'');
                                      await     _chargerListePrestataires(); // Mise à jour de la liste
                                      Navigator.of(context).pop(); // Ferme la boîte de dialogue après la suppression
                                    },
                                    child: Text('Oui', 
                                        style: TextStyle(
                          color: Colors.red,
                        ),
                                        ),
                                  ),
                                ],
                              );
                                      },
                                    );
                            },
                            icon: const Icon(Icons.delete, color: Colors.red,),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.info_outline, color: Colors.purple,),
                          ),
                        ],
                      ),
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
