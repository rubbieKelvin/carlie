.pragma library


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

// checks if a number is in-between 2 numbers
const inrange = (i, start, stop) => start <= i && i <= stop;

const isnone = value => value === null || value === undefined;


/**
 * returns the date with the smallest time, irrespective of the year, month and day
 * @param {Date} date1 
 * @param {Date} date2
 * @returns Date 
 */
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


/**
 * returns the date with the biggest time, irrespective of the year, month and day
 * @param {Date} date1 
 * @param {Date} date2
 * @returns Date
 */
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


/**
 * returns a list of numbers beginning with `from` and ending with to-1
 * @param {Number} from 
 * @param {Number} to
 * @returns Array
 */
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

const date = (dateobj) => {
    if (typeof dateobj === "string") return new DateTime(dateobj);
    else return dateobj;
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
        let norm = (d) => {
            return date(d).getHours() + (date(d).getMinutes() / 100);
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
        todos: {},
        activities: []
    },

    carlie: {},     // carlie is a python object, so in this js file its empty, carlieqml > core.py > Carlie

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
        let now = new Date();


        // you cannot edit the past
        if (now>date) return null;


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
            this.carlie.savejson(
                JSON.stringify(this.data)
            );
            
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
        let now = new Date();

        // you cannot edit the past
        if ((now.getFullYear() === date.getFullYear())  && (now.getMonth() === date.getMonth()) && (now.getDate() === date.getDate())){
            if (now.getHours() > payload.timerange.from.getHours()){
                return null;
            }else if (now.getHours() === payload.timerange.from.getHours()){
                if (now.getMinutes() > payload.timerange.from.getMinutes()){
                    return null;
                }
            }
        }else if (now>date) {
            return null
        }


        if (todo===undefined){
            return null;
        }else{
            // check for lapses

            let samples = this.gettodos(date, []).filter((i) => i.id !==id);
            let timerange = (payload.timerange===undefined)?todo.timerange:payload.timerange;

            if (!timerange.elapseAnyByTime(samples.map(
                (e) => e.timerange
            ))){
                todo.timerange = timerange;
                todo.activity = (payload.activity===undefined)?todo.activity:payload.activity;
                todo.text = (payload.text===undefined)?todo.text:payload.text;

                this.data.activities.push(payload.activity);
            }else{
                return false;
            }

        }
        this.carlie.savejson(
            JSON.stringify(this.data)
        );
        return true;
    },

    deleteTodo(id, date){
        let year = date.getFullYear();
        let month = date.getMonth();
        let day = date.getDate();

        let todo = this.gettodo(date, id);
        let now = new Date();

        // you cannot delete the past
        if ((now.getFullYear() === date.getFullYear())  && (now.getMonth() === date.getMonth()) && (now.getDate() === date.getDate())){
            if (now.getHours() > todo.timerange.from.getHours()){
                return null;
            }else if (now.getHours() === todo.timerange.from.getHours()){
                if (now.getMinutes() > todo.timerange.from.getMinutes()){
                    return null;
                }
            }
        }else if (now>date) {
            return null
        }

        if (this.data.todos[year] !== undefined){
            if (this.data.todos[year][month] !== undefined){
                if (this.data.todos[year][month][day] !== undefined){
                    this.data.todos[year][month][day] = this.data.todos[year][month][day].filter(i => i.id !== id);
                }
            }
        }

        this.carlie.savejson(
            JSON.stringify(this.data)
        );
    }
};