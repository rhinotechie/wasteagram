import 'package:test/test.dart';
import 'package:wasteagram/models/post.dart';

void main() {
  test('Post object non-date properties initialization.', () {
    // Setup
    final date = DateTime.parse('2021-08-13');
    const photoURL = 'happy.jpg';
    const quantity = -3;
    const latitude = '5.7';
    const longitude = '3.8';

    // Exercise
    Post post = Post(
      date: date,
      photoURL: photoURL,
      quantity: quantity,
      latitude: latitude,
      longitude: longitude,
    );

    // Verify
    expect(post.getPhoto, 'happy.jpg');
    expect(post.getQuantity, '-3');
    expect(post.getLatitude, '5.7');
    expect(post.getLongitude, '3.8');
  });

  test('Post object date values can be retrieved.', () {
    // Setup
    final date = DateTime.parse('2021-08-13');
    const photoURL = 'nothing.jpg';
    const quantity = -5;
    const latitude = '1';
    const longitude = '2';

    // Exercise
    Post post = Post(
      date: date,
      photoURL: photoURL,
      quantity: quantity,
      latitude: latitude,
      longitude: longitude,
    );

    // Verify
    expect(post.getWeekday, 'Friday');
    expect(post.getDay, '13');
    expect(post.getMonth, 'August');
    expect(post.getYear, '2021');
  });
}
