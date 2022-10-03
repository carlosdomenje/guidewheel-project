const dbHelp = require('../../../services/helpers/dataAnalisys');


describe('db-helpers functions', () =>{
    it('Should have checkNullDataAndConvertTime function', () =>{
        expect(dbHelp.checkNullDataAndConvertTime).toBeDefined();
    });
    it('Should have getPmax function', () =>{
        expect(dbHelp.getPmax).toBeDefined();
    });
})