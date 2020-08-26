// .pragma library

const inrange = (i, start, stop) => start <= i && i <= stop;
const isnone = value => value === null || value === undefined;

const mintime = (date1, date2) => {
    if (date1.getHours() < date2.getHours()){
        return date1;
    }else if (date1.getHours() === date2.getHours()){
        if (date1.getMinutes() < date2.getMinutes()){
            return date1;
        }else if(date1.getMinutes() < date2.getMinutes()){
            return null;
        }else{
            return date2;
        }
    }else{
        return date2;
    }
};

const maxtime = (date1, date2) => {
    if (date1.getHours() > date2.getHours()){
        return date1;
    }else if (date1.getHours() === date2.getHours()){
        if (date1.getMinutes() > date2.getMinutes()){
            return date1;
        }else if(date1.getMinutes() > date2.getMinutes()){
            return null;
        }else{
            return date2;
        }
    }else{
        return date2;
    }
};

const range = (from, to) => {
    let result = [];
    for (let i=from; i<to; i++) {
        result = [...result, i];
    }
    return result;
}

const validatenullity = (value, placeholder) => {
    if (isnone(value)) return placeholder;
    else return value;
};

class DateTime extends Date{

    static to12Hour(hr){
        if (hr===0) return 12;
        else return hr%12;
    }

    copy(){
        let _ = this.toJSON();
        return new DateTime(_);
    }

    dayString(short){
        let days;
        if (isnone(short)){
            days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        }else{
            days = ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"];
        }
        return days[this.getDay()];
    }

    setFrom12Hours(hr, am){
        if (am && hr===12) hr=0;
        else if (!am && hr<12) hr+=12;
        this.setHours(hr);
    }

    toJSONObject(){
        return {
            year: this.getFullYear(),
            month: this.getMonth(),
            day: this.getDay(),
            date: this.getDate(),
            hour: this.getHours(),
            minute: this.getMinutes(),
            seconds: this.getSeconds(),
            milliseconds: this.getMilliseconds()
        };
    }

    toLocaleTimeString(){
        let string = super.toLocaleTimeString();
        return string.slice(0, -4);
    }

    timeDelta(datetime){
        /**
         * Performs arithemetics on DateTime objects
         * @param {DateTime} datetime - datatime object
         * @return {DateTime}
         */
        if (typeof datetime !== DateTime) return;
        
        let result = new DateTime();
        let milldelta = this-datetime;
        result.setMilliseconds(milldelta);
        return result;
    }

}

class DateRange{
    /**
     * Stores data for date ranges
     * @param {DateTime} from 
     * @param {DateTime} to 
     */
    constructor(from, to){
        this.from = from;
        this.to   = to;
    }

    toString(){
        return this.from.toJSON()+" - "+this.to.toJSON();
    }

    elapseByTime(datetime){
        
        // normalize hour and minute to a float
        let norm = (date) => {
            return date.getHours() + (date.getMinutes() / 100);
        }

        return inrange(
            norm(this.from),
            norm(datetime.from),
            norm(datetime.to)
        ) || inrange(
            norm(this.to),
            norm(datetime.from),
            norm(datetime.to)
        ) 
    }

    /**
     * Checks if the date overlaps any of the ranges in the array
     * @param {Array} array 
     * @returns {Boolean}
     */

    elapseAnyByTime(array){

        for (let i = 0; i < array.length; i++) {
            const element = array[i];
            let res = this.elapseByTime(element);
            if (res) {
                return true;
            }
            
        }
        return false;
    }

    toJSON(){
        let result = {};
        result.from = this.from;
        result.to = this.to;
        return result;
    }
}

const style = {
    primary_a: "#A953FF",
    primary_b: "#E1A0FF",
    primary_c: "#BC0EF9",

    text_a: "#3D2742",
    text_b: "#C39CCD",

    light: "#FDF3FF",

    orange: "#FEC25A",
    blue:   "#538FFF",
    red:    "#FF7976",
    green:  "#6FCF97",
    purple: "#9B51E0",
    grey:   "#828282"
};

const Random = {
    choice(arr){
        return arr[Math.floor(Math.random() * arr.length)];
    },

    random(max){
        max = (max === undefined) ? 10:max;
        return Math.floor(Math.random() * max);
    }
};

const randomcolor = () => {
    let color = [
        style.orange,
        style.blue,
        style.red,
        style.green,
        style.purple,
        style.grey
    ];
    
    return Random.choice(color);
};

// test
function test(){
    var passed = 0;
    var failed = 0;

    function assert(value){
        if (!value) failed += 1;
        else passed += 1;
    }

    function test_number_range(){
        let x1 = 1;
        let x2 = 10;

        assert(inrange(2, x1, x2))
        assert(inrange(5, x1, x2))
        assert(inrange(6, x1, x2))
        assert(!inrange(11, x1, x2))
        assert(!inrange(20, x1, x2))
    }

    console.log("TESTING...");
    test_number_range();
    console.log(`PASSED: ${passed} \nFAILED: ${failed}`);
}

// test();