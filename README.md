# Finney

Finney consists of two scripts, one written in Node.js and the other in Ruby. Both scripts are utilities for creating podcast feeds.

## Overview

### Node.js

The Node.js script modifies an arbitrary array of existing podcast feeds based on regular expressions and saves each modified pocast as a separate file.

The array of podcast feeds is read from a file called `feeds.json`. An example file is included in `feeds.json.example`. Each object in the array must be defined in the following manner:

```javascript
{
    "uri": "{podcast_uri}";
    "slug": "{output_slug}";
    "match": "{regular_expression}";
}
```

The script will iterate over each item in the podcast feed. It removes any items that match the regular expression provided and the resulting feed is saved to `output`.

### Ruby

The Ruby script generates a new podcast feed in respect of a directory of audio files (either `.mp3` or `.m4a`).

The script requires that a YAML file setting out the configuration options be in the same directory as the files. An example file is included in `config.yaml.example`. The YAML file has the following format:

```yaml
title: "My Podcast"
description: "The description of my podcast."
summary: "A summary of my podcast"
image: "http://www.example.com/artwork.jpg"
feed: "my_podcast.rss"
url_base: "http://www.example.com"
```

The resulting feed is saved to `output`.

## Requirements

Depending on the scripts you wish to run, Finney requires either or both of [Node.js](http://nodejs.org/) and [Ruby](http://ruby-lang.org) to be installed on your system.

## Installation

```bash
git clone git://github.com/pyrmont/finney.git  # Warning: read-only.
cd finney

npm install # If you want to use the Node.js script.
bundle install # If you want to use the Ruby script.

mkdir output
```

If you use [rbenv](https://github.com/sstephenson/rbenv), you can target the Ruby version appropriate for your system by editing `.ruby-version`.

## Running

Once you have installed Finney, you can run the respective scripts as follows.

### Node.js

* create a `feeds.json` file containing an array of podcast feeds to be modified
* run `node finney.js`

### Ruby

* create a directory containing the audio files
* run `bundle exec ruby finney.rb /path/to/directory/with/audio/files/config.yaml`

It is recommended that the directory with the audio files is placed in the `output` directory. You should then make this directory publicly accessible via your web server.

## Copyright

Original work is placed in the [public domain](http://creativecommons.org/publicdomain/zero/1.0/).