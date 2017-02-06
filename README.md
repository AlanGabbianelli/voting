## Task

Create a rails application to show the results for TV SMS voting campaigns,
derived from the log data similar to the attached tarball.

This task should take no more than 3 hours, and possibly considerably less.

## Deliverables

- A rails application and associated database to hold the data.
- A basic web front-end to view the results which should:
  - Present a list of campaigns for which we have results.
  - When the user clicks on a campaign, present a list of the
    candidates, their scores, and the number of messages which were sent in
    but not counted.
- A command-line script that will import log file data (uncompressed plain text)
  into the application. Any lines that are not well-formed should be discarded.
- A description of your approach to this problem, including any
  significant design decisions and your reasoning in making your
  choices. This is the most important deliverable.

## Parsing rules

Here is an example log line:

```
VOTE 1168041980 Campaign:ssss_uk_01B Validity:during Choice:Tupele
CONN:MIG00VU MSISDN:00777778429999
GUID:A12F2CF1-FDD4-46D4-A582-AD58BAA05E19 Shortcode:63334
```

- All well-formed lines will have the same fields, in the same order. They
 will all begin with VOTE, then have an epoch time value, then a set
 of fields with an identifier, a colon, and the value of the field
 (e.g. 'Campaign:ssss_uk_01B')

- A campaign is an episode of voting

- 'Choice:' indicates the candidate the user is voting for. In every campaign
 there will be a limited set of candidates that can be voted for.
 If Choice is blank, it means the system could not identify the chosen
 candidate from the text of the SMS message. All such messages should
 be counted together as 'errors', irrespective of their Validity
 values. There is a limited set of values for 'Choice', each of which
 represents a candidate who can be voted for.

- Validity classifies the time when the vote arrived, relative to the time
 window when votes will count towards a candidate's score.  Only votes
 with a Validity of 'during' should count towards a candidate's score.
 Other possible values of Validity are 'pre' (message was too early to be
 counted), 'post' (message was too late to be counted). 'pre' and 'post'
 messages should be counted together irrespective of the candidate chosen.

- The CONN, MSISDN, Shortcode and GUID fields are not relevant to this
 exercise.

## Approach

When I first approached this test, I immediately thought I had to work with a
combination of the ruby `File` class and a rake task to automatize the file
import and manipulate the data ("...maybe one of `File.open` or `File.read` is
what I need?").

As I was fairly confident with the rake task, I started from there, and I soon
realized I wanted a way to declare the file to import right in the task. I had
recently worked with rake tasks, but never with ones with arguments, so a quick
research pointed me in the right direction (especially [this blog post](https://www.viget.com/articles/protip-passing-parameters-to-your-rake-tasks)
and [this stack overflow question](http://stackoverflow.com/questions/1357639/rails-rake-how-to-pass-in-arguments-to-a-task-with-environment)).

Now that I had the scaffold for the task, I focused on the real file import and
considered several methods to achieve that:
```ruby
# These are all methods of the IO class, but as the File class inherits from it, they are
# all available, and I find it to be clearer and more expressive to use the latter.
File.open("file").each_line { |line| line.do_someting }
File.read("file").each { |line| line.do_someting }
File.readlines("file").each { |line| line.do_someting }
File.foreach("file") { |line| line.do_someting }
```
Assuming the file passed as argument was big, I didn't want to load it all in
memory, and a second research (useful stack overflow questions
  [here](http://stackoverflow.com/questions/1727217/file-open-open-and-io-foreach-in-ruby-what-is-the-difference)
  and [here](http://stackoverflow.com/questions/15677521/in-ruby-file-readlines-each-not-faster-than-file-open-each-line-why))
  made me realize `IO::foreach` was what I wanted, as it reads a line at a time
  and directly executes the passed block before moving to the next line, without
  saving the entire file in memory, nor pushing the lines to an array.

Trying my approach with a small sample gave me good results, but running the
rake task with the given `votes.txt` file gave me the following error:
`ArgumentError: invalid byte sequence in UTF-8`.
I was wrongly assuming that the file conteined only valid characters, but that
wasn't the case, so I solved this issue with `#scrub('')`. I chose it, after
consulting the suggestions in [this thoughtbot blog post](https://robots.thoughtbot.com/fight-back-utf-8-invalid-byte-sequences)
and in [this stack overflow question](http://stackoverflow.com/questions/24036821/ruby-2-0-0-stringmatch-argumenterror-invalid-byte-sequence-in-utf-8),
because when available I prefer to use ruby methods, rather than rails methods,
and I just wanted to delete the invalid bytes, so that was enough.

After that, I had to decide what to actually do with the lines, and following
the istructions I knew that only a part of the line was needed, so I focused on
that. After some exploratory code in pry, and having just the basic
functionality working, I focused on extracting the logic to a well tested
"Plain Old Ruby Object", and scaffolding the needed models.

I initially thought to implement just two models `Campaign` and `Vote` (with one
to many relationship), but I soon realized that adding a `Choice` model (that
belongs to Campaign and has many votes) would be better, as it allows more
flexibility and a simpler way to query the database. For the same reason, I also
added the relationship between `Campaign` and `Vote` (Campaign has many votes
through Choice), so that Rails would understand `@campaign.votes`.

I used RSpec and Capybara for testing (with the convenient shoulda-matchers),
and pry-byebug and better_errors (with binding_of_caller) for debugging.

A sample of the application, already populated with the given data through the
rake task, is [deployed on Heroku](https://alan-voting.herokuapp.com/).

## Instructions

In your terminal, type:

```
$ git clone git@github.com:AlanGabbianelli/voting.git
$ cd voting
$ bundle install
$ rake db:create
$ rake db:migrate
```

Run the tests to see that everithing is fine:
```
$ rspec
```

Run the rake task without argument to populate the database with the given file:

```
$ rake import:votes
```

Or run it with the path to the file you want to import, as an argument:

```
$ rake import:votes[path/to/your/file.txt]
```

Run a rails server (`$ rails server`) and visit http://localhost:3000/ to see
the imported data (or simply go to https://alan-voting.herokuapp.com/ to see an
example of the one I made, already deployed on Heroku).
