import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  final String pDescription;
  final String pid;
  final String pName;
  final String mrp;
  final String wholesalePrice;
  final String pUrl;
  final String minQuantity;
  final bool available;

  const Products({
    required this.pDescription,
    required this.pid,
    required this.pName,
    required this.mrp,
    required this.wholesalePrice,
    required this.pUrl,
    required this.minQuantity,
    required this.available,
  });

  Map<String, dynamic> toJson() => {
    'p_desc' : pDescription,
    'pid' : pid,
    'p_name' : pName,
    'mrp' : mrp,
    'wholesale_price' : wholesalePrice,
    'photo_url' : pUrl,
    'min_quantity' : minQuantity,
    'available' : available,
  };

  static Products fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return Products(
      pName: snapshot['username'],
      pid: snapshot['uid'],
      pDescription: snapshot['description'],
      pUrl: snapshot['postUrl'],
      mrp: snapshot['postId'],
      minQuantity: snapshot['profImage'],
      wholesalePrice: snapshot['datePublished'],
      available: snapshot['likes'],
    );
  }
}