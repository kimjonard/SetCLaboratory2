import 'package:flutter/material.dart';

void main() {
  runApp(TravelApp());
}

// ---------------------------------------------------------------------------
// ROOT APP
// ---------------------------------------------------------------------------
class TravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boracay Travel Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange, fontFamily: 'Roboto'),
      home: DestinationPage(),
    );
  }
}

// ---------------------------------------------------------------------------
// DATA MODEL FOR TOURIST SPOTS
// A simple class like the ones we made in Module 7 (Kuliglig, Employee).
// ---------------------------------------------------------------------------
class TouristSpot {
  String imageUrl;
  String name;
  String description;
  String entranceFee;
  String openingHours;
  Color color;

  TouristSpot(
    this.imageUrl,
    this.name,
    this.description,
    this.entranceFee,
    this.openingHours,
    this.color,
  );
}

// ---------------------------------------------------------------------------
// HOME PAGE
// ---------------------------------------------------------------------------
class DestinationPage extends StatefulWidget {
  @override
  _DestinationPageState createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  bool isFavorite = false;

  // Real attractions in Boracay and mainland Aklan
  List<TouristSpot> spots = [
    TouristSpot(
      'https://static.vecteezy.com/system/resources/previews/071/057/687/large_2x/nature-background-nature-wallpaper-tropical-white-sand-beach-with-palm-trees-loungers-and-turquoise-ocean-under-a-clear-blue-sky-free-photo.jpg',
      'White Beach',
      'A world-famous 4-kilometer stretch of powdery white sand along Boracay\'s west coast, divided into Stations 1 to 3.',
      '₱200.00',
      'Open 24 hours',
      Colors.orangeAccent,
    ),
    TouristSpot(
      'https://th.bing.com/th/id/R.13f9e2a071be5f47cf23563e380c555b?rik=5i%2fb%2fgl%2by%2b4BlA&riu=http%3a%2f%2fjusthalfaworldaway.com%2fwp-content%2fuploads%2f2017%2f04%2fIMG_2306.jpg&ehk=VOpq9tVk208yOkwoUwrVRute56mbPa%2fYu4nLoV70%2b80%3d&risl=&pid=ImgRaw&r=0',
      'Puka Shell Beach',
      'A quieter beach on the northern tip of the island, named after the puka shells that used to wash ashore here.',
      'Free',
      'Open 24 hours',
      Colors.cyan,
    ),
    TouristSpot(
      'https://cdn.forevervacation.com/uploads/attraction/mount-luho-4936.jpg',
      'Mount Luho',
      'Boracay\'s highest point, offering a 360-degree viewing deck overlooking the whole island and surrounding sea.',
      '₱150.00',
      '7:00 AM - 6:00 PM',
      Colors.green,
    ),
    TouristSpot(
      'https://res.cloudinary.com/thetripguru/image/upload/fl_lossy.progressive,e_improve/q_auto:low,c_scale,f_auto,dpr_auto,w_2158/o8isptogypew2l99x5ua',
      "Willy's Rock",
      'An iconic volcanic rock formation off Station 1 with a small shrine of the Virgin Mary, one of Boracay\'s most photographed landmarks.',
      'Free',
      'Open 24 hours',
      Colors.pinkAccent,
    ),
    TouristSpot(
      'https://farm4.staticflickr.com/3902/14499790876_db4f619eb5_z.jpg',
      'Jawili Falls',
      'A seven-level waterfall with natural swimming pools located in Nabas, Aklan on the mainland near Boracay.',
      '₱20.00',
      '8:00 AM - 5:00 PM',
      Colors.teal,
    ),
  ];

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? 'Destination added to favorites!'
              : 'Destination removed from favorites.',
        ),
        backgroundColor: Colors.deepOrange,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void showExploreInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Boracay is a small island in Aklan province, Western Visayas, '
          'famous for its powdery white sand beaches and vibrant nightlife. '
          'It is consistently rated among the best islands in the world.',
        ),
        backgroundColor: Colors.indigo,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build the list of spot cards first, using a simple for loop.
    List<Widget> spotCards = [];
    for (var spot in spots) {
      spotCards.add(buildSpotCard(spot));
    }

    return Scaffold(
      backgroundColor: Color(0xFFF3FAFB),
      appBar: AppBar(
        title: Text('Boracay Travel Guide'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 20),
        children: [
          buildDestinationHeader(),
          buildActionButtons(),
          buildSectionTitle('Tourist Attractions', Colors.deepOrange),
          Column(children: spotCards),
          buildSectionTitle('Travel Information', Colors.teal),
          buildInfoRow(
            Icons.directions_walk,
            'Recommended Activities',
            'Island hopping, parasailing, cliff diving at Ariel\'s Point, and sunset sailing on a paraw boat.',
            Colors.purple,
          ),
          buildInfoRow(
            Icons.backpack,
            'Things to Bring',
            'Sunscreen, dry bag, swimwear, sunglasses, and a reusable water bottle.',
            Colors.blue,
          ),
          buildInfoRow(
            Icons.restaurant,
            'Local Food Recommendations',
            'Try chicken inasal, fresh seafood, mango shakes, and calamansi muffins from D\'Talipapa.',
            Colors.deepOrange,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // DESTINATION INFORMATION
  // ---------------------------------------------------------------------
  Widget buildDestinationHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFB2EBF2), Color(0xFFFFE0B2)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://a.cdn-hotels.com/gdcs/production67/d1485/a24503e6-6f87-40bc-9d1d-88cfe7eace6a.jpg',
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Boracay Island',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.redAccent, size: 18),
                    Text(
                      ' Malay, Aklan, Philippines',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
                Text(
                  'Boracay is a small tropical island in Aklan famous for '
                  'its powdery white sand beaches, turquoise waters, and '
                  'lively beachfront scene.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                Row(
                  children: [
                    Icon(Icons.wb_sunny, color: Colors.orange, size: 18),
                    Text(
                      ' Best Time to Visit: November to May',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
                Text(
                  '"Life is better in Boracay."',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // INTERACTIVE BUTTONS
  // ---------------------------------------------------------------------
  Widget buildActionButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: toggleFavorite,
            style: ElevatedButton.styleFrom(
              backgroundColor: isFavorite ? Colors.pink : Colors.deepOrange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                Text(isFavorite ? '  Favorited' : '  Favorite'),
              ],
            ),
          ),
          TextButton(
            onPressed: showExploreInfo,
            style: TextButton.styleFrom(foregroundColor: Colors.indigo),
            child: Row(children: [Icon(Icons.explore), Text('  Explore More')]),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // TOURIST SPOTS
  // ---------------------------------------------------------------------
  Widget buildSpotCard(TouristSpot spot) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: spot.color, width: 2),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: spot.color.withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            spot.imageUrl,
            width: double.infinity,
            height: 140,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.place, color: spot.color, size: 18),
                    Text(
                      ' ${spot.name}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: spot.color,
                      ),
                    ),
                  ],
                ),
                Text(spot.description, style: TextStyle(fontSize: 12)),
                Text(
                  'Fee: ${spot.entranceFee}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Hours: ${spot.openingHours}',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // TRAVEL INFORMATION
  // ---------------------------------------------------------------------
  Widget buildInfoRow(
    IconData icon,
    String title,
    String content,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: color,
            ),
          ),
          Text(content, style: TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title, Color color) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
