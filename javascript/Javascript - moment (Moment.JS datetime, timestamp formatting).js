// ------------------------------------------------------------
// Javascript - moment (Moment.JS datetime, timestamp formatting)
// ------------------------------------------------------------

//
// moment (or moment.now)  -  Get current Datetime (equivalent to "new Date();" or "Date.now();")
//
moment();


//
// moment.add
//
moment().add(30,'minutes');


//
// moment.diff  -  Subtract from initial moment's datetime (e.g. "Get the difference between the two dates")
//
(moment().add(30,'minutes')).diff(moment(),'seconds');


//
// moment.format
//
moment().format('YYYY-MM-DD HH:mm:ss');


//
// moment.valueOf()  -  Get epoch seconds
//
moment("0000-01-01T00:00:00Z").valueOf();   // Returns "-62167219200000", the epoch seconds for the start of AD


// ------------------------------------------------------------
//
// Citation(s)
//
//   codesandbox.io  |  "moment-format-tester - CodeSandbox"  |  https://codesandbox.io/s/bzvc9?file=/src/App.js
//
//   momentjs.com  |  "Moment.js | Docs"  |  https://momentjs.com/docs/#/displaying/format/
//
// ------------------------------------------------------------