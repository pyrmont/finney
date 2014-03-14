# Finney README

Finney is a simple Node.js script that modifies an arbitrary array of podcast feeds based on regular expressions and saves each modified pocast as a separate file.

The array of podcast feeds is read from a file called ```feeds.json```. An example file is included in ```feeds.json.example```. Each object in the array must be defined in the following manner:

```javascript
{
    "uri": "{podcast_uri}";
    "slug": "{output_slug}";
    "match": "{regular_expression}";
}
```

Finney will iterate over each item in the podcast feed. It removes any items that match the regular expression provided.

## Requirements

Finney requires [Node.js](http://nodejs.org/) to be installed on your system.

## Installation

```bash
git clone git://github.com/pyrmont/finney.git  # Warning: read-only.
cd finney
npm install
```

Once you have installed Finney, you will need to do the following:

1. create an ```output``` directory; and
2. create a ```feeds.json``` file containing an array of podcast feeds to be modified.

Each modified feed is saved as ```{slug}.xml``` using the slug specified in the feeds.json file for that particular feed.

## Licence

Original work is placed in the public domain and all rights are disclaimed.