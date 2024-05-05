// import 'package:nepal_hotels/path_collection.dart';
//
// class SearchBarApp extends StatefulWidget {
//   const SearchBarApp({super.key});
//
//   @override
//   State<SearchBarApp> createState() => _SearchBarAppState();
// }
//
// class _SearchBarAppState extends State<SearchBarApp> {
//   bool isDark = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData themeData = ThemeData(
//         useMaterial3: true,
//         brightness: isDark ? Brightness.dark : Brightness.light);
//
//     return MaterialApp(
//       theme: themeData,
//       home: Scaffold(
//         // backgroundColor: Colors.red,
//         // appBar: AppBar(title: const Text('Search Bar Sample')),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             // color: Colors.green,
//             child: SearchAnchor(
//                 builder: (BuildContext context, SearchController controller) {
//                   return SearchBar(
//                     elevation: MaterialStateProperty.all(0.0),
//                     backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
//                     shadowColor: MaterialStateProperty.all<Color>(Colors.white),
//                     controller: controller,
//                     padding: const MaterialStatePropertyAll<EdgeInsets>(
//                         EdgeInsets.symmetric(horizontal: 16.0)),
//                     onTap: () {
//                       controller.openView();
//                     },
//                     onChanged: (_) {
//                       controller.openView();
//                     },
//                     hintText: 'Search by location..',
//                     side: MaterialStateProperty.all(BorderSide(
//                       color: Colors.grey[300]!,  // Light grey color
//                       width: 2.0,
//                     )),
//                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                       side: BorderSide.none,  // Set to none to prevent duplicate borders
//                     )),
//                     leading: const Icon(Icons.search),
//                     // trailing: <Widget>[
//                     //   Tooltip(
//                     //     message: 'Change brightness mode',
//                     //     child: IconButton(
//                     //       isSelected: isDark,
//                     //       onPressed: () {
//                     //         setState(() {
//                     //           isDark = !isDark;
//                     //         });
//                     //       },
//                     //       icon: const Icon(Icons.wb_sunny_outlined),
//                     //       selectedIcon: const Icon(Icons.brightness_2_outlined),
//                     //     ),
//                     //   )
//                     // ],
//                   );
//                 }, suggestionsBuilder:
//                 (BuildContext context, SearchController controller) {
//               return List<ListTile>.generate(5, (int index) {
//                 final String item = 'item $index';
//                 return ListTile(
//                   title: Text(item),
//                   onTap: () {
//                     setState(() {
//                       controller.closeView(item);
//                     });
//                   },
//                 );
//               });
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:poultry/path_collection.dart';
import 'package:flutter/material.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({Key? key}) : super(key: key);

  @override
  _SearchBarAppState createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Expanded(
              child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    elevation: MaterialStateProperty.all(4.0),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    hintText: 'Search by location..',
                    side: MaterialStateProperty.all(BorderSide(
                      color: Colors.grey[300]!,
                      width: 2.0,
                    )),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide.none,
                    )),
                    leading: const Icon(Icons.search),
                  );
                },
                suggestionsBuilder: (BuildContext context, SearchController controller) {
                  final List<String> suggestionItems = ['item 0', 'item 1', 'item 2', 'item 3', 'item 4'];

                  return [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5, // Adjust height as needed
                      child: ListView.builder(
                        itemCount: suggestionItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String item = suggestionItems[index];
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              setState(() {
                                controller.closeView(item);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ];
                },


              ),
            ),
          ),
        ),
      ),
    );
  }
}
