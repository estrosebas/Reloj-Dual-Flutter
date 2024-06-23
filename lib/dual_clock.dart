// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
class DualClock extends StatefulWidget {
  const DualClock({super.key});

  @override
  _DualClockState createState() => _DualClockState();
}

class _DualClockState extends State<DualClock> {
  DateTime _peruTime = DateTime.now().toUtc().add(const Duration(hours: -5));
  DateTime _boliviaTime = DateTime.now().toUtc().add(const Duration(hours: -4));
  late Timer _timer;
  String _currentActivity = 'No hay actividad en curso';
  String _quoteOfDay = 'Cargando...';
  final List<Map<String, dynamic>> _peruSchedules = [
    {
      'day': DateTime.monday,
      'startTime': const TimeOfDay(hour: 9, minute: 0),
      'endTime': const TimeOfDay(hour: 10, minute: 0),
      'activity': 'Clase de Matemáticas'
    },
    {
      'day': DateTime.tuesday,
      'startTime': const TimeOfDay(hour: 14, minute: 0),
      'endTime': const TimeOfDay(hour: 15, minute: 0),
      'activity': 'Clase de Física'
    },
    // Agrega más horarios según sea necesario
  ];

  final List<Map<String, dynamic>> _boliviaSchedules = [
    {
      'day': DateTime.monday,
      'startTime': const TimeOfDay(hour: 7, minute: 30),
      'endTime': const TimeOfDay(hour: 8, minute: 20),
      'activity': 'Embriologia'
    },
    {
      'day': DateTime.monday,
      'startTime': const TimeOfDay(hour: 8, minute: 20),
      'endTime': const TimeOfDay(hour: 9, minute: 10),
      'activity': 'Embriologia'
    },
    {
      'day': DateTime.monday,
      'startTime': const TimeOfDay(hour: 9, minute: 20),
      'endTime': const TimeOfDay(hour: 10, minute: 10),
      'activity': 'Embriologia'
    },
    {
      'day': DateTime.monday,
      'startTime': const TimeOfDay(hour: 10, minute: 10),
      'endTime': const TimeOfDay(hour: 11, minute: 00),
      'activity': 'Anatomia'
    },
    {
      'day': DateTime.monday,
      'startTime': const TimeOfDay(hour: 11, minute: 10),
      'endTime': const TimeOfDay(hour: 12, minute: 00),
      'activity': 'Anatomia'
    },
    {
      'day': DateTime.monday,
      'startTime': const TimeOfDay(hour: 12, minute: 00),
      'endTime': const TimeOfDay(hour: 12, minute: 50),
      'activity': 'Anatomia'
    },
    {
      'day': DateTime.monday,
      'startTime': const TimeOfDay(hour: 13, minute: 00),
      'endTime': const TimeOfDay(hour: 13, minute: 50),
      'activity': 'Histologia'
    },
    {
      'day': DateTime.monday,
      'startTime': const TimeOfDay(hour: 13, minute: 50),
      'endTime': const TimeOfDay(hour: 14, minute: 40),
      'activity': 'Histologia'
    },
    {
      'day': DateTime.tuesday,
      'startTime': const TimeOfDay(hour: 7, minute: 30),
      'endTime': const TimeOfDay(hour: 8, minute: 20),
      'activity': 'Bioquimica'
    },
    {
      'day': DateTime.tuesday,
      'startTime': const TimeOfDay(hour: 8, minute: 20),
      'endTime': const TimeOfDay(hour: 9, minute: 10),
      'activity': 'Bioquimica'
    },
    {
      'day': DateTime.tuesday,
      'startTime': const TimeOfDay(hour: 9, minute: 20),
      'endTime': const TimeOfDay(hour: 10, minute: 10),
      'activity': 'Anatomia'
    },
    {
      'day': DateTime.tuesday,
      'startTime': const TimeOfDay(hour: 10, minute: 10),
      'endTime': const TimeOfDay(hour: 11, minute: 00),
      'activity': 'Anatomia'
    },
    {
      'day': DateTime.tuesday,
      'startTime': const TimeOfDay(hour: 11, minute: 10),
      'endTime': const TimeOfDay(hour: 12, minute: 00),
      'activity': 'Anatomia'
    },
    {
      'day': DateTime.tuesday,
      'startTime': const TimeOfDay(hour: 12, minute: 00),
      'endTime': const TimeOfDay(hour: 12, minute: 50),
      'activity': 'Anatomia'
    },
    // Miércoles
    {
      'day': DateTime.wednesday,
      'startTime': const TimeOfDay(hour: 9, minute: 20),
      'endTime': const TimeOfDay(hour: 10, minute: 10),
      'activity': 'Anatomía Humana'
    },
    {
      'day': DateTime.wednesday,
      'startTime': const TimeOfDay(hour: 10, minute: 10),
      'endTime': const TimeOfDay(hour: 11, minute: 00),
      'activity': 'Anatomía Humana'
    },
    {
      'day': DateTime.wednesday,
      'startTime': const TimeOfDay(hour: 11, minute: 10),
      'endTime': const TimeOfDay(hour: 12, minute: 00),
      'activity': 'Anatomía Humana'
    },
    {
      'day': DateTime.wednesday,
      'startTime': const TimeOfDay(hour: 12, minute: 00),
      'endTime': const TimeOfDay(hour: 12, minute: 50),
      'activity': 'Anatomía Humana'
    },
    {
      'day': DateTime.wednesday,
      'startTime': const TimeOfDay(hour: 13, minute: 00),
      'endTime': const TimeOfDay(hour: 13, minute: 50),
      'activity': 'Inglés Técnico'
    },
    {
      'day': DateTime.wednesday,
      'startTime': const TimeOfDay(hour: 14, minute: 50),
      'endTime': const TimeOfDay(hour: 15, minute: 40),
      'activity': 'Embriologia'
    },
    {
      'day': DateTime.wednesday,
      'startTime': const TimeOfDay(hour: 15, minute: 40),
      'endTime': const TimeOfDay(hour: 16, minute: 30),
      'activity': 'Embriologia'
    },
    // Jueves
    {
      'day': DateTime.thursday,
      'startTime': const TimeOfDay(hour: 7, minute: 30),
      'endTime': const TimeOfDay(hour: 8, minute: 20),
      'activity': 'Histología'
    },
    {
      'day': DateTime.thursday,
      'startTime': const TimeOfDay(hour: 8, minute: 20),
      'endTime': const TimeOfDay(hour: 9, minute: 10),
      'activity': 'Histología'
    },
    {
      'day': DateTime.thursday,
      'startTime': const TimeOfDay(hour: 9, minute: 20),
      'endTime': const TimeOfDay(hour: 10, minute: 10),
      'activity': 'Histología'
    },
    {
      'day': DateTime.thursday,
      'startTime': const TimeOfDay(hour: 10, minute: 10),
      'endTime': const TimeOfDay(hour: 11, minute: 00),
      'activity': 'Anatomía Humana'
    },
    {
      'day': DateTime.thursday,
      'startTime': const TimeOfDay(hour: 11, minute: 10),
      'endTime': const TimeOfDay(hour: 12, minute: 00),
      'activity': 'Anatomía Humana'
    },
    {
      'day': DateTime.thursday,
      'startTime': const TimeOfDay(hour: 12, minute: 00),
      'endTime': const TimeOfDay(hour: 12, minute: 50),
      'activity': 'Inglés Técnico'
    },
    {
      'day': DateTime.thursday,
      'startTime': const TimeOfDay(hour: 13, minute: 00),
      'endTime': const TimeOfDay(hour: 13, minute: 50),
      'activity': 'Inglés Técnico'
    },
    // Viernes
    {
      'day': DateTime.friday,
      'startTime': const TimeOfDay(hour: 7, minute: 30),
      'endTime': const TimeOfDay(hour: 8, minute: 20),
      'activity': 'Salud Pública'
    },
    {
      'day': DateTime.friday,
      'startTime': const TimeOfDay(hour: 8, minute: 20),
      'endTime': const TimeOfDay(hour: 9, minute: 10),
      'activity': 'Salud Pública'
    },
    {
      'day': DateTime.friday,
      'startTime': const TimeOfDay(hour: 9, minute: 20),
      'endTime': const TimeOfDay(hour: 10, minute: 10),
      'activity': 'Anatomia'
    },
    {
      'day': DateTime.friday,
      'startTime': const TimeOfDay(hour: 10, minute: 10),
      'endTime': const TimeOfDay(hour: 11, minute: 00),
      'activity': 'Anatomia'
    },
    {
      'day': DateTime.friday,
      'startTime': const TimeOfDay(hour: 11, minute: 10),
      'endTime': const TimeOfDay(hour: 12, minute: 00),
      'activity': 'Bioquimica'
    },
    {
      'day': DateTime.friday,
      'startTime': const TimeOfDay(hour: 12, minute: 00),
      'endTime': const TimeOfDay(hour: 12, minute: 50),
      'activity': 'Bioquimica'
    },
  ];


  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _updateTime());
    _loadQuoteOfDay();
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
      _currentActivity = _compareSchedules(_peruTime, _boliviaTime);
    });
  }

  Future<void> _loadQuoteOfDay() async {
    try {
      final response = await http.get(Uri.parse('https://frasedeldia.azurewebsites.net/api/phrase'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final frase = data['phrase'];
        final autor = data['author'];
        setState(() {
          _quoteOfDay = '$frase - $autor';
        });
      } else {
        setState(() {
          _quoteOfDay = 'El conocimiento es grande pero sin internet vamos más lento';
        });
      }
    } catch (e) {
      setState(() {
        _quoteOfDay = 'El conocimiento es grande pero sin internet vamos más lento';
      });
    }
  }

  String _compareSchedules(DateTime peruTime, DateTime boliviaTime) {
    bool peruBusy = _isTimeInSchedule(peruTime, _peruSchedules);
    bool boliviaBusy = _isTimeInSchedule(boliviaTime, _boliviaSchedules);

    if (peruBusy && boliviaBusy) {
      return 'Ambos están ocupados';
    } else if (!peruBusy && !boliviaBusy) {
      return 'Ambos están libres';
    } else if (peruBusy) {
      return 'Solo Perú está ocupado';
    } else {
      return 'Solo Bolivia está ocupado';
    }
  }


  bool _isTimeInSchedule(DateTime currentTime, List<Map<String, dynamic>> schedules) {
    for (var schedule in schedules) {
      if (schedule['day'] == currentTime.weekday) {
        final startTime = DateTime(currentTime.year, currentTime.month, currentTime.day, schedule['startTime'].hour, schedule['startTime'].minute);
        final endTime = DateTime(currentTime.year, currentTime.month, currentTime.day, schedule['endTime'].hour, schedule['endTime'].minute);

        if (currentTime.isAfter(startTime) && currentTime.isBefore(endTime)) {
          return true;
        }
      }
    }
    return false;
  }

  String _getBackgroundImage(DateTime peruTime) {
    final hour = peruTime.hour;
    if (hour >= 6 && hour < 12) {
      return 'assets/images/midday.gif';
    } else if (hour >= 12 && hour < 18) {
      return 'assets/images/day.gif';
    } else {
      return 'assets/images/night.gif';
    }
  }
  String _getPeruActivity(DateTime currentTime) {
    for (var schedule in _peruSchedules) {
      if (schedule['day'] == currentTime.weekday) {
        final startTime = DateTime(currentTime.year, currentTime.month, currentTime.day, schedule['startTime'].hour, schedule['startTime'].minute);
        final endTime = DateTime(currentTime.year, currentTime.month, currentTime.day, schedule['endTime'].hour, schedule['endTime'].minute);

        if (currentTime.isAfter(startTime) && currentTime.isBefore(endTime)) {
          return schedule['activity'];
        }
      }
    }
    return 'Libre';
  }

  String _getBoliviaActivity(DateTime currentTime) {
    for (var schedule in _boliviaSchedules) {
      if (schedule['day'] == currentTime.weekday) {
        final startTime = DateTime(currentTime.year, currentTime.month, currentTime.day, schedule['startTime'].hour, schedule['startTime'].minute);
        final endTime = DateTime(currentTime.year, currentTime.month, currentTime.day, schedule['endTime'].hour, schedule['endTime'].minute);

        if (currentTime.isAfter(startTime) && currentTime.isBefore(endTime)) {
          return schedule['activity'];
        }
      }
    }
    return 'Libre';
  }
  @override
  Widget build(BuildContext context) {
    final backgroundImage = _getBackgroundImage(_peruTime);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.flag, color: Colors.white),
                            const SizedBox(height: 8.0),
                            Text(
                              'Perú: ${_peruTime.hour.toString().padLeft(2, '0')}:${_peruTime.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(fontSize: 24.0, color: Colors.white),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Actividad: ${_getPeruActivity(_peruTime)}',
                              style: const TextStyle(fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.flag, color: Colors.white),
                            const SizedBox(height: 8.0),
                            Text(
                              'Bolivia: ${_boliviaTime.hour.toString().padLeft(2, '0')}:${_boliviaTime.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(fontSize: 24.0, color: Colors.white),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Actividad: ${_getBoliviaActivity(_boliviaTime)}',
                              style: const TextStyle(fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Estado: $_currentActivity',
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    _quoteOfDay,
                    style: GoogleFonts.kanit(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
