import React, { useState, useEffect } from 'react';
import axios from 'axios';

const CourseList = () => {
    const [courses, setCourses] = useState([]);
    const [error, setError] = useState("");
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchCourses = async () => {
            try {
                const response = await axios.get("http://127.0.0.1:8000/subjects/");
                const subjectsData = response.data.data.subjects;
                const allCourses = Object.values(subjectsData).flat();
                setCourses(allCourses);
            } catch (error) {
                console.error("Error fetching courses", error);
                setError("Could not load courses");
            } finally {
                setLoading(false);
            }
        };
        fetchCourses();
    }, []);

    if (loading) {
        return <div>Loading Courses...</div>;
    }

    if (error) {
        return <div>Error: {error.message}</div>;
    }

    return (
        <div>
         
            <pre>{JSON.stringify(courses, null, 2)}</pre>
        </div>
    );
};

export default CourseList;