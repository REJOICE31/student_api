import React, { useState, useEffect } from 'react';
import axios from 'axios';

const StudentList = () => {
    const [students, setStudents] = useState([]);
    const [error, setError] = useState("");
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchStudents = async () => {
            try {
                const response = await axios.get("http://127.0.0.1:8000/students/");
                setStudents(response.data.data.students);
            } catch (error) {
                console.error("Error fetching students", error);
                setError("Could not load students");
            } finally {
                setLoading(false);
            }
        };
        fetchStudents();
    }, []);

    if (loading) {
        return <div>Loading Students...</div>;
    }

    if (error) {
        return <div>Error: {error.message}</div>;
    }

    return (
        <div>
            <pre>{JSON.stringify(students, null, 2)}</pre>
        </div>
    );
};

export default StudentList;