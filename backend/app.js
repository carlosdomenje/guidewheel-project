const express = require("express");
const cors = require("cors");
const dotenv = require('dotenv').config();
const logger = require("./src/utils/logger");

const routes = require('./src/routes/index.routes');
const {getData}  = require("./src/config/db.config");

const errorHandler = require('./src/middlewares/errorHandler');

// initialize express.
const app = express();

// Middleware
app.use(cors());

// Body Parser
app.use(express.json({ extended: false, limit: "50mb" }));
app.use(express.urlencoded({ extended: false, limit: "50mb" }));


// ROUTES
app.use(routes);

// Middleware to handle errors
app.use(errorHandler)



const logUnhandledError = (reason) => {
  logger.error(`exception occurred \n${JSON.stringify(reason)}`);
};

// Add logger process.on
process.on('unhandledRejection', logUnhandledError);
process.on('unhandledException', logUnhandledError);


module.exports = {
  app
};
