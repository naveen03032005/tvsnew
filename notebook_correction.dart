import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class notebook_correction extends StatelessWidget {
  const notebook_correction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'NoteBook Correction',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.indigo.shade900,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const WorksheetForm(),
      ),
    );
  }
}

class WorksheetForm extends StatefulWidget {
  const WorksheetForm({Key? key}) : super(key: key);

  @override
  _WorksheetFormState createState() => _WorksheetFormState();
}

class _WorksheetFormState extends State<WorksheetForm> {
  // Correctly initialize the GlobalKey<FormState>
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextEditingControllers for capturing input
  final TextEditingController monthController = TextEditingController();
  final TextEditingController feedbackController=TextEditingController();

  // Dropdown values
  String? selectedStd;
  String? selectedShift;

  // Get current date, time, and day
  String getCurrentDate() => DateFormat('dd-MM-yyyy').format(DateTime.now());
  String getCurrentTime() => DateFormat('hh:mm a').format(DateTime.now());
  String getCurrentDay() => DateFormat('EEEE').format(DateTime.now());

  // Function to show Date Picker for Month selection
  Future<void> _selectMonth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        monthController.text = DateFormat('dd MMMM yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey, // Correctly assigning the key to the Form
        child: ListView(
          children: [
            // Row to display Date, Time, and Day at the top
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoBox('Date', getCurrentDate()),
                _buildInfoBox('Time', getCurrentTime()),
                _buildInfoBox('Day', getCurrentDay()),
              ],
            ),
            const SizedBox(height: 20),

            // Input fields start here
            GestureDetector(
              onTap: () => _selectMonth(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: monthController,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Date', // Set the label text as "Date"
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, // Bold label text
                      color: Colors.black87, // Set label color to black87
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always, // Keep label visible
                        hintText: 'Select Date', 
                        hintStyle: const TextStyle(
                          color: Colors.black54, 
                          ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87,
                          width: 2.0), // Set border color and width
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87,
                          width: 2.0), // Set focused border color and width
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87,
                          width: 2.0), // Set enabled border color and width
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the date';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: 'AS Name', // Set the label text as "Feedback"
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, // Bold label text
                  color: Colors.black87, // Set label color to black87
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always, // Keep label visible
                hintStyle: const TextStyle(
                  color: Colors.black54,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set border color and width
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set focused border color and width
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set enabled border color and width
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide the AS Name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedStd,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                labelText: 'Std',
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, // Make the label text bold
                  color: Colors.black, // Change label color to black
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set border color and width
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set focused border color and width
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set enabled border color and width
                ),
              ),
              hint: const Text('Select Std'),
              items: [
                'LKG',
                'UKG',
                'I',
                'II',
                'III',
                'IV',
                'V',
                'VI',
                'VII',
                'VIII',
                'IX',
                'X',
                'XI',
                'XII'
              ].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedStd = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select the class';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: 'Section', // Set the label text as "Feedback"
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, // Bold label text
                  color: Colors.black87, // Set label color to black87
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always, // Keep label visible
                hintStyle: const TextStyle(
                  color: Colors.black54,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set border color and width
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set focused border color and width
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set enabled border color and width
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide Section';
                }
                return null;
              },
            ),
            const SizedBox(height: 10), // Add some spacing between fields
            TextFormField(
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: 'Subject', // Set the label text as "Feedback"
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, // Bold label text
                  color: Colors.black87, // Set label color to black87
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always, // Keep label visible
                hintStyle: const TextStyle(
                  color: Colors.black54,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set border color and width
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set focused border color and width
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set enabled border color and width
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide Subject';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: 'Home Work Status (%)', // Set the label text as "Feedback"
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, // Bold label text
                  color: Colors.black87, // Set label color to black87
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always, // Keep label visible
                hintStyle: const TextStyle(
                  color: Colors.black54,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set border color and width
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set focused border color and width
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set enabled border color and width
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide %';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: 'Observation Mode', // Set the label text as "Feedback"
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, // Bold label text
                  color: Colors.black87, // Set label color to black87
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always, // Keep label visible
                hintStyle: const TextStyle(
                  color: Colors.black54,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set border color and width
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set focused border color and width
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0), // Set enabled border color and width
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide Online or Offline';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form saved as draft')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade900,
              ),
              child: const Text('Save as Draft',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Form Submitted')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade900,
              ),
              child:
                  const Text('Submit', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build an info box for Date, Time, and Day
  Widget _buildInfoBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}