const { Router } = require ('express');
const router = Router();

const { getUnloadedMachineData, 
        getInactiveMachineData,
        getLoadedMachineData,
        getAllMachineData 
    } = require ('../controllers/panel.controller');

router.get('/unloaded-data', getUnloadedMachineData);
router.get('/inactive-data', getInactiveMachineData);
router.get('/active-data', getLoadedMachineData);
router.get('/all-data', getAllMachineData);
module.exports = router;
