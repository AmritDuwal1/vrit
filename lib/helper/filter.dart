// import 'package:flutter/material.dart';
//
// class FilterDialog extends StatelessWidget {
//   final void Function(RangeValues)? onApplyFilters;
//
//   const FilterDialog({Key? key, required this.onApplyFilters}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     RangeValues _selectedPriceRange = const RangeValues(0, 15000);
//
//     return AlertDialog(
//       backgroundColor: Colors.white,
//       title: const Text('Filter Place'),
//       content: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('Price Range'),
//             PriceRangeSlider(
//               onChanged: (values) {
//                 _selectedPriceRange = values;
//               },
//             ),
//             // Text('Room Capacity'),
//             // BedroomsDropdown(),
//             // Text('Facility'),
//             // FacilityChips(),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () {
//             if (onApplyFilters != null) {
//               onApplyFilters!(_selectedPriceRange);
//             }
//             Navigator.pop(context);
//           },
//           child: const Text('Apply'),
//         ),
//       ],
//     );
//   }
// }
//
// // Add the onChanged parameter to PriceRangeSlider
// class PriceRangeSlider extends StatefulWidget {
//   final void Function(RangeValues) onChanged; // Add this line
//
//   const PriceRangeSlider({Key? key, required this.onChanged}) : super(key: key);
//
//   @override
//   _PriceRangeSliderState createState() => _PriceRangeSliderState();
// }
//
//
// class _PriceRangeSliderState extends State<PriceRangeSlider> {
//   RangeValues _currentRangeValues = const RangeValues(0, 15000);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('\Nrs. ${_currentRangeValues.start.round()}'),
//               Expanded(
//                 child: RangeSlider(
//                   values: _currentRangeValues,
//                   onChanged: (values) {
//                     setState(() {
//                       _currentRangeValues = values;
//                       // Call the onChanged callback with the updated values
//                       widget.onChanged(values); // Add this line
//                     });
//                   },
//                   min: 0, // Set the min value to 0
//                   max: 15000,
//                   divisions: 100,
//                   labels: RangeLabels(
//                     _currentRangeValues.start.round().toString(),
//                     _currentRangeValues.end.round().toString(),
//                   ),
//                 ),
//               ),
//               Text('\Nrs. ${_currentRangeValues.end.round()}'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
//
// class BedroomsDropdown extends StatefulWidget {
//   const BedroomsDropdown({super.key});
//   @override
//   _BedroomsDropdownState createState() => _BedroomsDropdownState();
// }
//
// class _BedroomsDropdownState extends State<BedroomsDropdown> {
//   String selectedBedrooms = 'Any'; // Initial selection
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: selectedBedrooms,
//       onChanged: (String? newValue) {
//         setState(() {
//           selectedBedrooms = newValue!;
//         });
//       },
//       items: <String>['Any', '1', '2', '3', '4+']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
//
//
// class FacilityChips extends StatefulWidget {
//   const FacilityChips({super.key});
//
//   @override
//   _FacilityChipsState createState() => _FacilityChipsState();
// }
//
// class _FacilityChipsState extends State<FacilityChips> {
//   List<String> selectedFacilities = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 8.0,
//       children: [
//         for (String facility in ['Free Wifi', 'Kitchen', 'Pool', 'Garden', 'Parking'])
//           FilterChip(
//             label: Text(facility),
//             selected: selectedFacilities.contains(facility),
//             onSelected: (bool selected) {
//               setState(() {
//                 if (selected) {
//                   selectedFacilities.add(facility);
//                 } else {
//                   selectedFacilities.remove(facility);
//                 }
//               });
//             },
//           ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';

class FilterDialog extends StatelessWidget {
  final void Function(RangeValues)? onApplyFilters;

  const FilterDialog({Key? key, required this.onApplyFilters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RangeValues _selectedPriceRange = const RangeValues(0, 15000);

    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Filter Place'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Price Range'),
            PriceRangeEntry(
              onValuesChanged: (values) {
                _selectedPriceRange = values;
              },
            ),
            // Text('Room Capacity'),
            // BedroomsDropdown(),
            // Text('Facility'),
            // FacilityChips(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (onApplyFilters != null) {
              onApplyFilters!(_selectedPriceRange);
            }
            Navigator.pop(context);
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}

class PriceRangeEntry extends StatefulWidget {
  final void Function(RangeValues) onValuesChanged;

  const PriceRangeEntry({Key? key, required this.onValuesChanged}) : super(key: key);

  @override
  _PriceRangeEntryState createState() => _PriceRangeEntryState();
}

class _PriceRangeEntryState extends State<PriceRangeEntry> {
  TextEditingController _minPriceController = TextEditingController();
  TextEditingController _maxPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _minPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Min Price',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) {
                    _updateValues();
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _maxPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Max Price',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) {
                    _updateValues();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _updateValues() {
    double minPrice = double.tryParse(_minPriceController.text) ?? 0;
    double maxPrice = double.tryParse(_maxPriceController.text) ?? 15000;
    widget.onValuesChanged(RangeValues(minPrice, maxPrice));
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }
}
