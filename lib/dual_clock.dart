import 'dart:async';
import 'package:flutter/material.dart';

class DualClock extends StatefulWidget {
  const DualClock({super.key});

  @override
  _DualClockState createState() => _DualClockState();
}

class _DualClockState extends State<DualClock> {
  DateTime _peruTime = DateTime.now().toUtc().add(const Duration(hours: -5));
  DateTime _boliviaTime = DateTime.now().toUtc().add(const Duration(hours: -4));
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _peruTime = DateTime.now().toUtc().add(const Duration(hours: -5));
      _boliviaTime = DateTime.now().toUtc().add(const Duration(hours: -4));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Perú: ${_peruTime.hour.toString().padLeft(2, '0')}:${_peruTime.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Bolivia: ${_boliviaTime.hour.toString().padLeft(2, '0')}:${_boliviaTime.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 24.0),
          ),
        ],
      ),
    );
  }
}