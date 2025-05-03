import React from 'react';
import { Student } from '../types';

const StudentList: React.FC<{ students: Student[] }> = ({ students }) => (
  <div>
    <h2>Students</h2>
    <ul>
      {students.map((student, idx) => (
        <li key={idx}>
          {student.name} - {student.program}
        </li>
      ))}
    </ul>
  </div>
);

export default StudentList;
