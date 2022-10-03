/**
 * This function make estimate Aparent Energy Value
 * doing avg of Aparent Power (Ssum) x 0.016 to take the result in Watts per hour
 * Delta Time is every minute so 60 s / 3600 s -> 0.016 hs
 * @input {metrics key}
 * @returns {Energy Value} Value of Energy in 1 minute
 */
function estimateAparentEnergyValue(metrics) {
    const { Ssum } = metrics;
    return (Ssum.avgvalue * 0.016 )
 }
/**
 * This function make estimate Active Energy Value
 * doing avg of Active Power (Psum) x 0.016 to take the result in Watts per hour
 * Delta Time is every minute so 60 s / 3600 s -> 0.016 hs
 * @input {metrics key}
 * @returns {Energy Value} Value of Energy in 1 minute
 */
function estimateEnergyValue(metrics) {
   const { Psum } = metrics;
   return (Psum.avgvalue * 0.016)
}

/**
 * Just in case Psum is null we can estimate like sum of Active Power in each Phase.
 * @input {metrics key}
 * @returns {Psum} 
 */
function estimatePsum(metrics){
    const { P1, P2, P3 } = metrics;
    
    const Psum = {
        avgvalue: P1.avgvalue + P2.avgvalue + P3.avgvalue,
        maxvalue: P1.maxvalue + P2.maxvalue + P3.maxvalue,
        minvalue: P1.minvalue + P2.minvalue + P3.minvalue,
    }
    return Psum
}

/**
 * This function check for data integrity, looking for (in this case) null data 
 * in Psum, Engy, and apparentEngy keys.
 * If detect anyone, we call funtions to estimate these values with the rest of the data.
 * Then, we order data from old data to new data taking tots key in object.
 * @input {data}
 * @returns {CleanData} Get clean data to make analisys.
 */
exports.checkNullDataAndConvertTime = (data) => {
    
    data.forEach((measure, index, dataArr) => {
       
        const {metrics, fromts, tots} = measure;
    

        if (metrics.Psum == null){
            
            metrics.Psum = estimatePsum(metrics)
        }
        
        if (metrics.engy == null){
            engyAvgValue = estimateEnergyValue(metrics)

            const latestEnergyValue = (index !== 0)
                                        ? dataArr[index - 1].metrics.engy.avgvalue
                                        : 0
            
            data[index].metrics['engy'] = {
                    avgvalue: latestEnergyValue + engyAvgValue,
                    maxvalue: latestEnergyValue + engyAvgValue,
                    minvalue: latestEnergyValue + engyAvgValue
            }

            measure.metrics.engy
        }

        if (metrics.apparentEngy == null){
            appEngyAvgValue = estimateAparentEnergyValue(metrics)
            const latestApEnergyValue = (index !== 0)
                                        ? dataArr[index - 1].metrics.apparentEngy.avgvalue
                                        : 0
            

            data[index].metrics['apparentEngy'] = {
                avgvalue: latestApEnergyValue + appEngyAvgValue,
                maxvalue: latestApEnergyValue + appEngyAvgValue,
                minvalue: latestApEnergyValue + appEngyAvgValue
            }
        }


    });
    data.sort((current,pos) => (current.tots-pos.tots))
    return data;
}

/**
 * This function get avg of Psum (taking max value in each measure) from all data, 
 * this will be our max reach value to estimate IDLE and INACTIVE modes.
 * @input {data}
 * @returns {Psum Avg} Average of all Psum maxvalue in each measure.
 */
exports.getPmax = (data) => {

    let pMax = 0
    data.forEach((measure, index, dataArr) => {
        const {metrics} = measure;
        pMax += metrics.Psum.maxvalue
    });
    return (pMax/(data.length));
}