// logic.mjs
/*  In: milliseconds
    Out (String):  remaining hours, minutes, seconds
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
    hour = allSeconds % 216000

    if (hour > 0) {
        hStr = (hour / 3600).toString()
    }

    if (min > 0) {
        mStr = (min / 60).toString()
    }

    if (sec > 0) {
        sStr = sec.toString()
    }

    let out = hStr + "." + mStr + "." + sStr

    return out
}
