const { logger } = require ('../utils/logger');
const { readCSVData } = require ('../config/db.config');
const { checkNullDataAndConvertTime, getPmax  } = require ('./helpers/dataAnalisys');


/**
 * This function make the estimation of Unloaded state of the machine
 * just in case we need all the reports.
 * This function returns a object with the time that was in this state,
 * and the threshold data taking 100 mA for filter.
 * @input {data} clean data from dataset.
 * @returns {Object} {unloadTime, unloadThreshold, unloadData}
 */
exports.estimateUnloadedData = (data) =>{

    //const clearData = checkNullDataAndConvertTime(data);
    // Filter all data that is greater than 100 mA.
    const unloadData = data.filter((data) => {
        const { avgvalue } = data.metrics.Iavg
        return (avgvalue < 100)
    })
    const unloadTime = unloadData.length;
    const {Vlnavg, PFavg} = unloadData[0].metrics
    // Convert value to minumun Active Power to standardize values. 
    const unloadThreshold = 0.1 * Vlnavg.minvalue * PFavg.minvalue;
    return {unloadTime, unloadThreshold, unloadData}
   
}

/**
 * This function make the estimation of Inactive state of the machine
 * just in case we need all the reports.
 * This function returns a object with the time that was in this state,
 * and the threshold data taking 20% of Psum Avg in all data.
 * @input {data} clean data from dataset.
 * @returns {Object} {idleTime,idleThreshold,inactiveData}
 */
exports.estimateInactiveData = (data) =>{
    const maxP = getPmax(data)

    const inactiveData = data.filter((data) => {
        const { Psum, Iavg } = data.metrics
        return (Psum.avgvalue <= (maxP*0.2) && Iavg.avgvalue > 0.1)
    })
    const idleTime = inactiveData.length;
    const idleThreshold = maxP*0.2;
    
    return {idleTime,idleThreshold,inactiveData}
}
/**
 * This function make the estimation of Loaded state of the machine
 * just in case we need all the reports. We take all values upper of 
 * 20% of Psum avg of all data.
 * @input {data} clean data from dataset.
 * @returns {loadedData} 
 */
exports.estimateLoadedData = (data) =>{

    const clearData = checkNullDataAndConvertTime(data);

    const maxP = getPmax(data)
    
    const loadedData = clearData.filter((data) => {
        const { avgvalue } = data.metrics.Psum
        return (avgvalue > (maxP*0.2))
    })
    return loadedData
}

/**
 * This function prepare data to make posterior analisys of it
 * @input {data} data to clean for post process
 * @returns {clearData} {idleTime,idleThreshold,inactiveData}
 */
exports.getAllClearData = (data) =>{
    const clearData = checkNullDataAndConvertTime(data);
    return clearData
}

