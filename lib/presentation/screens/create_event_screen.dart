import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _title;
  String? _description;
  String? _category;
  bool _isPublic = true;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _location;

  final List<String> _categories = [
    'Book Club',
    'Workshop',
    'Study Group',
    'Hobby Meetup',
    'Other',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null || _selectedTime == null || _location == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select date, time, and location')),
        );
        return;
      }

      _formKey.currentState!.save();

      final eventDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Event Created: $_title ($_category) on ${DateFormat.yMMMd().add_jm().format(eventDateTime)} at $_location',
          ),
        ),
      );

      // TODO: Integrate with backend
    }
  }

  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _pickTime() async {
    final TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) setState(() => _selectedTime = time);
  }

  void _pickLocation() async {
  TextEditingController controller = TextEditingController();
  final result = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Enter Event Location'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'City, Venue, or Address',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: const Text('Select'),
        ),
      ],
    ),
  );

  if (result != null && result.isNotEmpty) {
    setState(() => _location = result);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Location selected: $_location')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Event"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Event Title
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Event Title',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter a title' : null,
                onSaved: (val) => _title = val,
              ),
              const SizedBox(height: 10),

              // Description
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter description' : null,
                onSaved: (val) => _description = val,
              ),
              const SizedBox(height: 10),

              // Category Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map((cat) =>
                        DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (val) => setState(() => _category = val),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Select category' : null,
              ),
              const SizedBox(height: 10),

              // Date Picker
              ListTile(
                title: Text(_selectedDate == null
                    ? 'Pick Event Date'
                    : 'Date: ${DateFormat.yMMMd().format(_selectedDate!)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),

              // Time Picker
              ListTile(
                title: Text(_selectedTime == null
                    ? 'Pick Event Time'
                    : 'Time: ${_selectedTime!.format(context)}'),
                trailing: const Icon(Icons.access_time),
                onTap: _pickTime,
              ),

              // Location Picker
              ListTile(
                title: Text(_location ?? 'Pick Event Location'),
                trailing: const Icon(Icons.location_on),
                onTap: _pickLocation,
              ),

              // Public/Private Toggle
              SwitchListTile(
                title: const Text('Public Event'),
                value: _isPublic,
                onChanged: (val) => setState(() => _isPublic = val),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
