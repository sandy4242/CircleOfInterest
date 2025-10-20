// lib/presentation/screens/event_details_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../models/event.dart';
import '../../constants/constants.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool _isJoined = false;
  int _attendeeCount = 23; // Mock data - in real app this would come from API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppConstants.paddingMedium,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEventHeader(),
                  AppConstants.verticalSpaceMedium,
                  _buildEventInfo(),
                  AppConstants.verticalSpaceMedium,
                  _buildDescription(),
                  AppConstants.verticalSpaceMedium,
                  _buildLocationSection(),
                  AppConstants.verticalSpaceMedium,
                  _buildAttendeeSection(),
                  AppConstants.verticalSpaceLarge,
                  _buildActionButtons(),
                  AppConstants.verticalSpaceMedium,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.event.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: Colors.black54)],
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
            ),
          ),
          child: const Icon(Icons.event, size: 80, color: Colors.white54),
        ),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.share), onPressed: _shareEvent),
        IconButton(icon: Icon(_isJoined ? Icons.bookmark : Icons.bookmark_border), onPressed: _toggleBookmark),
      ],
    );
  }

  Widget _buildEventHeader() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: AppConstants.paddingMedium,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.event.category,
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: widget.event.isPublic ? Colors.green : Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.event.isPublic ? 'Public' : 'Private',
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventInfo() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: AppConstants.paddingMedium,
        child: Column(
          children: [
            _buildInfoRow(Icons.calendar_today, 'Date', DateFormat.yMMMMEEEEd().format(widget.event.dateTime)),
            const Divider(),
            _buildInfoRow(Icons.access_time, 'Time', TimeOfDay.fromDateTime(widget.event.dateTime).format(context)),
            const Divider(),
            _buildInfoRow(
              Icons.location_on,
              'Location',
              widget.event.location.isEmpty ? 'Location TBD' : widget.event.location,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: AppConstants.paddingMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About This Event',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
            AppConstants.verticalSpaceSmall,
            Text(widget.event.description, style: const TextStyle(fontSize: 14, height: 1.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    if (widget.event.location.isEmpty) return const SizedBox.shrink();

    return Card(
      elevation: 2,
      child: Padding(
        padding: AppConstants.paddingMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
            AppConstants.verticalSpaceSmall,
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primary),
                const SizedBox(width: 8),
                Expanded(child: Text(widget.event.location, style: const TextStyle(fontSize: 14))),
              ],
            ),
            AppConstants.verticalSpaceSmall,
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _openMap,
                icon: const Icon(Icons.map),
                label: const Text('View on Map'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendeeSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: AppConstants.paddingMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Attendees',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$_attendeeCount going',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
            AppConstants.verticalSpaceSmall,
            // Mock attendee avatars
            Row(
              children: List.generate(
                5,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.primary.withOpacity(0.7),
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: _toggleJoinEvent,
            icon: Icon(_isJoined ? Icons.check_circle : Icons.person_add),
            label: Text(_isJoined ? 'Joined' : 'Join Event'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _isJoined ? Colors.green : AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        AppConstants.verticalSpaceSmall,
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _contactOrganizer,
                icon: const Icon(Icons.message),
                label: const Text('Message'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _shareEvent,
                icon: const Icon(Icons.share),
                label: const Text('Share'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _toggleJoinEvent() {
    setState(() {
      _isJoined = !_isJoined;
      _attendeeCount += _isJoined ? 1 : -1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isJoined ? 'Joined event successfully!' : 'Left the event'),
        backgroundColor: _isJoined ? Colors.green : Colors.orange,
      ),
    );
  }

  void _toggleBookmark() {
    // Implement bookmark functionality
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bookmark toggled')));
  }

  void _shareEvent() {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sharing event...')));
  }

  void _openMap() {
    // Implement map functionality
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Opening map...')));
  }

  void _contactOrganizer() {
    // Implement contact organizer functionality
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Opening chat with organizer...')));
  }
}
