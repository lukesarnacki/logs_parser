# Readme

I have been coding for about 2.5 hours as recommended in the instructions. As I
decided to tackle this problem a bit differently than I normally would in my
work on the daily basis I decided to spend more time on README with rationale
and links to the commits. I think that the code came out decent but what is more
interesting in this case is path to this code.

I realized that the problem is very simple from the alghoritmic point of view;
all it needs to do is to read bunch of lines from a file and then iterate over
these lines counting views and unique views depending on the list of IPs for
given path.

I decided that I will write simple and not very object oriented solution and
then I will try to find out how can I improve step by step. I will list all of
the commits and write why I did certain changes.

### 1. First spec

I decided to use rspec testing framework with which I am the most familiar. I
started from writing failing scenatio which would only test the parser class API
and edge case scenario in which logs it gets are empty.

Commit: de76d68f17122d06c965b69360698a3759e1f074

### 2. Correct but naive solution

I created a `Parser` class with two public methods for getting list of paths
with views and unique views (`views_stats` and `unique_views_stats`). This code
is not terrible not great as one could say. It does what it needs to do but
because it was written rather quickly you can clearly see cutting corners. The
core logic is mostly structural code and the resulting data structure is just an
array of arrays; further processing can be error prone in this form.

Commit: 28337708fdc55bd46a0cce73309ea5a782489cf5

### 3. Refactoring

If I knew this code would never change maybe this solution would be good enough
but it rarely happens in web apps world. I wanted to change code step by step
and be able to look how it improves (which will be visible in constantly
simplified code of `parser.rb` file).

#### Logs loading code

Before refactoring, the code that loaded logs into the file looked like:

```ruby
logs = File.read(ARGV[0])
parser = Parser.new(logs)
```

It is fine enough if the logs would be  always loaded from a file and
specifically small one. But apart from imagining larger files these logs might
come from some kind of message or streams. For that reason I created a `Logs`
class which only responsibility is to keep logs as POROs and iterating over
them. `Logs` class take `loader` as an argument which defaults to
`TextLogDeserializer`. Its main purpose is to extract responsibility of parsing
from `Logs` class but it also opens the possibility of getting logs from other
sources.

I took one of the responsibilities from `Parser` and used dedicated object for
log line instead of `OpenStruct`. Code looks a bit better and should be able to
handle large files a bit better.

Commit: d2a239cc0abb26e677ff75f4ccce6c8c0457ecb3

#### Pageviews calculation

Pageviews calculation is based on the structural code mostly and pageviews
statistics are returned in array of arrays form (which is not very pleasent to
work with). For that reason I created a `WebPage` class which represents a
webpage; it holds pageviews and visited ips list. It also holds a logic for
incrementing both unique and not unique views so the `Parser` class gets less
responsibilities.

Commit: 9ad13ec7f1f8c56f1e0a023c6f2c1da1bc4e1e3c

#### Showing the results

Results are shown using piece of structural code. It would be nice to add
a dedicated class which would generate text output; the form would be the same
but having a class means that there will be less repetition.

As I was running out of time I also did one more thing in this step. I extracted
what was `Parser` class to `LogsAnalyzer` as its previous name didn't reflect on
its responsibilities.

Commit: 1f9acaaaa0d82fa6e8a69ee48830725e36231280

### Final thoughts

I think I showed that refactoring of each of the parts of the script made the
code simpler and responsibilities clearer. All of the classes follow single
responsibility principle and are relatively loosely coupled (most of the
dependencies are handled using dependency injection technique).

I tried to follow TDD technique all along by writing failing tests for new
components and then write the implementation not breaking my initial spec in the
process.
