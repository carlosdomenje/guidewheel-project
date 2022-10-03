const { logger } = require ('../utils/logger');
const { readCSVData } = require ('../config/db.config');
const { checkNullDataAndConvertTime, getPmax  } = require ('./helpers/dataAnalisys');

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


exports.estimateInactiveData = (data) =>{

    //const clearData = checkNullDataAndConvertTime(data);

    const maxP = getPmax(data)

    const inactiveData = data.filter((data) => {
        const { Psum, Iavg } = data.metrics
        return (Psum.avgvalue <= (maxP*0.2) && Iavg.avgvalue > 0.1)
    })
    const idleTime = inactiveData.length;
    const idleThreshold = maxP*0.2;
    
    return {idleTime,idleThreshold,inactiveData}
}

exports.estimateLoadedData = (data) =>{

    const clearData = checkNullDataAndConvertTime(data);

    const maxP = getPmax(data)
    
    const loadedData = clearData.filter((data) => {
        const { avgvalue } = data.metrics.Psum
        return (avgvalue > (maxP*0.2))
    })
    return loadedData
}

exports.getAllClearData = (data) =>{
    const clearData = checkNullDataAndConvertTime(data);

    return clearData
}

