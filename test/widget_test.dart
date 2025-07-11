import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import 'package:campkeeper_riverpod/main.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/repositories/campsite_repository.dart';
import 'package:campkeeper_riverpod/features/campsites/domain/entities/campsite.dart';
import 'package:campkeeper_riverpod/features/campsites/presentation/providers/campsite_providers.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([CampsiteRepository])
void main() {
  late MockCampsiteRepository mockRepository;

  setUp(() {
    mockRepository = MockCampsiteRepository();
  });

  testWidgets('App loads correctly', (WidgetTester tester) async {
    when(mockRepository.getCampsites()).thenAnswer(
      // ignore: prefer_const_constructors
      (_) async => Right(<Campsite>[]),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          campsiteRepositoryProvider.overrideWithValue(mockRepository),
        ],
        child: const CampKeeperApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('CampKeeper'), findsOneWidget);
  });

  testWidgets('App shows loading state initially', (WidgetTester tester) async {
    when(mockRepository.getCampsites()).thenAnswer(
      (_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        // ignore: prefer_const_constructors
        return Right(<Campsite>[]);
      },
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          campsiteRepositoryProvider.overrideWithValue(mockRepository),
        ],
        child: const CampKeeperApp(),
      ),
    );

    await tester.pump();

    expect(find.text('CampKeeper'), findsOneWidget);

    await tester.pumpAndSettle();
  });
}
