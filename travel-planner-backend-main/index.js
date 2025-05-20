const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const mongoose = require('mongoose');
const Destination = require('./models/Destination');
const User = require('./models/User');
const Trip = require('./models/Trip');
const bcrypt = require('bcrypt');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// MongoDB connection
mongoose.connect('mongodb://localhost:27017/travel_planner', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log('MongoDB connected'))
.catch(err => console.error(err));

// ===== ROUTES =====

// GET semua destinasi
app.get('/destinations', async (req, res) => {
  try {
    const data = await Destination.find();
    res.json(data);
  } catch (err) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// POST destinasi baru
app.post('/destinations', async (req, res) => {
  const { name, date } = req.body;
  if (!name || !date) {
    return res.status(400).json({ error: 'Name and date are required' });
  }

  try {
    const newDestination = new Destination({ name, date });
    await newDestination.save();
    res.status(201).json(newDestination);
  } catch (err) {
    console.error("Error saving destination:", err);
    res.status(500).json({ error: 'Failed to save destination' });
  }
});

// PUT edit destinasi
app.put('/destinations/:id', async (req, res) => {
  const { name, date } = req.body;
  try {
    const updated = await Destination.findByIdAndUpdate(
      req.params.id,
      { name, date },
      { new: true }
    );
    res.json(updated);
  } catch (err) {
    res.status(400).json({ error: 'Gagal mengedit destinasi' });
  }
});

// DELETE destinasi
app.delete('/destinations/:id', async (req, res) => {
  try {
    await Destination.findByIdAndDelete(req.params.id);
    res.json({ message: 'Destinasi berhasil dihapus' });
  } catch (err) {
    res.status(400).json({ error: 'Gagal menghapus destinasi' });
  }
});

// POST register user
app.post('/users/register', async (req, res) => {
  const { name, email, password } = req.body;
  const hashedPassword = await bcrypt.hash(password, 10);

  try {
    const user = new User({ name, email, password: hashedPassword });
    await user.save();
    res.status(201).json({ message: 'User registered successfully' });
  } catch (error) {
    res.status(400).json({ error: 'Email already used or invalid input' });
  }
});

// POST login user
app.post('/users/login', async (req, res) => {
  const { email, password } = req.body;

  const user = await User.findOne({ email });
  if (!user) return res.status(401).json({ error: 'Invalid email or password' });

  const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch) return res.status(401).json({ error: 'Invalid email or password' });

  res.json({ message: 'Login successful', userId: user._id });
});

// GET semua trip
app.get('/trips', async (req, res) => {
  try {
    const trips = await Trip.find();
    res.json(trips);
  } catch (error) {
    res.status(500).json({ error: 'Failed to get trips' });
  }
});

// POST tambah trip
app.post('/trips', async (req, res) => {
  const { title, startDate, endDate, destinations } = req.body;

  try {
    const trip = new Trip({
      title,
      startDate,
      endDate,
      destinations, // array of { name, date }
    });

    await trip.save();
    res.status(201).json(trip);
  } catch (error) {
    console.error('Error saving trip:', error);
    res.status(400).json({ error: 'Gagal menyimpan trip' });
  }
});

// PUT tambah destinasi ke trip tertentu
app.put('/trips/:id', async (req, res) => {
  const { name, date } = req.body;
  try {
    const trip = await Trip.findById(req.params.id);
    trip.destinations.push({ name, date });
    await trip.save();
    res.json(trip);
  } catch (error) {
    console.error('Error updating trip:', error);
    res.status(400).json({ error: 'Gagal menambahkan destinasi ke trip' });
  }
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
