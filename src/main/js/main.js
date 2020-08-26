.pragma library

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

    static clone(date){
        if (typeof date === String){
            return new DateTime(date);
        }
        return new DateTime(date.toJSON());
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

const scheduler = {
    data: {
        todos: {

        }
    },

    /**
     * 
     * @param {Date} date 
     */
    createdatedataifnotexisting(date){
        let year = date.getFullYear();
        let month = date.getMonth();
        let day = date.getDate();

        if (this.data.todos[year] === undefined){
            this.data.todos[year] = {};
            this.data.todos[year][month] = {};
            this.data.todos[year][month][day] = [];
        }else if (this.data.todos[year][month] === undefined){
            this.data.todos[year][month] = {};
            this.data.todos[year][month][day] = [];
        }else if (this.data.todos[year][month][day] === undefined){
            this.data.todos[year][month][day] = [];
        }

        return this.data.todos[year][month][day];
    },
  
    /**
     * 
     * @param {Date} date 
     */
    newtodo(date, uuid){
        let daytodos = this.createdatedataifnotexisting(date);
        let schedule = {
            id: uuid,
            timerange: new DateRange(date, DateTime.clone(date)),
            activity: "New Todo",
            text: "",
            theme: randomcolor()
        };
        schedule.timerange.to.setMinutes(
            schedule.timerange.to.getMinutes() + 5
        );
        if (!schedule.timerange.elapseAnyByTime(daytodos.map(
            (e) => e.timerange
        ))){
            daytodos.push(schedule);
            return schedule;
        }else{
            return null;
        }
    },

    /**
     * 
     * @param {Date} date 
     */
    gettodos(date, placeholder){
        let year = date.getFullYear();
        let month = date.getMonth();
        let day = date.getDate();

        if (this.data.todos[year] !== undefined){
            if (this.data.todos[year][month] !== undefined){
                if (this.data.todos[year][month][day] !== undefined){
                     return this.data.todos[year][month][day];
                }
            }
        }

        return placeholder;
    },

    gettodo(date, id){
        return this.gettodos(date, []).filter((i) => i.id===id)[0];
    },

    /**
     * 
     * @param {String} id 
     * @param {Object} payload 
     */
    edittodo(id, date, payload){
        let todo = this.gettodo(date, id);
        if (todo===undefined){
            return null;
        }else{
            todo.timerange = (payload.timerange===undefined)?todo.timerange:payload.timerange;
            todo.activity = (payload.activity===undefined)?todo.activity:payload.activity;
            todo.text = (payload.text===undefined)?todo.text:payload.text;
        }
    }
};