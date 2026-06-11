import 'package:flutter_test/flutter_test.dart';
import 'package:life_track/main.dart';

void main() {
  testWidgets('App renders smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeTrackApp());
    expect(find.text('LifeTrack'), findsOneWidget);
  });
}