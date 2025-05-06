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
  const [error, setError] = useState<string | null>(null);

  const handleFetchData = (endpoint: string, type: ViewType) => {
    setError(null); // Clear any previous error
    fetchData(
      endpoint,
      type,
      setStudents,
      setSubjects,
      setNodeId,
      setView,
      setError
    );
  };

  return (
    <div style={{ padding: '2rem', fontFamily: 'Arial, sans-serif' }}>
      <h1>Student System Dashboard</h1>

      <button
        onClick={() => handleFetchData('api/students', 'students')}
        style={{ marginRight: '1rem' }}
      >
        Students
      </button>
      <button onClick={() => handleFetchData('api/subjects', 'subjects')}>
        Courses
      </button>

      <div style={{ marginTop: '2rem' }}>
        <h3>Response Node: <span style={{ color: 'blue' }}>{nodeId || 'Not yet fetched'}</span></h3>

        {view === 'students' && <StudentList students={students} />}
        {view === 'subjects' && <SubjectList subjects={subjects} />}
      </div>

      {error && <p style={{ color: 'red' }}>Error: {error}</p>}
    </div>
  );
};

export default App;
