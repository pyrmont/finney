# Based on https://gist.github.com/sjschultze/0077238e90b13a23e678

require 'date'
require 'yaml'
require 'audioinfo'

abort "Please enter the path to config.yaml as the first argument." unless config_file = ARGV[0]

# Load YAML file.
config = YAML.load_file config_file

# Location of files.
files_dir = File.expand_path(File.dirname(config_file))

# Config values
podcast_title = config['title']
podcast_description = config['description']
podcast_file = 'output/' + config['feed']
public_url_base = config['url_base']

# Generated values
date_format = '%a, %d %b %Y %H:%M:%S %z'
podcast_pub_date = DateTime.now.strftime(date_format)

# Build the items
items_content = ""
Dir.entries(files_dir).each do |file|
    next if file =~ /^\./  # ignore invisible files
    next unless file =~ /\.(mp3|m4a)$/  # only use audio files

    puts "Adding file: #{file}"

    file_full_path = files_dir + '/' + file

    item_size_in_bytes = File.size(file_full_path).to_s
    item_pub_date = File.mtime(file_full_path).strftime(date_format)

    info = AudioInfo.open(file_full_path)

    item_title = info.title
    item_subtitle = info.artist
    item_summary = info.album

    item_url = "#{public_url_base}/#{file}"
    item_content = <<-HTML
        <item>
            <title>#{item_title}</title>
            <itunes:subtitle>#{item_subtitle}</itunes:subtitle>
            <itunes:summary>#{item_summary}</itunes:summary>
            <enclosure url="#{item_url}" length="#{item_size_in_bytes}" type="audio/mpeg" />
            <pubDate>#{item_pub_date}</pubDate>
            <guid>#{item_url}</guid>
        </item>
HTML

    items_content << item_content
end

# Build the whole file
content = <<-HTML
<?xml version="1.0" encoding="ISO-8859-1"?>
<rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">
    <channel>
        <title>#{podcast_title}</title>
        <description>#{podcast_description}</description>
        <pubDate>#{podcast_pub_date}</pubDate>
#{items_content}
    </channel>
</rss>
HTML

# write it out
output_file = File.new(podcast_file, 'w')
output_file.write(content)
output_file.close