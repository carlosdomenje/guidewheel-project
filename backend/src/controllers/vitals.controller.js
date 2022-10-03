const { logger } = require ('../utils/logger');

exports.welcome = (req, res, next) => {
    try {
        res.send('Hello World - GuideWheel');
    } catch (error) {
        logger.error(error);
        res.status(500).send('There was a problem handling the request');
    }
}

exports.alive = (req, res, next) => {
    try {
        logger.info('Hit alive endpoint')
        res.send('Pong - Server is up and running');
    } catch (error) {
        logger.error(error)
        res.status(500).send('There was a problem handling the request')
    }
}
