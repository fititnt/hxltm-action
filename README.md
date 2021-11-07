# Actions with HXLTM: terminology, translation & localization
**[non-production-ready] GitHub Action for [HXLTM](https://hdp.etica.ai/hxltm/)
(Multilingual Terminology in
[Humanitarian Language Exchange](https://hxlstandard.org/)).
TBX, TMX, XLIFF, UTX, XML, CSV, Excel XLSX, Google Sheets, and more.**

> ## Preface
> **What is HXLTM?**
> 
> The HXLTM documented convetions <sup>([ontologia](https://hdp.etica.ai/hxltm/#ontologia))</sup>
explains how store terminology and translation memories in HXL. This make both
very compact storage while viable to alow human colaborative editing for
complex cases even without advanced frontends.
>
> **Referece tooling**
>
> Public domain reference tooling enable direct convertion from HXLTM to both
templated files (in short: more-than-string-replace placeholders with content
from HXLTM) and both user customizable and industry standards related to
linguistic content.
>
> - [TBX (TermBase eXchange)](https://en.wikipedia.org/wiki/TermBase_eXchange)
> - [TMX (Translation Memory eXchange)](https://en.wikipedia.org/wiki/Translation_Memory_eXchange)
> - [XLIFF (XML Localization Interchange File Format)](https://en.wikipedia.org/wiki/Translation_Memory_eXchange)
> - [UTX (Universal Terminology eXchange) <sup>export only</sup>](https://en.wikipedia.org/wiki/Universal_Terminology_eXchange)
> - [HXLTM](https://hdp.etica.ai/hxltm/archivum/) itself, on some container,
>   either on local disk or remove server:
>   - CSV
>   - Google Sheets <sup>read only</sup>
>   - Microsoft Excel <sup>read only</sup>
> - ...and much, much more. See <https://hdp.etica.ai/hxltm/archivum/>
>
>
> **The HXLTM Action**
> 
> This GitHub Action abstract part of what is possible use with underling
> HXLTM cli tools. This action also allow use the
> [**fantastic** command line tools shipped with libhxl-python](https://github.com/HXLStandard/libhxl-python/wiki/HXL-cookbook) configurable with the [bin](#bin) parameter.
>
> Source code for underlining applications:
> - HXL Standard tools: https://github.com/HXLStandard/libhxl-python
> - HXLTM cli tools: https://github.com/EticaAI/HXL-Data-Science-file-formats


<!--
While this GitHub action can be used for the
[**fantastic** command line tools shipped with libhxl-python](https://github.com/HXLStandard/libhxl-python/wiki/HXL-cookbook)
(because is a dependency of hxltm, and, anyway, you may need to do advanced
preprocessing!) the documented features here target the HXLTM, which is a
documented specialization of HXL attributes to deal with import/export
linguistic content for other data formats such as:
-->

<!--
- https://github.com/nektos/act
- https://github.com/actions/hello-world-docker-action
- https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action
- https://docs.github.com/en/actions/learn-github-actions/workflow-commands-for-github-actions

cp -r /workspace/git/fititnt/hxltm-action /home/fititnt/Downloads/hxltm-action-backup

rsync -r -a -v /workspace/git/fititnt/hxltm-action/ /home/fititnt/Downloads/hxltm-action-backup
cd /home/fititnt/Downloads/hxltm-action-backup
docker run --rm -it $(docker build -q .)

docker run --rm -it $(docker build -q .) 'hxltmcli --help'

cp .github/hxltm/hxltm-exemplum-linguam.tm.hxl.csv hxltm-exemplum-linguam.tm.hxl.csv

docker run --rm -it $(docker build -q .) 'hxltmcli' 'tests/hxltm-exemplum-linguam.tm.hxl.csv' 'objectivum.tbx' '--objectivum-TBX-Basim'

# Using act
act
act --privileged

# Issues
#  - https://github.com/nektos/act/issues/555
#    - https://github.com/nektos/act/issues/410#issuecomment-732096442
-->


## Example usage

> _PROTIP: if you are new to [GitHub Actions](https://docs.github.com/en/actions)
  consider each [published action with 💖 by with others](https://github.com/marketplace?type=actions)
  (TL;DR the `- uses:` of `- uses: actions/checkout@v2` part) as **building blocks**
  who run (TL;DR the `runs-on: ubuntu-latest` part) on 8GB to 14GB RAM
  powerful virtual machines and are **100% free and unlimited (*)** to public
  open source projects._
>
> <sub>(*): but even in good intent, **avoid too often** unauthenticated request
> for external services without strong reason, like Google Sheets.
> Special care with
> [Scheduled jobs](https://docs.github.com/en/actions/learn-github-actions/events-that-trigger-workflows#scheduled-events)
> for datasets someone else already is sharing a cached version and hosting
> on GitHub Pages or some other site.</sub>

<!--
> PROTIP: if you are new to [GitHub Actions](https://docs.github.com/en/actions)
  consider each [published action with 💖 by with others](https://github.com/marketplace?type=actions)
  (TL;DR the `- uses: actions/checkout@v2` part ) as **building blocks**
  who run on (TL;DR the `runs-on: ubuntu-latest` part) 8GB (ubuntu/windows) to
  14GB (macos) RAM virtual machines and are **100% free and unlimited** to
  public open source projects (just don't, even in good intent,
  set up unnecessary scheduled jobs too often to disrupt external services,
  like Google Sheets).
-->

### Quickstart
```yaml
on: [push]

jobs:
  HXLTM-export:
    name: Converts HXLTM to multilingual data formats
    runs-on: ubuntu-latest
    steps:

      - name: Checkout the git repository to the actions temporary host runner
        uses: actions/checkout@v2

      - name: "HXLTM to TBX (TermBase eXchange)"
        uses: actions/hxltm-action@v0.3.0
        with:
            bin: 'hxltmcli'
            # https://hdp.etica.ai/hxltm/archivum/#TBX-Basim
            args: "--objectivum-TBX-Basim"
            infile: 'fontem.tm.hxl.csv'
            outfile: 'objectivum.tbx'

      - name: "HXLTM to TMX (Translation Memory eXchange)"
        uses: actions/hxltm-action@v0.3.0
        with:
            bin: 'hxltmcli'
            args: "--objectivum-TMX"
            infile: 'fontem.tm.hxl.csv'
            outfile: 'objectivum.tbx'

      - name: "HXLTM to UTX (Universal Terminology eXchange)"
        uses: actions/hxltm-action@v0.3.0
        with:
            bin: 'hxltmcli'
            args: "--objectivum-UTX"
            infile: 'fontem.tm.hxl.csv'
            outfile: 'objectivum.utx'
```
### Full example usages
Examples of repositories using this action

#### hxltm-action-example
- <https://github.com/fititnt/hxltm-action-example>
  - <https://github.com/fititnt/hxltm-action-example/tree/main/.github/workflows>

NOTICE: the `hxltm-action-example` is used to test the lasted version of
`hxltm-action`.

It's recommended to specify a version (or a strict hash), like `@v0.3.0` on
`@main`, so `- uses: fititnt/hxltm-action@main` would become
`- uses: fititnt/hxltm-action@v0.3.0`.

## Documentation

This documentation explains the [action.yml](action.yml) and
[entrypoint.sh](entrypoint.sh) strategy to abstract the command line usage
described at <https://hdp.etica.ai/hxltm/archivum/>.

### Inputs
#### `bin`
**Required** The executable to run.

**Parameter examples**:
- `hxltmcli` _(or `.github/hxltm/hxltmcli.py`)_ (*)
- `hxltmdexml` _(or `.github/hxltm/hxltmdexml.py`)_ (*)

> <sub>(*): If necessary, a local customized fork of the reference HXLTM tools
  can be stored near where the data is processed. The suggested places are
  .github/hxltm/(file).py. This can both be useful for testing proposes or
  immediate hotfixes under urgency response where you as implementer cannot
  wait.</sub>

#### `infile`
The input file for the program defined by [bin](#bin) parameter.
Default `"fontem.ext"`.

**Parameter examples**:
- `fontem.hxl.csv`
- `fontem.tbx`

> **Note**: piping from stdin and stout, available as an efficient way by
underlining cli tools, is not available. If you're working with gigabytes
size datasets that would exist on GitHub Actions free disk, consider
using actions-python and install all dependencies manually.

#### `outfile`
The output file for the program defined by [bin](#bin) parameter.
Default `"objectivum.ext"`.

**Parameter examples**:
- `objectivum.tbx`
- `objecricum.hxl.csv`

> **Note**: piping from stdin and stout, available as an efficient way by
underlining cli tools, is not available. If you're working with gigabytes
size datasets that would exist on GitHub Actions free disk, consider
using actions-python and install all dependencies manually.

#### `args`
Arguments passed for the program defined by [bin](#bin) parameter.

**Parameter examples**:
- `--help`
- `-v`
- `--sheet 7` (_Select sheet from a Excel workbook (1 is first sheet)_)

#### Syntactic sugar arguments
This section shows some [syntactic sugar](https://en.wikipedia.org/wiki/Syntactic_sugar)
(or intentional _syntactic saccharins_) for what could be done using other ways,
often with [args](#args) parameter. Some of these only use English for what
hxltm cli tools use Latin.

##### `help`
> _TODO: this option is drafted, but not fully implemented/tested for
  production usage. Please use raw version [args](#args) parameter._

A syntax sugar to evoke [bin](#bin) program with --help and exit without
raising error. Default `false`.

**Parameter examples**:
- `true`
- `false`

##### `verbose`
> _TODO: this option is drafted, but not fully implemented/tested for
  production usage. Please use raw version [args](#args) parameter._

A syntax sugar to evoke [bin](#bin) program binary with -v. Default `false`.

**Parameter examples**:
- `true`
- `false`

##### `dump_abstract_syntax_tree`
> _TODO: this option is drafted, but not fully implemented/tested for
  production usage. Please use raw version [args](#args) parameter._

Specify a file to dump the HXLTM
[abstract syntax tree (AST)](https://en.wikipedia.org/wiki/Abstract_syntax_tree).

Sames as [args](#args) with `--expertum-HXLTM-ASA {parameter}`.

**Examples**:
- `.asa.hxltm.yml`
- `.asa.hxltm.json`

##### `dump_abstract_syntax_tree_verbose`
> _TODO: this option is drafted, but not fully implemented/tested for
  production usage. Please use raw version [args](#args) parameter._

Specify a file to dump the HXLTM
[abstract syntax tree (AST)](https://en.wikipedia.org/wiki/Abstract_syntax_tree)
with VERY verbose mode.

Sames as [args](#args) with `--expertum-HXLTM-ASA-verbosum --expertum-HXLTM-ASA {parameter}`.

**Examples**:
- `.asa.hxltm.yml`
- `.asa.hxltm.json`

### Outputs

### `resultatum`

resultatum variable

## License

[![Public Domain](https://i.creativecommons.org/p/zero/1.0/88x31.png)](UNLICENSE)

To the extent possible under law, [Emerson Rocha](https://github.com/fititnt)
has waived all copyright and related or neighboring rights to this work to
[Public Domain](UNLICENSE).

Optionally, you can choose to use the [BSD Zero Clause License](https://spdx.org/licenses/0BSD.html)
instead of Public Domain unlicense. But if your project already have some
license you could choose the same.