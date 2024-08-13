import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/Data/wallheaven.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallpaper_app/screens/settings.dart';

class Favorites {
  static Future<bool> addToFavorites(
      Wallpapers wallpaper, bool isFavorite) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;

    if (user == null) {
      _showSignInSnackbar();
      return isFavorite;
    }
    try {
      await firestore.collection("Favorites").doc(user.uid).set(
        {
          "wallpapers":
              FieldValue.arrayUnion([await Wallpapers.toJson(wallpaper)]),
        },
        SetOptions(
          merge: true,
        ),
      );
      Fluttertoast.showToast(msg: "Added to favorites.");
      return !isFavorite;
    } catch (e) {
      Fluttertoast.showToast(msg: "Favorites not added.");
      print("Error adding to favorites: $e");
      return isFavorite;
    }
  }

  static Future<bool> removeFromFavorites(
      Wallpapers wallpaper, bool isFavorite) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;

    if (user == null) {
      _showSignInSnackbar();
      return isFavorite;
    }
    try {
      await firestore.collection("Favorites").doc(user.uid).update({
        "wallpapers":
            FieldValue.arrayRemove([await Wallpapers.toJson(wallpaper)]),
      });
      Fluttertoast.showToast(msg: "Removed from favorites.");
      return !isFavorite;
    } catch (e) {
      Fluttertoast.showToast(msg: "Favorites not removed.");
      print("Error removing from favorites: $e");
      return isFavorite;
    }
  }

  static void _showSignInSnackbar() {
    Get.snackbar(
      "Sign In Required",
      "Please sign in to manage your favorites.",
      snackPosition: SnackPosition.TOP,
      mainButton: TextButton(
        onPressed: () {
          Get.to(() => const SettingsScreen());
        },
        child: const Text("Sign In"),
      ),
    );
  }
}
