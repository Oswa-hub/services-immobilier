import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:team_app/core/errors/property_failure.dart';
import 'package:team_app/features/properties/domain/entities/property.dart';
import 'package:team_app/features/properties/domain/repositories/property_repository.dart';
import 'package:team_app/features/properties/presentation/property_details_stub_page.dart';
import 'package:team_app/features/properties/providers/property_providers.dart';

import 'support_properties.dart';

class FakePropertyRepository implements PropertyRepository {
  FakePropertyRepository({this.property, this.failure});
  final Property? property;
  final PropertyFailure? failure;

  @override
  Future<Property> getPropertyById(String id) async {
    if (failure != null) throw failure!;
    return property!;
  }

  @override
  Future<List<Property>> getSimilarProperties(Property p, {int limit = 6}) async => [makeProperty(id: 'sim')];
}

Future<void> pump(WidgetTester tester, PropertyRepository repo) async {
  await tester.pumpWidget(ProviderScope(
    overrides: [propertyRepositoryProvider.overrideWithValue(repo)],
    child: const MaterialApp(home: PropertyDetailsStubPage(propertyId: 'p1')),
  ));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('loads a property by id (price, title, location, similar count)', (tester) async {
    await pump(tester, FakePropertyRepository(property: makeProperty(title: 'Villa X', price: 850000)));
    expect(find.text('850,000 TND'), findsOneWidget);
    expect(find.text('Villa X'), findsOneWidget);
    expect(find.text('La Marsa, Tunis'), findsOneWidget);
    expect(find.text('1 similar properties found'), findsOneWidget);
  });

  testWidgets('a missing property shows a friendly message and no retry', (tester) async {
    await pump(tester, FakePropertyRepository(failure: const PropertyFailure(PropertyFailureType.notFound)));
    expect(find.text('This property is no longer available.'), findsOneWidget);
    expect(find.text('Retry'), findsNothing);
  });

  testWidgets('a network failure offers Retry', (tester) async {
    await pump(tester, FakePropertyRepository(failure: const PropertyFailure(PropertyFailureType.network)));
    expect(find.text('Retry'), findsOneWidget);
  });
}
