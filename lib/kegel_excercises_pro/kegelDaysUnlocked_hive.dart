import 'package:hive/hive.dart';

class KegelStorage {
  static Box? _box;  // Make the box nullable

  // Initialize the box
  static Future<void> init() async {
    _box = await Hive.openBox('kegel_storage');
  }

  // Get the unlocked day with null check
  static int get unlockedDay {
    if (_box == null) {
      throw Exception('Hive box is not initialized');
    }
    return _box!.get('unlockedDay', defaultValue: 1); // Default to Day 1 unlocked
  }

  // Set the unlocked day with null check
  static setUnlockedDay(int day) {
    if (_box == null) {
      throw Exception('Hive box is not initialized');
    }
    _box!.put('unlockedDay', day);
  }
}
