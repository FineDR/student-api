export interface Student {
    name: string;
    program: string;
  }
  
  export interface Subject {
    name: string;
    year: number;
  }
  
  export type ViewType = 'students' | 'subjects' | '';
  