//import 'dart:io';

//import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:weddingadministration/modeles/prestataire.dart';
import 'package:weddingadministration/modeles/types.dart';
import 'package:weddingadministration/services/prestataireServices.dart';

class AjouterPrestataire extends StatefulWidget {
  const AjouterPrestataire({super.key});

  @override
  State<AjouterPrestataire> createState() => _AjouterPrestataireState();
}

class _AjouterPrestataireState extends State<AjouterPrestataire> {
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
  //ImagePicker picker = ImagePicker();
  //File? _image;
   @override
  void initState() {
    super.initState();
    //la méthode pour récupérer la liste des types au moment de l'initialisation du widget
    _getTypesList();
     _chargerListePrestataires();

  }

  // Méthode pour récupérer la liste des types depuis Firestore
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


// Champ d'image avec label
// Text('Sélectionner une image', textAlign: TextAlign.left,),
//             // Champ d'image
//             SizedBox(
//               height: 100,
//               child: GestureDetector(
//                 onTap: () {
//                   // Ouvre l'explorateur de fichiers
//                   _pickImage();
//                 },
//                 child: _image != null
//                   ? kIsWeb
//                       ? Image.network(_image!.path)
//                       : Image.file(_image!)
//                   : Container(
//                       width: double.infinity,
//                       height: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                       ),
//                       child: Icon(Icons.add_a_photo),
//                     ),
//               ),)
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
  }
//   void _pickImage() async {
//   // Ouvre l'explorateur de fichiers
//   ImagePicker picker = ImagePicker();
//   XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
//   PickedFile? pickedImage = xFile != null ? PickedFile(xFile.path) : null;
//   // Si une image a été sélectionnée
//   if (pickedImage != null) {
//     // Stocke l'image dans la variable `_image`
//     setState(() {
//       _image = File(pickedImage.path);
//     });
//   }
// }

}