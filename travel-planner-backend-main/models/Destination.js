const mongoose = require('mongoose');

const destinationSchema = new mongoose.Schema({
  name: { type: String, required: true },
  date: { type: String, required: true },
});

module.exports = mongoose.model('Destination', destinationSchema);
