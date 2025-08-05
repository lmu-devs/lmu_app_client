import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../application/usecase/get_faculty_by_id_usecase.dart';

class LectureListPage extends StatefulWidget {
  const LectureListPage({
    super.key,
    required this.facultyId,
  });

  final int facultyId;

  @override
  State<LectureListPage> createState() => _LectureListPageState();
}

class _LectureListPageState extends State<LectureListPage> {
  String? _facultyName;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFacultyName();
  }

  Future<void> _loadFacultyName() async {
    try {
      final getFacultyByIdUsecase = GetIt.I.get<GetFacultyByIdUsecase>();
      final faculty = await getFacultyByIdUsecase(widget.facultyId);
      setState(() {
        _facultyName = faculty.name;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _facultyName = 'Unknown Faculty';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: _isLoading ? 'Loading...' : (_facultyName ?? 'Unknown Faculty'),
        leadingAction: LeadingAction.back,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : const Center(
              child: Text('Lecture list content will go here'),
            ),
    );
  }
}
