import 'package:poultry/helper/constants.dart';
import 'package:poultry/path_collection.dart';


class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool fullWidth;
  final bool secondaryButton;
  final String secondaryButtonText;
  final bool showTick; // Added showTick property

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fullWidth = false,
    this.secondaryButton = false,
    this.secondaryButtonText = "",
    this.showTick = false, // Initialized showTick to false

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: !secondaryButton
              ? MaterialStateProperty.all<Color>(blueColor)
              : MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: !secondaryButton
              ? MaterialStateProperty.all<Color>(Colors.white)
              : MaterialStateProperty.all<Color>(darkGrey),
          side: secondaryButton
              ? MaterialStateProperty.all<BorderSide>(
              const BorderSide(width: 0.0, color: lightGrey))
              : null,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            if (showTick) // Display the tick icon if showTick is true
              Icon(Icons.check, color: Colors.green), // Tick icon
          ],
        ),
      ),
    );
  }
}
