// logic.mjs
/*  In (number): milliseconds
    Out (string): input converted to hours, minutes, seconds (hh.mm.ss)
*/
export function formatMilliSecondsToTimeString(msec) {

    if (msec < 0) {
        return "0 s"
    }

    let allSeconds = Math.floor(msec * 0.001)
    let hour = 0
    let min = 0
    let sec = 0
    let hStr = "0"
    let mStr = "0"
    let sStr = "0"

    sec = allSeconds % 60
    allSeconds = allSeconds - sec
    min = allSeconds % 3600
    allSeconds = allSeconds - min
    hour = allSeconds % 363600 // display 0 ... 101 h

    if (hour > 0) {
        hStr = (hour / 3600).toString()
    }

    if (min > 0) {
        mStr = (min / 60).toString()
    }

    if (sec > 0) {
        sStr = sec.toString()
    }

    hStr = prependZeroString(hStr)
    mStr = prependZeroString(mStr)
    sStr = prependZeroString(sStr)

    let out = hStr + "." + mStr + "." + sStr

    return out
}


function prependZeroString (input) {
    if(input.length < 2) {
        return "0" + input
    }
    else return input

}

/* In: (string) hour, min, sec
    Out: (number) msec */
export function timeToMilliseconds(hour = 0, min = 0, sec = 0) {
    let msec = 0
    msec = hour * 3.6e6 + min * 6e4 + sec * 1000

    return msec
}

/* In: compId (id of component with text field that has numbers), delta (number to add)  */
export function addNumberToTextField(compId, delta) {

    if(compId.text.length < 1) {
        compId.text = "00"
    }

    let temp
    try {
        temp = Number.parseInt(compId.text)
    }
    catch(e){
        console.log(e)
        return
    }

    temp = temp + delta

    if(temp > 99 || temp < 0) {
        return
    }

    if(Number.isNaN(temp)) {
        temp = 0
    }

    compId.text = temp.toString()
}

export function stopAlarm (Backend) {
    Backend.stopCounting() //cancel upcoming alarm
    Backend.alarm = false // stop current alarm
}
