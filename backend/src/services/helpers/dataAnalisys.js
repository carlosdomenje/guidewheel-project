
function estimateAparentEnergyValue(metrics) {
    const { Ssum } = metrics;
    return (Ssum.avgvalue * 0.016 )
 }

function estimateEnergyValue(metrics) {
   const { Psum } = metrics;
   return (Psum.avgvalue * 0.016)
}

function estimatePsum(metrics){
    const { P1, P2, P3 } = metrics;
    
    const Psum = {
        avgvalue: P1.avgvalue + P2.avgvalue + P3.avgvalue,
        maxvalue: P1.maxvalue + P2.maxvalue + P3.maxvalue,
        minvalue: P1.minvalue + P2.minvalue + P3.minvalue,
    }
    return Psum
}

exports.checkNullDataAndConvertTime = (data) => {
    
    data.forEach((measure, index, dataArr) => {
       
        const {metrics, fromts, tots} = measure;
        
        //dataArr[index].fromts = new Date(parseInt(fromts))
        //dataArr[index].tots = new Date(parseInt(tots))
                             

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

exports.getPmax = (data) => {

    let pMax = 0
    data.forEach((measure, index, dataArr) => {
        const {metrics} = measure;
        pMax += metrics.Psum.maxvalue
    });
    return (pMax/(data.length));
}