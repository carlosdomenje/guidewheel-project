const dbService = require('../../../services/db.service');


describe('db-services functions', () =>{
    it('Should have estimateUnloadedData function', () =>{
        expect(dbService.estimateUnloadedData).toBeDefined();
    });
    it('Should have estimateInactiveData function', () =>{
        expect(dbService.estimateInactiveData).toBeDefined();
    });
    it('Should have estimateLoadedData function', () =>{
        expect(dbService.estimateLoadedData).toBeDefined();
    });
    it('Should have getAllClearData function', () =>{
        expect(dbService.getAllClearData).toBeDefined();
    });

})