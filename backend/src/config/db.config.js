const { createReadStream } = require ('fs');
const { resolve } = require ('path');
const { format, parse } = require ('fast-csv');
const csvStream = format({ headers: false });
const logger = require ('../utils/logger');

const { array } = require ('get-stream');

/**
 * Read CSV data. Simulates data readed from DB
 * 
 * @returns {data} response with a json object with measures information.
 */
exports.readCSVData = async () => {
    try {
        const parseStream = parse({ headers: true });
        const data = await array(createReadStream(resolve(__dirname, '../assets', 'demoPumpDayData.csv'))
                                            .pipe(parseStream));
     
        const dataJson = data.map((data) => ({...data, metrics: JSON.parse(data.metrics)}))
        return dataJson
    } catch (error) {
        console.log(error);
    }
  
}
