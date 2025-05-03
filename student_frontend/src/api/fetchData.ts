import { Student, Subject, ViewType } from '../types';
import { apiBase } from '../utils/config';

export const fetchData = async (
    endpoint: string,
    type: ViewType,
    setStudents: React.Dispatch<React.SetStateAction<Student[]>>,
    setSubjects: React.Dispatch<React.SetStateAction<Subject[]>>,
    setNodeId: (id: string) => void,
    setView: (view: ViewType) => void
) => {
    const fullUrl = `${apiBase}${endpoint}`;
    console.log(`Requesting: ${fullUrl}`);

    try {
        const res = await fetch(fullUrl, {
            headers: {
                'Accept': 'application/json'
            }
        });

        const contentType = res.headers.get('Content-Type') || '';
        console.log('Response Status:', res.status);
        console.log('Response Content-Type:', contentType);

        if (!res.ok) {
            throw new Error(`Error: ${res.status} ${res.statusText}`);
        }

        if (!contentType.includes('application/json')) {
            throw new Error('Invalid content type: expected JSON');
        }

        const nodeHeader = res.headers.get('X-Node-ID') || 'Unknown';
        const data = await res.json();

        setNodeId(nodeHeader);
        setView(type);

        // Properly extract nested data
        if (type === 'students' && data.students) {
            setStudents(data.students);
        } else if (type === 'subjects' && data.subjects) {
            setSubjects(data.subjects);
        } else {
            throw new Error(`Unexpected response format for type: ${type}`);
        }
    } catch (err) {
        console.error('Error fetching data:', err);
        setNodeId('Unavailable');
    }
};
