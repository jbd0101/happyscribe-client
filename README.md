# Happyscribe client for Ruby
This is a very basic NON-OFFICIAL gem based on the happyscribes api (https://dev.happyscribe.co/). It works out of the box and makes the usage of the api much easier ;-)

## dependencies
because no one love to have 10k of dependencies, this gem uses only: net/http,uri,json and securerandom. so do not worry about the size of the gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'happyscribe'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install happyscribe

## Usage

do not forget to require the gem :
```ruby
require "happyscribe"

```

### nota bene
all the functions sends you back a parsed json (array) with the response of the api.

### some Ruby please !
create an instance:
```ruby
instance = Happyscribe::Transcript.new(my_api_token)
```

#### API
create a transcription.  you can use all of the avaiable language codes (https://dev.happyscribe.co/#languages)
```ruby
instance.create(public_url_to_audio,"fr-FR")
```
Good to know: if you are working with ActiveStorage, you can create a public_url with url_for()

retrieve all the transcriptions
```ruby
instance.list
```
retrieve all a transcription
```ruby
instance.retrieve(transcription_id)
```
create an export
```ruby
instance.create_export(transcription_id, format,show_speakers,show_comments,show_highlights)
# by default, format="txt", show_speakers,show_comments,... = false
# so you can just do
instance.create_export(transcription_id, format)
```

retrieve an export
```ruby
instance.retrieve_export(export_id)
```

#### Magic functions
because everyone just one to have a string with the transcription, there is a function that creates the export, retrieve the export when it's ready, download the attachment and return it in utf-8.

```ruby
instance.export_in_txt(transcription_id)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jbd0101/happyscribe. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

The MIT License (MIT)

Copyright (c) 2020 jean-christophe bauduin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
