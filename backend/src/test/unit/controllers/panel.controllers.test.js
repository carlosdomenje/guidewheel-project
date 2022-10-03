const panelController = require('../../../controllers/panel.controller');


describe('vitals-controller functions', () =>{
    it('Should have getAllMachineData function', () =>{
        expect(panelController.getAllMachineData).toBeDefined();
    });
    it('Should have getUnloadedMachineData function', () =>{
        expect(panelController.getUnloadedMachineData).toBeDefined();
    });
    it('Should have getInactiveMachineData function', () =>{
        expect(panelController.getInactiveMachineData).toBeDefined();
    });
    it('Should have getLoadedMachineData function', () =>{
        expect(panelController.getLoadedMachineData).toBeDefined();
    });

})