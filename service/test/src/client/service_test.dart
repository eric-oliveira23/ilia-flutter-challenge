import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';

import 'service_test.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
  });

  test('should call openUrl method with correct parameters', () async {
    when(mockHttpClient.openUrl(any, any)).thenAnswer((_) async => FakeHttpClientRequest());

    final url = Uri.parse('https://example.com');
    await mockHttpClient.openUrl('GET', url);

    verify(mockHttpClient.openUrl('GET', url)).called(1);
  });

  test('should return a FakeHttpClientRequest when getUrl is called', () async {
    final fakeRequest = FakeHttpClientRequest();
    when(mockHttpClient.getUrl(any)).thenAnswer((_) async => fakeRequest);

    final url = Uri.parse('https://example.com');
    final request = await mockHttpClient.getUrl(url);

    expect(request, equals(fakeRequest));
  });

  test('should handle calls to various HTTP methods', () async {
    when(mockHttpClient.get(any, any, any)).thenAnswer((_) async => FakeHttpClientRequest());
    when(mockHttpClient.post(any, any, any)).thenAnswer((_) async => FakeHttpClientRequest());

    await mockHttpClient.get('example.com', 80, '/path');
    await mockHttpClient.post('example.com', 80, '/path');

    verify(mockHttpClient.get('example.com', 80, '/path')).called(1);
    verify(mockHttpClient.post('example.com', 80, '/path')).called(1);
  });
}

class FakeHttpClientRequest extends Fake implements HttpClientRequest {}
