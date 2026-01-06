const express = require('express');
const { Pool } = require('pg');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') }); // adjust path if .env is outside backend

const app = express();
const port = process.env.PORT || 3000;

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: parseInt(process.env.DB_PORT, 10),
});

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static('public')); // optional if you want a public folder

// Serve main page
app.get('/', async (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

// Get all people (for real-time table update)
app.get('/people', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM person ORDER BY serial_number');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error fetching people');
  }
});

// Add a person
app.post('/submit', async (req, res) => {
  const { name, age } = req.body;
  try {
    await pool.query('INSERT INTO person (name, age) VALUES ($1, $2)', [name, age]);
    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false });
  }
});

// Delete a person
app.post('/delete', async (req, res) => {
  const { id } = req.body;
  try {
    await pool.query('DELETE FROM person WHERE serial_number = $1', [id]);
    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false });
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
