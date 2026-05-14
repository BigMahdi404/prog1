import 'package:flutter/material.dart';
import '../data/students_data.dart';
import '../models/student.dart';
import '../widgets/student_card.dart';
import 'add_student_screen.dart';
import 'student_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Student> _students;
  List<Student> _filtered = [];

  final TextEditingController _searchController = TextEditingController();

  String _selectedLevel = 'All';
  String _selectedDepartment = 'All';
  String _sortOption = 'Name';
  bool _ascending = true;

  final List<String> _levels = ['All', '100', '200', '300', '400', '500'];

  final List<String> _departments = [
    'All',
    'Management Information Systems',
    'Computer Science',
    'Information Technology',
  ];

  @override
  void initState() {
    super.initState();
    _students = List.from(sampleStudents);
    _filtered = _students;
    _searchController.addListener(_applyFilters);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filtered = _students.where((s) {
        final matchesSearch =
            s.name.toLowerCase().contains(query) ||
            s.studentNumber.toLowerCase().contains(query) ||
            s.department.toLowerCase().contains(query);

        final matchesLevel =
            _selectedLevel == 'All' || s.level == _selectedLevel;

        final matchesDepartment =
            _selectedDepartment == 'All' || s.department == _selectedDepartment;

        return matchesSearch && matchesLevel && matchesDepartment;
      }).toList();

      switch (_sortOption) {
        case 'Name':
          _filtered.sort(
            (a, b) => _ascending
                ? a.name.compareTo(b.name)
                : b.name.compareTo(a.name),
          );
          break;

        case 'GPA':
          _filtered.sort(
            (a, b) =>
                _ascending ? a.gpa.compareTo(b.gpa) : b.gpa.compareTo(a.gpa),
          );
          break;

        case 'Level':
          _filtered.sort(
            (a, b) => _ascending
                ? a.level.compareTo(b.level)
                : b.level.compareTo(a.level),
          );
          break;
      }
    });
  }

  void _onLevelChanged(String? level) {
    if (level == null) return;
    _selectedLevel = level;
    _applyFilters();
  }

  void _addStudent(Student student) {
    setState(() {
      _students.add(student);
      _applyFilters();
    });
  }

  void _deleteStudent(String id) {
    setState(() {
      _students.removeWhere((s) => s.id == id);
      _applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MIS424 — Student Records'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                '${_filtered.length} student${_filtered.length == 1 ? '' : 's'}',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildDepartmentFilter(),
          _buildLevelFilter(),
          _buildSortControls(),

          Expanded(
            child: _filtered.isEmpty
                ? const Center(child: Text('No students found.'))
                : ListView.builder(
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final student = _filtered[index];
                      return StudentCard(
                        student: student,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StudentDetailScreen(
                              student: student,
                              onDelete: () => _deleteStudent(student.id),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push<Student>(
            context,
            MaterialPageRoute(builder: (_) => const AddStudentScreen()),
          );
          if (result != null) _addStudent(result);
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Add Student'),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search students...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildDepartmentFilter() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _departments.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final dept = _departments[index];
          final selected = dept == _selectedDepartment;

          return FilterChip(
            label: Text(dept),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedDepartment = dept;
              });
              _applyFilters();
            },
          );
        },
      ),
    );
  }

  Widget _buildLevelFilter() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _levels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final level = _levels[index];
          final selected = level == _selectedLevel;

          return ChoiceChip(
            label: Text(level),
            selected: selected,
            onSelected: (_) => _onLevelChanged(level),
          );
        },
      ),
    );
  }

  Widget _buildSortControls() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _sortOption,
              items: const [
                DropdownMenuItem(value: 'Name', child: Text('Name')),
                DropdownMenuItem(value: 'GPA', child: Text('GPA')),
                DropdownMenuItem(value: 'Level', child: Text('Level')),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() => _sortOption = value);
                _applyFilters();
              },
              decoration: const InputDecoration(
                labelText: 'Sort By',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(_ascending ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: () {
              setState(() => _ascending = !_ascending);
              _applyFilters();
            },
          ),
        ],
      ),
    );
  }
}
