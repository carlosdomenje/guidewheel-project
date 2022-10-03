const {readCSVData} = require('../../../config/db.config');


describe('db-config functions', () =>{
    it('Should have readCSV function', () =>{
        expect(readCSVData).toBeDefined();
    });
})