//import 'dart:io';

//import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:weddingadministration/modeles/prestataire.dart';
import 'package:weddingadministration/modeles/types.dart';
import 'package:weddingadministration/services/prestataireServices.dart';

class ModifierPrestataire extends StatefulWidget {
  //final PrestataireService prestataireService;
  final Prestataire prestataire;
  const ModifierPrestataire({super.key, required this.prestataire, 
  //required this.prestataireService
  });

  @override
  State<ModifierPrestataire> createState() => _ModifierPrestataireState();
}

class _ModifierPrestataireState extends State<ModifierPrestataire> {
 StreamController<List<Prestataire>> _listePrestatairesController = StreamController<List<Prestataire>>.broadcast();
  TextEditingController nomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  PrestataireService prestataireService = PrestataireService();

  // Liste des catégories à récupérer depuis Firestore
  List<String> categories = [];
   // Catégorie sélectionnée
  TypesService typesService = TypesService();
  //ImagePicker picker = ImagePicker();
  //File? _image;
   @override
  void initState() {
    super.initState();
    //la méthode pour récupérer la liste des types au moment de l'initialisation du widget
    _getTypesList();
    fetchPrestatairesList();
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

  Future<void> fetchPrestatairesList() async {
  try {
    // Utilisation de Firestore pour récupérer les tâches
    QuerySnapshot<Map<String, dynamic>> listePrestataireSnapshot = await FirebaseFirestore.instance.collection('prestataires').get();

    // Convertir les documents Firestore en une liste de tâches
    List<Prestataire> prestataires = listePrestataireSnapshot.docs.map((doc) {
      return Prestataire.fromMap(
        doc.data() as Map<String, dynamic>, doc.reference
      );
    }).toList();

    // Émettre les données à travers le StreamController
    _listePrestatairesController.add(prestataires);
  } catch (e) {
    print('Erreur lors de la récupération des tâches: $e');
    _listePrestatairesController.addError(e); // Émettre une erreur si la récupération échoue
  }
}

  @override
  Widget build(BuildContext context) {

    nomController.text = widget.prestataire.nom;
    emailController.text = widget.prestataire.email;
    telephoneController.text = widget.prestataire.tel;
    descriptionController.text = widget.prestataire.description;
        String selectedCategory = widget.prestataire.typesId ?? '';

    return AlertDialog(
      title: Text('Modifier un prestataire'),
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
            
               widget.prestataire.nom = nomController.text;
               widget.prestataire.email = emailController.text;
               widget.prestataire.tel = telephoneController.text;
               widget.prestataire.description = descriptionController.text;
               widget.prestataire.typesId = selectedCategory;
               prestataireService.update(widget.prestataire); 
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Envoi en cours ..."))
                  );
                   fetchPrestatairesList();
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