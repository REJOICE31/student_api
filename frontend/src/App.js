import React, { useEffect, useState } from 'react';
import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import StudentList from './Components/StudentList'; // Import the components
import CourseList from './Components/CourseList';

function App() {
    const [nodeId, setNodeId] = useState('');
    const [view, setView] = useState('home');
    const BASE_URL = "http://192.168.56.1:8000";  // ✅  Keep base URL consistent

    // Fetch Node ID on app load to display it
    useEffect(() => {
        fetch(`${BASE_URL}/api/ping/`)  // Make sure API endpoint is correct
            .then(response => {
                const node = response.headers.get('X-Node-ID');
                if (node) setNodeId(node);  // Update nodeId state based on the header
            })
            .catch(err => console.error('Ping failed', err));
    }, []);

    return (
        <div className="App container mt-4">
           <b><h1>WELCOME TO STUDENT API FRONTEND</h1></b> 
           <p>Served by Node: <strong>{nodeId || 'unknown'}</strong></p>  {/* Display Node ID */}

            {view === 'home' && (
                <>
                    <button className="btn btn-primary me-2" onClick={() => setView('students')}>Students</button>
                    <button className="btn btn-secondary" onClick={() => setView('subjects')}>Courses</button>
                </>
            )}

            {view === 'students' && (
                <>
                    <h2 className="mt-4">Students</h2>
                    <StudentList />
                    <button className="btn btn-outline-secondary mt-3" onClick={() => setView('home')}>Back</button>
                </>
            )}

            {view === 'subjects' && (
                <>
                    <h2 className="mt-4">Subjects</h2>
                    <CourseList />
                    <button className="btn btn-outline-secondary mt-3" onClick={() => setView('home')}>Back</button>
                </>
            )}
        </div>
    );
}

export default App;
