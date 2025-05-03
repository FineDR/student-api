import React, { useState } from 'react';
import { Student, Subject, ViewType } from './types';
import { fetchData } from './api/fetchData';
import StudentList from './components/StudentList';
import SubjectList from './components/SubjectList';

const App: React.FC = () => {
  const [students, setStudents] = useState<Student[]>([]);
  const [subjects, setSubjects] = useState<Subject[]>([]);
  const [nodeId, setNodeId] = useState<string>('');
  const [view, setView] = useState<ViewType>('');

  return (
    <div style={{ padding: '2rem', fontFamily: 'Arial, sans-serif' }}>
      <h1>Student System Dashboard</h1>

      <button onClick={() => fetchData('api/students', 'students', setStudents, setSubjects, setNodeId, setView)} style={{ marginRight: '1rem' }}>
        Students
      </button>
      <button onClick={() => fetchData('api/subjects', 'subjects', setStudents, setSubjects, setNodeId, setView)}>
        Courses
      </button>

      <div style={{ marginTop: '2rem' }}>
        <h3>Response Node: {nodeId}</h3>

        {view === 'students' && <StudentList students={students} />}
        {view === 'subjects' && <SubjectList subjects={subjects} />}
      </div>
    </div>
  );
};

export default App;
