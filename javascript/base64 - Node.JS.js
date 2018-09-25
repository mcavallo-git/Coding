
// Encode to Base 64
console.log(Buffer.from("Hello World").toString('base64'));
// SGVsbG8gV29ybGQ=

// Dencode from Base 64
console.log(Buffer.from("SGVsbG8gV29ybGQ=", 'base64').toString('ascii'));
// Hello World
