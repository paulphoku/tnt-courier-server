// This library handles errors and other problems by notifying the user.

/**
 * Handle a general error or failure.
 *
 * @param res - the result to push the error to
 * @param msg - the message to display or null for default
 * @param status - the status (default 500)
 */
function sendError (
	res,
	msg = "Something went wrong, please try again later.",
	status = 500
)
{
	console.log( msg );
	return res.status( status ).send( msg );
}

// Exports
module.exports = {
	sendError
};
