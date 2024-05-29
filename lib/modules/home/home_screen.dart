
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import 'package:poultry/helper/alert_manager.dart';

import 'package:poultry/model/poultry_stats_summary.dart';
import 'package:poultry/modules/home/add_data_form.dart';
import 'package:poultry/modules/home/home_view_model.dart';
import 'package:poultry/path_collection.dart';
import 'package:provider/provider.dart';
import 'package:poultry/helper/app_localizations.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:toast/toast.dart';

const String apiKey = 'FiyA7RMWrjFrdiwQUdI6d2mzHvzZD16mCw791uNuW0sHWdrJPZcvc0Zr';

// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<dynamic> photos = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchPhotos('nature'); // Initial fetch with a default query
//   }
//
//   Future<void> fetchPhotos(String query) async {
//     final String url = 'https://api.pexels.com/v1/search?query=$query&per_page=15';
//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {'Authorization': apiKey},
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         setState(() {
//           photos = data['photos'];
//         });
//       } else {
//         throw Exception('Failed to load photos');
//       }
//     } catch (e) {
//       print('Error fetching photos: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pexels API Demo'),
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 8.0,
//           mainAxisSpacing: 8.0,
//         ),
//         itemCount: photos.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PhotoDetailPage(photo: photos[index]),
//                 ),
//               );
//             },
//             child: CachedNetworkImage(
//               imageUrl: photos[index]['src']['tiny'],
//               placeholder: (context, url) => Center(child: CircularProgressIndicator()),
//               errorWidget: (context, url, error) => Icon(Icons.error),
//               fit: BoxFit.cover,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class PhotoDetailPage extends StatelessWidget {
//   final dynamic photo;
//
//   const PhotoDetailPage({Key? key, required this.photo}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Photo Detail'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.wallpaper),
//             onPressed: () async {
//               await setWallpaper(context, photo['src']['original']);
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.favorite),
//             onPressed: () {
//               likePhoto(photo['id']);
//               // Toast.show('Photo liked!', context: context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: CachedNetworkImage(
//           imageUrl: photo['src']['large2x'],
//           placeholder: (context, url) => Center(child: CircularProgressIndicator()),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
//
//   Future<void> setWallpaper(BuildContext context, String imageUrl) async {
//     try {
//       int location = WallpaperManager.HOME_SCREEN; // or WallpaperManager.LOCK_SCREEN
//       // final String result = await FlutterWallpaperManager.setWallpaperFromUrl(imageUrl, location);
//       Toast.show('Wallpaper set successfully');
//       // print('Wallpaper set: $result');
//     } catch (e) {
//       Toast.show('Failed to set wallpaper');
//       print('Error setting wallpaper: $e');
//     }
//   }
//
//   void likePhoto(int photoId) {
//     // Implement your logic to like the photo via API
//     // Example: Make an HTTP POST request to like the photo
//     // Replace this with actual API call to like photo
//     print('Liked photo with ID: $photoId');
//   }
// }


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> photos = [];

  @override
  void initState() {
    super.initState();
    fetchPhotos('nature'); // Initial fetch with a default query
  }

  Future<void> fetchPhotos(String query) async {
    final String url = 'https://api.pexels.com/v1/search?query=$query&per_page=15';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': apiKey},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          photos = data['photos'];
        });
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      print('Error fetching photos: $e');
    }
  }

  Future<void> searchPhotos(String query) async {
    if (query.isEmpty) return;
    try {
      final String url = 'https://api.pexels.com/v1/search?query=$query&per_page=15';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': apiKey},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          photos = data['photos'];
        });
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      print('Error searching photos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoDetailPage(photo: photos[index]),
                ),
              );
            },
            child: CachedNetworkImage(
              imageUrl: photos[index]['src']['tiny'],
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String searchQuery = '';
        return AlertDialog(
          title: Text('Search Photos'),
          content: TextField(
            onChanged: (value) {
              searchQuery = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter search query',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Search'),
              onPressed: () {
                Navigator.pop(context);
                searchPhotos(searchQuery);
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class PhotoDetailPage extends StatelessWidget {
  final dynamic photo;

  const PhotoDetailPage({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.wallpaper),
            onPressed: () async {
              await setWallpaper(context, photo['src']['original']);
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              likePhoto(photo['id']);
              // Toast.show('Photo liked!');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Photo liked!'),
                  duration: Duration(seconds: 2), // Adjust the duration as needed
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: photo['src']['large2x'],
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Future<void> setWallpaper(BuildContext context, String imageUrl) async {
    try {
      int location = WallpaperManager.HOME_SCREEN; // or WallpaperManager.LOCK_SCREEN
      // final String result = await FlutterWallpaperManager.setWallpaperFromUrl(imageUrl, location);
      // Toast.show('Wallpaper set successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Wallpaper set successfully!'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
      // print('Wallpaper set: $result');
    } catch (e) {
      // Toast.show('Failed to set wallpaper');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to set wallpaper!'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
      print('Error setting wallpaper: $e');
    }
  }

  void likePhoto(int photoId) {
    // Implement your logic to like the photo via API
    // Example: Make an HTTP POST request to like the photo
    // Replace this with actual API call to like photo
    print('Liked photo with ID: $photoId');
  }
}
