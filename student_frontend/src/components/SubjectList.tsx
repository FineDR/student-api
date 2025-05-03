import React from 'react';
import { Subject } from '../types';

const SubjectList: React.FC<{ subjects: Subject[] }> = ({ subjects }) => (
  <div>
    <h2>Subjects</h2>
    <ul>
      {subjects.map((subject, idx) => (
        <li key={idx}>
          {subject.name} (Year {subject.year})
        </li>
      ))}
    </ul>
  </div>
);

export default SubjectList;
