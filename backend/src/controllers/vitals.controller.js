const { logger } = require ('../utils/logger');

/**
 * Get Welcome msg
 * 
 * @returns {Hello World} response with code 200 and Hello World message.
 */
exports.welcome = (req, res, next) => {
    try {
        res.send('Hello World - GuideWheel');
    } catch (error) {
        logger.error(error);
        res.status(500).send('There was a problem handling the request');
    }
}
/**
 * Make a ping to server to confirm that is alive
 * 
 * @returns {Pong} response with code 200 and Pong message.
 */
exports.alive = (req, res, next) => {
    try {
        logger.info('Hit alive endpoint')
        res.send('Pong - Server is up and running');
    } catch (error) {
        logger.error(error)
        res.status(500).send('There was a problem handling the request')
    }
}
