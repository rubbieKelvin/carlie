// .pragma library

const isnone = (value) => (value === null || value === undefined);
const validatenullity = (value, placeholder) => {
    if (isnone(value)) return placeholder;
    else return value;
};

class DateTime extends Date{

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

const getweekdata = () => {
    function dummydata (){
        let freq = Random.random(6);
        let result = [];

        for (let i=0; i<freq; i++) {
            let $from = Random.random(18);
            let $to = $from+Random.random(5);

            let $min1 = Random.random(59);
            let $min2 = Random.random(59);

            result = [...result, {
                from: new DateTime(0, 0, 0, $from, $min1),
                to: new DateTime(0, 0, 0, $to, $min2)
            }];
            
        }

        return result;
    }

    let result =  [
        {title:"Monday", data: dummydata()},
        {title:"Tuesday", data: dummydata()},
        {title:"Wednesday", data: dummydata()},
        {title:"Thursday", data: dummydata()},
        {title:"Friday", data: dummydata()},
        {title:"Saturday", data: dummydata()},
        {title:"Sunday", data: dummydata()},
    ];

    // console.log(JSON.stringify(result));
    return result;
}