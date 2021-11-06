# hxltm-action
**[non-production-ready] GitHub Action for
[HXLM (Multilingual Terminology in Humanitarian Language Exchange)](https://hdp.etica.ai/hxltm/).
Both for push/pull request-like operations and
[automated schedule (e.g. cron)](https://docs.github.com/en/actions/learn-github-actions/events-that-trigger-workflows#schedule)
using remote sources (like Google Sheets edited by humans)**

While this GitHub action can be used for the
[**fantastic** command line tools shipped with libhxl-python](https://github.com/HXLStandard/libhxl-python/wiki/HXL-cookbook)
(because is a dependency of hxltm, and, anyway, you may need to do advanced
preprocessing!) the documented features here target the HXLTM, which is a
documented specialization of HXL attributes to deal with import/export
linguistic content for other data formats such as:

- [TBX (TermBase eXchange)](https://en.wikipedia.org/wiki/TermBase_eXchange)
- [TMX (Translation Memory eXchange)](https://en.wikipedia.org/wiki/Translation_Memory_eXchange)
- [XLIFF (XML Localization Interchange File Format)](https://en.wikipedia.org/wiki/Translation_Memory_eXchange)
- [UTX (Universal Terminology eXchange) <sup>export only</sup>](https://en.wikipedia.org/wiki/Universal_Terminology_eXchange)
- [HXLTM](https://hdp.etica.ai/hxltm/archivum/) itself, on some container,
  either on local disk or remove server:
  - CSV
  - Google Sheets <sup>read only</sup>
  - Microsoft Excel <sup>read only</sup>
- ...and much, much more. See <https://hdp.etica.ai/hxltm/archivum/>

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

docker run --rm -it $(docker build -q .) 'hxltmcli' '.github/hxltm/hxltm-exemplum-linguam.tm.hxl.csv' 'objectivum.tbx' '--objectivum-TBX-Basim'
docker run --rm -it $(docker build -q .) 'hxltmcli' 'tests/hxltm-exemplum-linguam.tm.hxl.csv' 'tests/result/objectivum.tbx' '--objectivum-TBX-Basim'

# Using act
act

-->

## Documentation

### Inputs
#### `bin`
**Required** The executable to run.

**Parameter examples**:
- `hxltmcli`
- `hxltmdexml`

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
This section shows some [Syntactic sugar](https://en.wikipedia.org/wiki/Syntactic_sugar)
(or _sntactic saccharins_) for what could be done using other ways, often
with [args](#args) parameter. Some of these only use English for what hxltm cli
tools use Latin.

##### `help`
A syntax sugar to evoke [bin](#bin) program with --help and exit without
raising error. Default `false`.

**Parameter examples**:
- `true`
- `false`

##### `verbose`
A syntax sugar to evoke [bin](#bin) program binary with -v. Default `false`.

**Parameter examples**:
- `true`
- `false`

##### `dump_abstract_syntax_tree`
Specify a file to dump the HXLTM
[abstract syntax tree (AST)](https://en.wikipedia.org/wiki/Abstract_syntax_tree).

Sames as [args](#args) with `--expertum-HXLTM-ASA {parameter}`.

**Examples**:
- `.asa.hxltm.yml`
- `.asa.hxltm.json`

##### `dump_abstract_syntax_tree_verbose`
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

## Example usage

```yaml
on: [push]

jobs:
  HXLTM-2-TBX:
    name: Converts HXLTM to TermBase eXchange (TBX)
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2

      # - uses: actions/hxltm-action@v0.1.0
      - uses: fititnt/hxltm-action@main
        with:
            bin: 'hxltmcli'
            infile: 'fontem.hxl.csv'
            outfile: 'objectivum.tbx'
```

## License

[![Public Domain](https://i.creativecommons.org/p/zero/1.0/88x31.png)](UNLICENSE)

To the extent possible under law, [Emerson Rocha](https://github.com/fititnt)
has waived all copyright and related or neighboring rights to this work to
[Public Domain](UNLICENSE).

Optionally, you can choose to use the [BSD Zero Clause License](https://spdx.org/licenses/0BSD.html)
instead of Public Domain unlicense. But if your project already have some
license you could choose the same.