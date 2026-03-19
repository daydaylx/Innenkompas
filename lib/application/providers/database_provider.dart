import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/db/app_database.dart';

/// Provider for the database connection.
///
/// This creates a singleton instance of the AppDatabase.
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

/// Provider for database initialization status.
///
/// Use this to check if the database is ready before performing operations.
final databaseInitProvider = Provider<bool>((ref) {
  // Watch the database provider to ensure it's created
  ref.watch(databaseProvider);
  // The database is created synchronously, so it's always initialized
  // after the provider is read. In the future, you might want to add
  // migrations or other async initialization logic.
  return true;
});
