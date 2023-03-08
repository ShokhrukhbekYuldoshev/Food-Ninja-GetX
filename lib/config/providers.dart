import 'dart:convert';
import 'package:ninjafood/features/common/infrastructure/entities/environment.dart';
import 'package:ninjafood/flavors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

///
/// Infrastructure dependencies
///

/// Exposes [SharedPreferences] instance
final sharedPreferencesProvider =
    FutureProvider((ref) => SharedPreferences.getInstance());


/// Exposes [supabase.Supabase] instance
final supabaseProvider = FutureProvider<supabase.Supabase>((ref) async {
  final configFile = await rootBundle.loadString(F.envFileName);
  final env =
      Environment.fromJson(json.decode(configFile) as Map<String, dynamic>);

  return supabase.Supabase.initialize(
    url: env.supabaseUrl,
    anonKey: env.supabaseAnonKey,
    debug: kDebugMode,
  );
});

/// Exposes [supabase.SupabaseClient] client
final supabaseClientProvider = Provider<supabase.SupabaseClient>(
  (ref) => ref.read(supabaseProvider).asData!.value.client,
);

///
/// Application dependencies
/// 


///
/// Presentation dependencies
///
///

/// Triggered from bootstrap() to complete futures
Future<void> initializeProviders(ProviderContainer container) async {
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  /// Core
  await container.read(sharedPreferencesProvider.future);
  await container.read(supabaseProvider.future);

  /// Auth
  // container.read(authControllerProvider);/
}
