const { createLogger, format, transports } = require('winston');

const { combine, timestamp, label, printf, colorize } = format;

// Define the format of the log

const myFormat = printf(({ level, message, label, timestamp }) => {
  return `${timestamp} [${label}] ${level}: ${message}`;
});

const logger = createLogger({
  // level: LOG_LEVEL,
  format: combine(colorize(), label({ label: 'GuideWheel' }), timestamp(), myFormat),
  transports: [new transports.Console()],
});

logger.stream = {
  write: (message, encoding) => {
    logger.info(message);
  },
};

module.exports = logger;
