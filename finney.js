var request = require('request');
var cheerio = require('cheerio');
var fs = require('fs');
var feeds = require('./feeds.json');

feeds.forEach(function(feed) {
    request(feed.uri, function(error, response, body) {
    
        if (!error && response.statusCode == 200) {
            var $ = cheerio.load(body, { xmlMode: true });
            var match = new RegExp(feed.match);
            
            $('item').each(function(i, elem) {
                if (match.test($(this).find('title').text())) {
                    $(this).remove();
                }
            });
            
            var xml = $.xml();
            var path = __dirname;
            fs.writeFile(path + '/output/' + feed.slug + '.xml', xml);
        }
    
    });
});