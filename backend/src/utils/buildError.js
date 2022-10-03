
exports.buildError = (statusCode, error) => {

    const message = error.message || error
    const stack = error.stack || message

    return Object.assign(new Error(message), {statusCode, stack})
}
