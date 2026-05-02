import '../models/student.dart';

// ─────────────────────────────────────────────────────────────────────────────
// STUDENT CONTRIBUTION AREA
// Each student adds ONE entry to this list.
// Format: Student(
//   id: 'unique-id',              ← use your studentNumber as the id
//   studentNumber: 'MIS/2021/001',
//   name: 'Full Name Here',
//   department: 'Management Information Systems',
//   level: '400',
//   gpa: 4.5,
//   email: 'youremail@university.edu.ng',
//   contributedBy: 'MIS/2021/001 — Full Name',  ← YOUR student number + name
// ),
// ─────────────────────────────────────────────────────────────────────────────

final List<Student> sampleStudents = [
  // ── SAMPLE RECORDS (DO NOT DELETE — use as reference) ──────────────────────
  const Student(
    id: 'sample-001',
    studentNumber: 'MIS/2021/001',
    name: 'Ada Okonkwo',
    department: 'Management Information Systems',
    level: '400',
    gpa: 4.2,
    email: 'ada.okonkwo@university.edu.ng',
    contributedBy: 'MIS/2021/001 — Ada Okonkwo',
  ),
  const Student(
    id: 'sample-002',
    studentNumber: 'MIS/2021/002',
    name: 'Emeka Chukwu',
    department: 'Management Information Systems',
    level: '400',
    gpa: 3.8,
    email: 'emeka.chukwu@university.edu.ng',
    contributedBy: 'MIS/2021/002 — Emeka Chukwu',
  ),
  const Student(
    id: 'sample-003',
    studentNumber: 'MIS/2021/003',
    name: 'Ngozi Adeyemi',
    department: 'Management Information Systems',
    level: '300',
    gpa: 4.7,
    email: 'ngozi.adeyemi@university.edu.ng',
    contributedBy: 'MIS/2021/003 — Ngozi Adeyemi',
  ),
  const Student(
    id: '2102-0600-27',
    studentNumber: '2102060027',
    name: 'Amadou Tyou',
    department: 'Management Information Systems',
    level: '400',
    gpa: 2.8,
    email: 'amadou.tyou@final.edu.tr',
    contributedBy: '202060027 — Amadou Tyou',
  ),

  // ── STUDENT CONTRIBUTIONS BELOW THIS LINE ──────────────────────────────────
  // TODO: Add your own Student entry here (see format above)
const Student(
  id: '2102060053',
  studentNumber: '2102060053',
  name: 'Mehdy Fleifel',
  department: 'Management Information Systems',
  level: '400',
  gpa: 3.5 , 
  email: 'mehdy.fleifel@final.edu.tr',
  contributedBy: '2102060053 — Mehdy Fleifel',
),
];