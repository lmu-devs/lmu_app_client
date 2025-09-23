import 'dart:convert';
import 'dart:io';

// Import the DTO (adjust path as needed)
import 'lib/src/infrastructure/secondary/data/dto/lecture_dto.dart';

void main() async {
  print('🧪 Testing LectureDto Conversion from API Response\n');

  // Test cases with different API response scenarios
  await testCompleteData();
  await testPartialData();
  await testMinimalData();
  await testMalformedData();
  await testEdgeCases();
  testRealApiStructure();
  await testRealApiCall();
}

Future<void> testCompleteData() async {
  print('📋 Test 1: Complete Data');
  final jsonResponse = {
    "id": "lecture_001",
    "name": "Advanced Flutter Development",
    "description": "Learn advanced Flutter concepts and best practices",
    "sws": 6,
    "semester": "WS2024",
    "tags": ["flutter", "mobile", "development"]
  };

  final dto = LectureDto.fromJson(jsonResponse);
  final lecture = dto.toDomain(facultyId: 1);

  print('✅ Input: ${jsonEncode(jsonResponse)}');
  print('✅ DTO: id=${dto.id}, name=${dto.name}, sws=${dto.sws}');
  print('✅ Lecture: id=${lecture.id}, title=${lecture.title}, facultyId=${lecture.facultyId}');
  print('');
}

Future<void> testPartialData() async {
  print('📋 Test 2: Partial Data (Missing Description & Credits)');
  final jsonResponse = {
    "id": "lecture_002",
    "name": "Basic Programming",
    "semester": "SS2024",
    "tags": ["programming", "basics"]
  };

  final dto = LectureDto.fromJson(jsonResponse);
  final lecture = dto.toDomain(facultyId: 2);

  print('✅ Input: ${jsonEncode(jsonResponse)}');
  print('✅ DTO: id=${dto.id}, name=${dto.name}, sws=${dto.sws}');
  print('✅ Lecture: id=${lecture.id}, title=${lecture.title}, description=${lecture.description}, sws=${lecture.sws}');
  print('');
}

Future<void> testMinimalData() async {
  print('📋 Test 3: Minimal Data (Only ID and Name)');
  final jsonResponse = {"id": "lecture_003", "name": "Introduction to Computer Science"};

  final dto = LectureDto.fromJson(jsonResponse);
  final lecture = dto.toDomain(facultyId: 3);

  print('✅ Input: ${jsonEncode(jsonResponse)}');
  print('✅ DTO: id=${dto.id}, name=${dto.name}, facultyId=${dto.facultyId}');
  print('✅ Lecture: id=${lecture.id}, title=${lecture.title}, facultyId=${lecture.facultyId}');
  print('');
}

Future<void> testMalformedData() async {
  print('📋 Test 4: Malformed Data (Type Mismatches)');
  final jsonResponse = {"id": 123, "name": "Data Structures", "sws": "5", "semester": 2024, "tags": "algorithm,data"};

  final dto = LectureDto.fromJson(jsonResponse);
  final lecture = dto.toDomain(facultyId: 4);

  print('✅ Input: ${jsonEncode(jsonResponse)}');
  print('✅ DTO: id=${dto.id}, name=${dto.name}, sws=${dto.sws}');
  print('✅ Lecture: id=${lecture.id}, title=${lecture.title}, sws=${lecture.sws}');
  print('');
}

Future<void> testEdgeCases() async {
  print('📋 Test 6: Edge Cases');

  // Empty JSON
  final emptyDto = LectureDto.fromJson({});
  final emptyLecture = emptyDto.toDomain(facultyId: 5);
  print('✅ Empty JSON: ${emptyLecture.id} - ${emptyLecture.title}');

  // Null values
  final nullDto = LectureDto.fromJson({"id": null, "name": null});
  final nullLecture = nullDto.toDomain(facultyId: 6);
  print('✅ Null values: ${nullLecture.id} - ${nullLecture.title}');

  // Empty strings
  final emptyStringDto = LectureDto.fromJson({"id": "", "name": ""});
  final emptyStringLecture = emptyStringDto.toDomain(facultyId: 7);
  print('✅ Empty strings: ${emptyStringLecture.id} - ${emptyStringLecture.title}');
  print('');
}

void testRealApiStructure() {
  print('📋 Test 7: Real API Response Structure');

  // Test with the actual API response structure you provided
  final realApiJson = {
    "publish_id": 1059871,
    "name": "Inferenzstatistik",
    "sws": null,
    "class_type": "Prüfung",
    "language": "Deutsch"
  };

  print('✅ Input: ${jsonEncode(realApiJson)}');

  try {
    final dto = LectureDto.fromJson(realApiJson);
    final lecture = dto.toDomain(facultyId: 16, termId: 1, year: 2025);

    print(
        '✅ DTO: id=${dto.id}, name=${dto.name}, sws=${dto.sws}, class_type=${realApiJson['class_type']}, language=${realApiJson['language']}');
    print('✅ Lecture: id=${lecture.id}, title=${lecture.title}, sws=${lecture.sws}, tags=${lecture.tags}');
  } catch (e) {
    print('❌ Error: $e');
  }

  print('');
}

Future<void> testRealApiCall() async {
  print('📋 Test 5: Real API Call for Faculty ID 16');

  try {
    // Try to make a real API call
    final client = HttpClient();
    final request = await client
        .getUrl(Uri.parse('https://api-staging.lmu-dev.org/v1/course-by-faculty?faculty_id=16&term_id=1&year=2025'));
    request.headers.set('user-api-key', 'bc322e6115c15ac6c5db877337a9270bb883a63c3b65afe4f705db0c8e5eb038');
    request.headers.set('accept-language', 'de');
    request.headers.set('app-version', '1.1.1');

    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(responseBody);
      print('✅ API Response Status: ${response.statusCode}');
      print('✅ Number of lectures: ${jsonList.length}');

      if (jsonList.isNotEmpty) {
        // Show raw JSON for first lecture to debug field mapping
        print('\n🔍 Raw JSON for first lecture:');
        print(jsonEncode(jsonList.first));
        print('\n🔍 Available fields in first lecture:');
        final firstJson = jsonList.first as Map<String, dynamic>;
        firstJson.forEach((key, value) {
          print('   • $key: $value (${value.runtimeType})');
        });

        // Convert all lectures
        final lectures = jsonList.map((json) {
          final dto = LectureDto.fromJson(json);
          return dto.toDomain(facultyId: 16, termId: 1, year: 2025);
        }).toList();

        print('\n✅ Successfully converted ${lectures.length} lectures');
        print('\n📚 First 10 Lectures:\n');

        // Display first 10 lectures in readable format
        for (int i = 0; i < 10 && i < lectures.length; i++) {
          final lecture = lectures[i];
          print('${i + 1}. ${lecture.title}');
          print('   • ID: ${lecture.id}');
          print('   • Faculty ID: ${lecture.facultyId}');
          print('   • Description: ${lecture.description ?? 'N/A'}');
          print('   • SWS: ${lecture.sws ?? 'N/A'}');
          print('   • Semester: ${lecture.semester ?? 'N/A'}');
          print('   • Tags: ${lecture.tags.isEmpty ? 'N/A' : lecture.tags.join(', ')}');
          print('   ────────────────────────────────────────────────────────────────');
        }
      }
    } else {
      print('❌ API Error: ${response.statusCode}');
      print('Response: $responseBody');
    }

    client.close();
  } catch (e) {
    print('❌ API Call Failed: $e');
    print('This is expected if the API is not accessible or credentials are invalid.');
  }

  print('');
}
