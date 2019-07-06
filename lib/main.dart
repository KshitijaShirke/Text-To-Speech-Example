import 'package:flutter/material.dart';
import 'package:text_to_speech_example/model/places.dart';
import 'package:text_to_speech_example/detailpage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new ListPage(title: 'Places'),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List places;

  @override
  void initState() {
    places = getPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Places places) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      child: Icon(Icons.place, color: Colors.white),
    ),
      title: Text(
        places.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        places.description,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(places:places)));
      },
    );

    Card makeCard(Places places) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.cyan),
        child: makeListTile(places),
      ),
    );

    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: places.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(places[index]);
        },
      ),
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Colors.deepOrangeAccent,
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: topAppBar,
      body: makeBody,
    );
  }
}

List getPlaces() {
  return [
    Places(title: "Marine drive, Mumbai", description: "Marine Drive is a km long, arc shaped boulevard along the South Mumbai coast, starting from the southern end of Nariman Point and ending at the famous Chowpatty beach. The coast lines the Arabian sea and is the best place to watch the sunset in Mumbai, or even to just take a leisurely stroll by the sea any time of the day or night."),
    Places(title: "Gateway Of India", description: "The Gateway of India is, without doubt, one of the most popular tourist hotspots of Mumbai. It is located at Apollo Bunder Waterfront and overlooks the Arabian Sea in the most beautiful way. One of the most distinguished monuments in Mumbai, it was built in the year 1924 by famous architect George Wittet as a commemoration of the visit of King George V and Queen Mary to Mumbai. The imposing structure of the monument is a beautiful confluence of Indian, Arabic and Western architecture and has become a popular tourist hub in the city."),
    Places(title: "Colaba Causeway", description: "One of the most crowded and electrifying places to visit in Mumbai is the Colaba Causeway, famous for being the shopping paradise and having endless shops to choose from. The city of a million hopes, dreams and aspirations, Mumbai has its heart in the right place despite all the floods and terrors and everything that has shaken it over the years. Winning over everything else, the Mumbai-spirit has remained undefeatable. And at the heart of the unabashed city is the bustling Colaba Causeway - an absolute must-visit."),
    Places(title: "Juhu Beach", description: "Juhu beach is the longest beach in Mumbai, and arguably the most popular among tourists as well. Juhu beach is renowned for its wide variety of street food with a very typical Mumbai flavour.  The nearby area of Juhu is a posh locality in Mumbai, home to a lot of famous Bollywood and TV celebrities - the most famous being Amitabh Bachhan's bungalow - and it is not very rare to spot a celebrity jogging on the beach. "),
    Places(title: "Siddhivinayak Temple", description: "The Siddhivinayak Temple is a revered shrine dedicated to Lord Ganesha and is one of the most significant and frequented temples in Prabhadevi of Mumbai, Maharashtra. This temple was built in the year 1801 by Laxman Vithu and Deubai Patil. The couple did not have any children of their own and decided to build the Siddhivinayak temple so as to fulfil the wishes of other infertile women."),
    Places(title: "Haji Ali Dargah", description: "Situated at the backdrop of a beautiful view of the sea is the shrine of Haji Ali, a wealthy merchant turned into Muslim Sufi. The Haji Ali Dargah (mausoleum) was raised in 1431 in reminiscence of an affluent Muslim trader, Sayyed Peer Haji Ali Shah Bukhari, who gave up all his worldly belongings before making a trip to Mecca. People from all walks of life and religions come here to seek blessings."),
    Places(title: "Elephanta caves", description: "A UNESCO World Heritage Site, Elephanta Caves is a specimen of rock-cut art and architecture from the times of medieval India. The caves are located on the Elephanta island which is situated at a distance of 11 km from the city of Mumbai. Natively known as Gharapurichi Leni, the Elephanta Caves that exist today are ruins of what were once elaborately painted artworks. It also provides an amazing view of the Mumbai skyline.")
  ];
}
