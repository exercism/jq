# Resources

- [jq home page][jq]
- Github: [jqlang/jq][github]
- Supplementary documentation: [jqlang/jq/wiki][wiki]
- [Exercism jq Cookbook][cook], an effort created by [@sshine][sshine].

## Interactive jq tools

Provide some input and experiment with various jq filters to see what is achieved.

- [jq playground][jqplay], a "try it online" experience. 
- [ijq][ijq], interactive jq tool, like jqplay for the commandline.
- [jqp][jqp] is another commandline tool -- it uses gojq as a backend which isn't 100% compatible with the original jq.

## JSON

- [JSON][json]
- [JSON at Wikipedia][wiki-json]
- [JSON Lines][jsonl]

## Other JSON processing tools

- [gron][gron]: "Flattens" JSON into a sequence of individual assignments, which makes it possible to use line-oriented tools (grep, etc) to process it.
- [jo][jo]: A small utility to create JSON objects from shell variables.
- [jello][jello]: jello is similar to jq except jello uses standard python dict and list syntax.

[jq]: https://jqlang.github.io/jq
[github]: https://github.com/jqlang/jq
[wiki]: https://github.com/jqlang/jq/wiki
[jqplay]: https://play.jqlang.org
[ijq]: https://github.com/gpanders/ijq
[jqp]: https://github.com/noahgorstein/jqp
[gron]: https://github.com/tomnomnom/gron#readme
[jo]: https://github.com/jpmens/jo#readme
[jello]: https://kellyjonbrazil.github.io/jello
[jsonl]: https://jsonlines.org
[json]: https://json.org
[wiki-json]: https://en.wikipedia.org/wiki/JSON
[cook]: https://github.com/exercism/exercism/issues/5055
[sshine]: https://exercism.org/profiles/sshine
