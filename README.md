# Advent Of Code (for ruby!)

## How to do advent of code
1. Fork this repo
2. Put `function aoc { ruby <some/path/to>/advent_of_code/$1.rb $2 $3 }` in your .bashrc/.zshrc and source it
3. Create the necessary test/input/file infrastructure with `aoc new <year> <day>`
4. Code your solution in `./YYYY/code/day_DD.rb`
5. Add some test cases in `./YYYY/test/day_DD.rb`
6. Run tests with `aoc test <year> <day>`
7. Paste input file into `./YYYY/input/day_DD.txt`
8. Get output with `aoc run <year> <day>`
9. Submit your answer and get those sweet sweet *s

## Notes

1. I know it's not very good
2. `run_a` and `run_b` should return your solutions for part 1 and part 2 for each day, respectively
3. You can use `input_blob`, `input_lines`, or `parsed_input` in the classes that inherit from `AdventOfCode::Day`
4. No, I know, gems are for fools. Why would I make this a gem? Why would I INSTALL any gems? `#JOYOFCODING`

## Contributing
1. If you really want to, you can ask
2. but seriously just, like, fork it and do it yourself because this is also the repo I'm solving in
