CREATE TABLE auths (
    id SERIAL PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    role VARCHAR(20) NOT NULL
);

CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    dep_name VARCHAR(100) UNIQUE NOT NULL,
    dep_date DATE NOT NULL
);

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    doc_name VARCHAR(100) NOT NULL,
    doc_lastname VARCHAR(100) NOT NULL,
    doc_details TEXT,
    dep_id INTEGER REFERENCES departments(id) ON DELETE CASCADE,
    doc_date DATE NOT NULL
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    p_name VARCHAR(100) NOT NULL,
    p_lastname VARCHAR(100) NOT NULL,
    p_age INTEGER,
    p_gender VARCHAR(20),
    p_date DATE NOT NULL
);

CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    patient_lastname VARCHAR(100) NOT NULL,
    doc_id INTEGER REFERENCES doctors(id) ON DELETE CASCADE,
    date TIMESTAMP NOT NULL
);