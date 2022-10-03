const logger = require('./src/utils/logger');
const { app } = require('./app');

const { APP_PORT, APP_URL } = process.env;

const appPort = APP_PORT || 3002;

const server = app.listen(appPort, () => {
    logger.info(`[Server] listening at: ${APP_URL}:${appPort}`);
});

module.exports = {
    server
};
