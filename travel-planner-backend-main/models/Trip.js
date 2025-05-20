const mongoose = require('mongoose');

const tripSchema = new mongoose.Schema({
  title: { type: String, required: true },
  startDate: String,
  endDate: String,
  destinations: [
    {
      name: String,
      date: String,
    },
  ],
});

module.exports = mongoose.model('Trip', tripSchema);
