import 'package:flutter/material.dart';
import '../models/planet.dart';

class DetailScreen extends StatefulWidget {
  final Planet planet;
  const DetailScreen({super.key, required this.planet});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0D17),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(tag: widget.planet.name, child: Image.network(widget.planet.image, height: 250)),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.planet.name.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red, size: 30),
                        onPressed: () => setState(() => isFavorite = !isFavorite),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(widget.planet.description, style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5)),
                  const SizedBox(height: 30),
                  _infoTile("YERÇEKİMİ", widget.planet.gravity),
                  _infoTile("ORTALAMA SICAKLIK", widget.planet.temperature),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white38, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}