import React, { useState } from 'react';
import axios from 'axios';
import './App.css';

function App() {
  const [students, setStudents] = useState([]);
  const [subjects, setSubjects] = useState([]);
  const [nodeId, setNodeId] = useState('');

  const fetchStudents = async () => {
    const res = await axios.get('http://api:8000/students');
    setStudents(res.data);
    setSubjects([]);
    setNodeId(res.headers['x-node-id']);
  };

  const fetchSubjects = async () => {
    const res = await axios.get('http://api:8000/subjects');
    setSubjects(res.data);
    setStudents([]);
    setNodeId(res.headers['x-node-id']);
  };

  return (
    <div className="App">
      <h1>Welcome to Student API</h1>
      <p><strong>Served by node:</strong> {nodeId}</p>
      <button onClick={fetchStudents}>Students</button>
      <button onClick={fetchSubjects}>Courses</button>

      <ul>
        {students.map((s, index) => (
          <li key={index}>{s.name} - {s.program}</li>
        ))}
        {subjects.map((s, index) => (
          <li key={index}>{s.name} - Year {s.year}</li>
        ))}
      </ul>
    </div>
  );
}

export default App;
