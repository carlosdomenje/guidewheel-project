
const { logger } = require ('../utils/logger');
const { readCSVData } = require ('../config/db.config');
const { estimateUnloadedData, 
        estimateInactiveData,
        estimateLoadedData,
        getAllClearData,
        
    } = require ('../services/db.service');


/**
 * Get Machine Data
 * 
 * @returns {data} response with code 200 and all data needed for analisys.
 */
exports.getAllMachineData = async (req,res) => {
    try {
        
        const measures = await readCSVData();
        const allData = await getAllClearData(measures);
        const {idleTime,idleThreshold} =  estimateInactiveData(allData) 
        const {unloadTime,unloadThreshold} =  estimateUnloadedData(allData)
        res.status(200).json({
            total: allData.length, 
            idleTime: idleTime,
            idleThreshold:idleThreshold,
            unloadTime:unloadTime,
            unloadThreshold:unloadThreshold,
            data:allData,
        })
    } catch (error) {
        res.status(500).json({
            message: 'Server Error'
        })
    }
    
}    

/**
 * Get Unload Data from Machine
 * 
 * @returns {data} response with code 200 and all data needed for analisys.
 */
exports.getUnloadedMachineData = async (req,res) => {
    try {
        measures = await readCSVData();
        const allData = await getAllClearData(measures);
        unloadedData =  estimateUnloadedData(allData);
    
        res.status(200).json({
            total: unloadedData.length,
            data: unloadedData
        })
    } catch (error) {
        res.status(500).json({
            message: 'Server Error'
        })
    }
   
}
/**
 * Get Inactive Data from Machine
 * 
 * @returns {data} response with code 200 and all data needed for analisys.
 */
exports.getInactiveMachineData = async (req,res) => {

    try {
        measures = await readCSVData();
        const allData = await getAllClearData(measures);
        inactiveData = estimateInactiveData(allData);
        
        res.status(200).json({
            total: inactiveData.length,
            data: inactiveData
        })
    } catch (error) {
        res.status(500).json({
            message: 'Server Error'
        })
    }
    


}

/**
 * Get Load Data from Machine
 * 
 * @returns {data} response with code 200 and all data needed for analisys.
 */
exports.getLoadedMachineData = async (req,res) => {

    try {
        measures = await readCSVData();
        const allData = await getAllClearData(measures);
        loadedData = await estimateLoadedData(allData);
        
        res.status(200).json({
            total: loadedData.length,
            data: loadedData
        })
    } catch (error) {
        res.status(500).json({
            message: 'Server Error'
        })
    }
    
}