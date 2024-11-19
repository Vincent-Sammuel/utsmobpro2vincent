import 'package:flutter/material.dart';
import 'login.dart';

class DashboardPage extends StatefulWidget {
  final String username;

  const DashboardPage({super.key, required this.username});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

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
        title: const Text('Spotivi'),
      ),
      body: _currentIndex == 0
          ? _homePage()
          : _profilePage(), // Menampilkan halaman berdasarkan _currentIndex
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
              Icons.person,
              color: _currentIndex == 1 ? Colors.blueAccent : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }

  Widget _homePage() {
    List<Map<String, String>> filteredSongs = songs
        .where((song) =>
            song['title']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            song['artist']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, ${widget.username}!',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search for songs, artists',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (query) {
              setState(() {
                searchQuery = query;
              });
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Songs',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          filteredSongs.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
              : const Center(child: Text('No results found')),
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
            const CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/capy.jpg'), // Ganti dengan gambar profil
            ),
            const SizedBox(height: 16),
            Text(
              'Hello, ${widget.username}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Welcome to your profile!',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
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
