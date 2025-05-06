import { Student, Subject, ViewType } from '../types';
import { apiBase } from '../utils/config';

export const fetchData = async (
  endpoint: string,
  type: ViewType,
  setStudents: React.Dispatch<React.SetStateAction<Student[]>>,
  setSubjects: React.Dispatch<React.SetStateAction<Subject[]>>,
  setNodeId: (id: string) => void,
  setView: (view: ViewType) => void,
  setError: (err: string | null) => void
) => {
  const fullUrl = `${apiBase}${endpoint}`;
  console.log(`Requesting: ${fullUrl}`);

  try {
    const res = await fetch(fullUrl, {
      headers: { Accept: 'application/json' },
    });

    const contentType = res.headers.get('Content-Type') || '';
    console.log('Response Status:', res.status);
    console.log('Response Content-Type:', contentType);

    if (!res.ok) {
      throw new Error(`HTTP error: ${res.status} ${res.statusText}`);
    }

    if (!contentType.includes('application/json')) {
      throw new Error('Expected JSON response');
    }

    // Get the X-Node-ID header or fallback to env
    const nodeHeader = res.headers.get('X-Node-ID') || import.meta.env.VITE_NODE_ID || '';
    const data = await res.json();

    // Update the state with the node ID and fetched data
    setNodeId(nodeHeader);
    setView(type);
    setError(null);

    if (type === 'students' && data.students) {
      setStudents(data.students);
    } else if (type === 'subjects' && data.subjects) {
      setSubjects(data.subjects);
    } else {
      throw new Error(`Unexpected data format for type: ${type}`);
    }
  } catch (err: unknown) {
    if (err instanceof Error) {
      console.error('Fetch failed:', err.message);
      setError(err.message);
    } else {
      console.error('Unknown error:', err);
      setError('An unknown error occurred');
    }
    setNodeId(import.meta.env.VITE_NODE_ID || 'Unavailable');
  }
};
