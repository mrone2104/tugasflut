import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeliKomik',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Sofia',
      ),
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/order': (context) => OrderPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedAnime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blikomik'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Selamat datang di Blikomik!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 30),
              Image.asset(
                'images/animebuku.jpg',
                width: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 30),
              Text(
                'Komik yang tersedia:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildComicItem('Naruto','images/Naruto.jpg'),
              _buildComicItem('One Piece','images/onepiece.jpg'),
              _buildComicItem('Attack on Titan', 'images/aot.jpg'),
              _buildComicItem('My Hero Academia', 'images/myhero.jpg'),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: selectedAnime != null ? () => Navigator.pushNamed(context, '/order', arguments: selectedAnime) : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(selectedAnime != null ? Colors.blue : Colors.grey),
                ),
                child: Text(
                  'Pesan sekarang',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComicItem(String title, String image) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnime = title;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            selectedAnime == title ? Icon(Icons.check, color: Colors.green) : SizedBox(width: 24),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, color: selectedAnime == title ? Colors.orange : Colors.black),
                ),
                SizedBox(height: 5),
                Image.asset(
                  image,
                  width: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String animeTitle = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Anda memesan: $animeTitle',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Quantity: $_quantity',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _decrementQuantity,
                    child: Icon(Icons.remove),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _incrementQuantity,
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Add logic to place order
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Order Placed'),
                        content: Text('Thank you for placing your order!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Place Order',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile ku'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/fotosaya.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                'M.Riski Nanda',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'riskinanda2104@gmail.com',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
