import 'package:flutter/material.dart';
import 'login.dart';

class DashboardPage extends StatefulWidget {
  final String username;

  DashboardPage({required this.username});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  final List<Map<String, String>> categories = [
    {'name': 'LUKE CHIANG', 'image': 'assets/luke.jpg'},
    {'name': 'LANY', 'image': 'assets/lany.jpg'},
    {'name': 'KESHI', 'image': 'assets/keshi.jpg'},
    {'name': 'DEPT', 'image': 'assets/dept.jpg'},
    {'name': 'LAUV', 'image': 'assets/lauv.jpg'},
  ];

  final List<Map<String, String>> songs = [
    {'title': 'LIMBO', 'artist': 'Keshi', 'image': 'assets/keshi.jpg'},
    {'title': 'UNDERSTAND', 'artist': 'Keshi', 'image': 'assets/keshi.jpg'},
    {
      'title': 'Used To Me',
      'artist': 'Luke Chiang',
      'image': 'assets/luke.jpg'
    },
    {
      'title': 'Shouldn’t Be',
      'artist': 'Luke Chiang',
      'image': 'assets/luke.jpg'
    },
    {'title': 'I Like Me Better', 'artist': 'Lauv', 'image': 'assets/lauv.jpg'},
    {'title': 'Mean It', 'artist': 'Lauv', 'image': 'assets/lauv.jpg'},
    {'title': 'DNA', 'artist': 'LANY', 'image': 'assets/lany.jpg'},
    {'title': 'ILYSB', 'artist': 'LANY', 'image': 'assets/lany.jpg'},
    {
      'title': 'Whenever it rains',
      'artist': 'Dept',
      'image': 'assets/dept.jpg'
    },
    {'title': 'Winter blossom', 'artist': 'Dept', 'image': 'assets/dept.jpg'},
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spotivi'),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? Colors.blueAccent : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _currentIndex == 1 ? Colors.blueAccent : Colors.grey,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 2 ? Colors.blueAccent : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed, // Agar semua item tetap tampil
        selectedItemColor: Colors.blueAccent, // Warna item yang dipilih
        unselectedItemColor: Colors.grey, // Warna item yang tidak dipilih
        backgroundColor: Colors.white, // Warna latar belakang bottom nav
        elevation: 8, // Menambahkan bayangan di bawah navbar
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _homePage();
      case 1:
        return _searchPage();
      case 2:
        return _profilePage();
      default:
        return _homePage();
    }
  }

  Widget _homePage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, ${widget.username}!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(categories[index]
                        ['image']!), // Menggunakan DecorationImage
                    fit: BoxFit
                        .cover, // Mengatur gambar agar menutupi seluruh kontainer
                  ),
                ),
                child: Center(
                  child: Text(
                    categories[index]['name']!, // Menampilkan nama kategori
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _searchPage() {
    List<Map<String, String>> filteredSongs = songs
        .where((song) =>
            song['title']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            song['artist']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search for songs, artists',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (query) {
              setState(() {
                searchQuery = query;
              });
            },
          ),
          SizedBox(height: 16),
          Expanded(
            child: filteredSongs.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredSongs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(
                          filteredSongs[index]['image']!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(filteredSongs[index]['title']!),
                        subtitle: Text(filteredSongs[index]['artist']!),
                      );
                    },
                  )
                : Center(child: Text('No results found')),
          ),
        ],
      ),
    );
  }

  Widget _profilePage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/capy.jpg'), // Replace with profile image
            ),
            SizedBox(height: 16),
            Text(
              'Hello, ${widget.username}!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Welcome to your profile!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'Log Out',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
