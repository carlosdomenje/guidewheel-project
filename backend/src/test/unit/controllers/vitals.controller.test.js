const vitalsController = require('../../../controllers/vitals.controller');


describe('vitals-controller functions', () =>{
    it('Should have welcome function', () =>{
        expect(vitalsController.welcome).toBeDefined();
    });
    it('Should have alive function', () =>{
        expect(vitalsController.alive).toBeDefined();
    });

})