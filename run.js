// Simple node app that reads a file for today's date, and tweets the results
var fs = require('fs');
var Twit = require('twit');
var T = new Twit({
  consumer_key:         process.env.T_CONSUMER_KEY,
  consumer_secret:      process.env.T_CONSUMER_SECRET,
  access_token:         process.env.T_ACCESS_TOKEN,
  access_token_secret:  process.env.T_ACCESS_TOKEN_SECRET,
  timeout_ms:           60*1000,  // optional HTTP request timeout to apply to all requests. 
})

// get the date, and read the file for today
var today = new Date();
var day = (today.getDate()-1);
var month = (today.getMonth()+1);
var year = today.getFullYear();
var dataFromFile =  process.env.WEBROOT_PATH + "\\output\\" + month + "-" + day + ".txt";

// if there's a file today, tweet it
fs.readFile(dataFromFile, 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
    //sometimes there's junk at the end of the line. Replace it. 
    data = data.replace(/(\n|\r)+$/, '');
    //count len on data - if it's >140, we need to split into multiple tweets. wil split at 134 so we can prepend, append etc
    var dataLength = data.length;
    splitter(data, 136);
    
    console.log("String 1 %s", strs[0]);
    console.log("String 2 %s", strs[1]);
    console.log(dataLength, data);
    
    // T.post('statuses/update', { status: data }, function(err, data, response) {
    //console.log(data)
    //})
});

function chomp(raw_text)
{
  return raw_text.replace(/(\n|\r)+$/, '');
}

// thanks StackOverflow, https://stackoverflow.com/questions/7624713/js-splitting-a-long-string-into-strings-with-char-limit-while-avoiding-splittin
function splitter(str, l){
    strs = [];
    while(str.length > l){
        var pos = str.substring(0, l).lastIndexOf(',');
        pos = pos <= 0 ? l : pos;
        strs.push(str.substring(0, pos));
        var i = str.indexOf(' ', pos)+1;
        if(i < pos || i > pos+l)
            i = pos;
        str = str.substring(i);
    }
    strs.push(str);
/*    console.log(strs[0]);
    console.log(strs[1]);*/
    return strs;
}