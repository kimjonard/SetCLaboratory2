import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Nido Travel Guide',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 15),
        ),
      ),
      home: DestinationPage(),
    );
  }
}

class TouristSpot {
  String name;
  String imageUrl;
  String description;
  String entranceFee;
  String openingHours;

  TouristSpot(
    this.name,
    this.imageUrl,
    this.description,
    this.entranceFee,
    this.openingHours,
  );
}

class DestinationPage extends StatefulWidget {
  @override
  _DestinationPageState createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  bool isFavorite = false;

  // List of tourist spots. We are using our TouristSpot class here.
  List<TouristSpot> touristSpots = [
    TouristSpot(
      'Big Lagoon',
      'https://images.unsplash.com/photo-1552465011-b4e21bf6e79a',
      'A lagoon surrounded by tall limestone cliffs.',
      'P200',
      '7:00 AM - 5:00 PM',
    ),
    TouristSpot(
      'Small Lagoon',
      'https://images.unsplash.com/photo-1544644181-1484b3fdfc62',
      'A narrow entrance that opens to calm turquoise water.',
      'P200',
      '7:00 AM - 5:00 PM',
    ),
    TouristSpot(
      'Secret Lagoon',
      'https://images.unsplash.com/photo-1518509562904-e7ef99cddff9',
      'A hidden lagoon you enter through a small rock opening.',
      'P200',
      '7:00 AM - 4:00 PM',
    ),
    TouristSpot(
      'Nacpan Beach',
      'https://images.unsplash.com/photo-1519046904884-53103b34b206',
      'A long stretch of golden sand, best during sunset.',
      'Free',
      'Open 24 hours',
    ),
    TouristSpot(
      'Snake Island',
      'https://images.unsplash.com/photo-1573843981267-be1999ff37cd',
      'A sandbar shaped like a snake connecting two small islands.',
      'P200',
      '7:00 AM - 5:00 PM',
    ),
  ];

  List<String> activities = [
    'Island hopping tour',
    'Snorkeling',
    'Cliff diving',
    'Kayaking',
  ];

  List<String> thingsToBring = [
    'Sunscreen',
    'Waterproof bag',
    'Extra clothes',
    'Reef-safe sunblock',
  ];

  List<String> localFood = [
    'Grilled fresh seafood',
    'Kinilaw (Filipino ceviche)',
    'Fresh buko juice',
  ];

  void showFavoriteMessage() {
    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? 'Destination added to favorites!'
              : 'Removed from favorites.',
        ),
      ),
    );
  }

  void showExploreDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('More About El Nido'),
          content: Text(
            'El Nido is a town in Palawan, Philippines known for its '
            'limestone cliffs, hidden lagoons, and island hopping tours.',
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildSpotCard(TouristSpot spot) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(spot.imageUrl),
          radius: 28,
        ),
        title: Text(spot.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(spot.description),
            SizedBox(height: 4),
            Text('Entrance Fee: ${spot.entranceFee}'),
            Text('Opening Hours: ${spot.openingHours}'),
          ],
        ),
      ),
    );
  }

  Widget buildInfoList(String title, List<String> items) {
    List<Widget> textItems = [];
    for (var item in items) {
      textItems.add(Text('•  ' + item));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: textItems,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Building the list of spot cards using our helper method above.
    List<Widget> spotCards = [];
    for (var spot in touristSpots) {
      spotCards.add(buildSpotCard(spot));
    }

    return Scaffold(
      appBar: AppBar(title: Text('El Nido, Palawan')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destination hero image
            Image.network(
              'https://images.unsplash.com/photo-1573843981267-be1999ff37cd',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            // Destination info section
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'El Nido',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.teal),
                      SizedBox(width: 4),
                      Text('Palawan, Philippines'),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'El Nido is a coastal town famous for its limestone '
                    'cliffs, hidden lagoons, and island hopping tours.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 12),
                  Text('Best Time to Visit: November to May'),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.teal[50],
                    child: Text(
                      '"Paradise doesn\'t need a passport - just El Nido."',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),

            Divider(),

            // Interactive buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: showFavoriteMessage,
                    child: Text(isFavorite ? 'Favorited' : 'Favorite'),
                  ),
                  TextButton(
                    onPressed: showExploreDialog,
                    child: Text('Explore'),
                  ),
                ],
              ),
            ),

            Divider(),

            // Tourist spots section
            Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                'Tourist Spots',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Column(children: spotCards),

            Divider(),

            // Travel info section
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoList('Recommended Activities', activities),
                  SizedBox(height: 12),
                  buildInfoList('Things to Bring', thingsToBring),
                  SizedBox(height: 12),
                  buildInfoList('Local Food Recommendations', localFood),
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
