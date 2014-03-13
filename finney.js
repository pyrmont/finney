var request = require('request');
var cheerio = require('cheerio');
var fs = require('fs');

var feeds = [
    { uri: 'http://www.nhk.or.jp/r-news/podcast/nhkradionews.xml', slug: 'nhkradionews_j', match: '朝' },
    { uri: 'http://www.nhk.or.jp/rj/podcast/rss/english.xml', slug: 'nhkradionews_e', match: '21:' },
]

feeds.forEach(function(feed) {
    request(feed.uri, function(error, response, body) {
    
        if (!error && response.statusCode == 200) {
            var $ = cheerio.load(body, { xmlMode: true });
            
            $('item').each(function(i, elem) {
                if ($(this).find('title').text().indexOf(feed.match) == -1) {
                    $(this).remove();
                }
            });
            
            var xml = $.xml();
            var path = __dirname;
            fs.writeFile(path . '/output/' + feed.slug + '.xml', xml);
        }
    
    });
});