const logger = require('../utils/logger');

function errorHandler(error, req, res, next) {
  const { message, statusCode } = error;
  logger.error('---- Error Handler ----');
  // This case catch all the error responses from a request made with axios
  if (error.response) {
    const { status, data, config } = error.response;
    logger.error(
      `Request: [${config.method}] ${
        config.url
      } --- Got a [${status}] --- [data]: ${JSON.stringify(data)}`
    );
    return res.status(status).json({
      success: false,
      error: 'Server Error',
    });
  }

  // All the errors without a status code are considered as a server error
  if (!statusCode) {
    logger.error(`[${statusCode}]: \n ${error.stack}`);
    return res.status(500).json({
      success: false,
      error: 'Server Error',
    });
  } else if (statusCode >= 500) {
    logger.error(`[${statusCode}]: ${error.message}`);
    return res.status(500).json({
      success: false,
      error: 'Server Error',
    });
  } else {
    logger.error(`[${statusCode}]: ${error.message}`);

    // Matches special sequence that is used to add colors to text in the console
    const regex = /\x1B\[(\d*)\[*m/g;
    // Cleans the format of the message, before sending it to frontend
    const unformattedMessage = message.replace(regex, '')
    
    return res.status(statusCode).json({
      success: false,
      error: unformattedMessage,
    });
  }
}

module.exports = errorHandler;
