import 'package:flutter/material.dart';
import '../models/event.dart';

class EventService {
  /// Create an event (logic only)
  /// onSuccess/onError are optional callbacks for UI
  void createEvent(Event event, {VoidCallback? onSuccess, VoidCallback? onError}) {
    try {
      // Validate required fields
      if (event.title.isEmpty ||
          event.description.isEmpty ||
          event.category.isEmpty ||
          event.location.isEmpty) {
        throw Exception('Please fill all required fields');
      }

      // Validate event date/time
      if (event.dateTime.isBefore(DateTime.now())) {
        throw Exception('Event date/time cannot be in the past');
      }

      // TODO: Replace this with backend API call or local storage
      debugPrint(
          'Event Created: ${event.title}, Category: ${event.category}, '
          'DateTime: ${event.dateTime}, Location: ${event.location}, Public: ${event.isPublic}');

      if (onSuccess != null) onSuccess();
    } catch (e) {
      debugPrint('Error creating event: $e');
      if (onError != null) onError();
    }
  }

  /// Format event date/time nicely
  String formatEventDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// Validate event fields; returns error string or null if valid
  String? validateEvent(Event event) {
    if (event.title.isEmpty) return 'Title is required';
    if (event.description.isEmpty) return 'Description is required';
    if (event.category.isEmpty) return 'Category is required';
    if (event.location.isEmpty) return 'Location is required';
    if (event.dateTime.isBefore(DateTime.now())) return 'Event date/time cannot be in the past';
    return null; // No errors
  }
}
