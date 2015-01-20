[![Build Status](https://secure.travis-ci.org/turhn/personal_wordlist.png)](http://travis-ci.org/turhn/personal_wordlist)

# personal_wordlist

**personal_wordlist** is a wordlist generator backend to create wordlists from the given personal data. It is originally designed for security purposes.

personal_wordlist uses a simple DSL to create password patterns and those patterns are used to create password sequences.

## Installation

```shell
gem install personal_wordlist
```
or add the following line to Gemfile:

```ruby
gem 'personal_wordlist'
```
and run `bundle install` from your shell.

## Usage

To start generating wordlists we need to use ```PersonalWordlist.generate``` method with a block.

```ruby
PersonalWordlist.generate(personal_data) do
  # DSL here
end

```

```.generate``` method takes a Hash argument and returns and Array of strings.

### Partials

```partial``` is a string pattern and can be used to combine more complex strings.

```ruby
partial { first_name[0..1] }
partial '123' # You can also use string arguments
partial { last_name[0].downcase }
```
Consider the data is ```{ first_name: 'John', last_name: 'Doe' }``` and the result will be _Jo123d_.

### Sequences

```sequence```s are like loops in programming languages. sequence method requires a ```Range``` variable and a block.

```ruby
sequence(1998..2011) do |n|
  # string manupulation here
end
```

You can insert partials into sequences.

```ruby
sequence(1998..2011) do |n|
  partial { first_name.downcase }
  partial { n.to_s }
end
```
And result becomes: _['john1998', 'john1999', 'john2000', ... 'john2011']_

When sequence is done iterating, the result is added to the returning array of strings. If you have multiple sequences, the results from each sequence will be concatenated.

### Example
```ruby
personal_data = { 
	first_name: 'John', last_name: 'Doe', 
	date_of_birth: '1980-01-01', favorite_team: 'Galatasaray'
}

PersonalWordlist.generate(personal_data) do
  sequence(0..999) do |n|
    partial { first_name[0..2].downcase }
    partial { n.to_s }
    partial { last_name[0] }
  end
  sequence(0..999) do |n|
    partial { first_name[0..2].downcase }
    partial { n.to_s }
    partial { last_name[0] }
  end
end
```

## Future Plans

- CLI, I see that as a must.
- Input Data Adaptors, I am planning to create adaptors such as parsing yaml, xml, csv files into input hash parameter format. 

## Contribution

Contributing to personal_wordlist:

- Fork the official repository.
- Make your changes in a topic branch.
- Send a pull request.

## Licence

Copyright (c) 2015 Turhan Coskun

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
