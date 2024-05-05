import 'package:poultry/path_collection.dart';

class FilterButton extends StatelessWidget {
  String? image;
  final VoidCallback onTap;

   FilterButton({Key? key, this.image , required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ClipOval(
        child: Container(
          // decoration: BoxDecoration(
          //   shape: BoxShape.circle,
          //   border: Border.all(
          //     color: lightGrey, // Assuming lightGrey is defined
          //     width: 1.0,
          //   ),
          // ),
          child: GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, top: 8),
              child: Image.asset(
                image ?? 'assets/filter.png',
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}