# Actions with HXLTM: terminology, translation & localization
**[non-production-ready] GitHub Action for [HXLTM](https://hdp.etica.ai/hxltm/)
(Multilingual Terminology in
[Humanitarian Language Exchange](https://hxlstandard.org/)).
TBX, TMX, XLIFF, UTX, XML, CSV, Excel XLSX, Google Sheets, and more.**

> ## Preface
> Click to see more context details.
> <details><summary>What is HXLTM? Referece tooling? The HXLTM Action?</summary>
>
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
> </details>

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
docker run --rm -it $(docker build -q -f Dockerfile-extras .) 'hxltmcli --help'

> Delete old images
docker rmi $(docker images -f "dangling=true" -q)

cp .github/hxltm/hxltm-exemplum-linguam.tm.hxl.csv hxltm-exemplum-linguam.tm.hxl.csv

docker run --rm -it $(docker build -q .) 'hxltmcli' 'tests/hxltm-exemplum-linguam.tm.hxl.csv' 'objectivum.tbx' '--objectivum-TBX-Basim'

- # Using act
act
act --privileged

-#
-# Issues
-#  - https://github.com/nektos/act/issues/555
-#    - https://github.com/nektos/act/issues/410#issuecomment-732096442
-->

---

**Table of Contents**

<!-- TOC depthFrom:2 -->

- [Example usage](#example-usage)
    - [Quickstart](#quickstart)
    - [Full example usages](#full-example-usages)
        - [hxltm-action-example](#hxltm-action-example)
- [Documentation](#documentation)
    - [Baseline inputs](#baseline-inputs)
        - [`bin`](#bin)
        - [`args`](#args)
        - [`infile`](#infile)
        - [`outfile`](#outfile)
    - [Environment variables](#environment-variables)
        - [Reusable defaults](#reusable-defaults)
    - [Syntactic sugar inputs](#syntactic-sugar-inputs)
        - [`help`](#help)
        - [`working_languages`](#working_languages)
        - [`non_working_languages`](#non_working_languages)
        - [`auxiliary_languages`](#auxiliary_languages)
        - [`source_language`](#source_language)
        - [`target_language`](#target_language)
        - [`export_ad_hoc_template`](#export_ad_hoc_template)
        - [`export_data_exchange_standard`](#export_data_exchange_standard)
        - [`dump_abstract_syntax_tree`](#dump_abstract_syntax_tree)
    - [Outputs](#outputs)
        - [`resultatum`](#resultatum)
    - [Annotations](#annotations)
        - [Note on non use of pipelines](#note-on-non-use-of-pipelines)
        - [Note on language options](#note-on-language-options)
        - [Note on HXLTM-ASA](#note-on-hxltm-asa)
- [To do](#to-do)
- [License](#license)

<!-- /TOC -->

---


## Example usage

<details><summary>Are you new to GitHub Actions? PROTIP!</summary>

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

</details>

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
        uses: actions/hxltm-action@v0.4.0
        with:
            bin: 'hxltmcli'
            # https://hdp.etica.ai/hxltm/archivum/#TBX-Basim
            args: "--objectivum-TBX-Basim"
            infile: 'fontem.tm.hxl.csv'
            outfile: 'objectivum.tbx'

      - name: "HXLTM to TMX (Translation Memory eXchange)"
        uses: actions/hxltm-action@v0.4.0
        with:
            bin: 'hxltmcli'
            args: "--objectivum-TMX"
            infile: 'fontem.tm.hxl.csv'
            outfile: 'objectivum.tmx'

      - name: "HXLTM to UTX (Universal Terminology eXchange)"
        uses: actions/hxltm-action@v0.4.0
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

The `hxltm-action-example` is used to test the lasted version of `hxltm-action`.
**It's recommended to specify a version (or a strict hash), like `@v0.4.0`
instead of `@main`**, so `- uses: fititnt/hxltm-action@main` would become
`- uses: fititnt/hxltm-action@v0.4.0`.

## Documentation

This documentation explains the [action.yml](action.yml) and
[entrypoint.sh](entrypoint.sh) strategy to abstract the command line usage
described at <https://hdp.etica.ai/hxltm/archivum/>.

### Baseline inputs

Baseline inputs, together with [Environment variables](#environment-variables),
are enough to abstract how to use the underlying command line tools.
The [syntactic sugar inputs](#syntactic-sugar-inputs) offer some level of
abstraction.

---

```yaml
      # TODO: explain this snipped a bit better
      - # name: "Some description here"
        uses: fititnt/hxltm-action@v0.4.0
        with:
          bin: "hxltmcli" # hxltmcli, hxltmdexml
          args: ""  # 
          infile: path/to/fontem.tm.hxl.csv
          outfile: path/to/objectivum
```

---

#### `bin`
**Required** The executable to run.

> _Parameter examples_:
> - `hxltmcli` _(or `.github/hxltm/hxltmcli.py`)_ (*)
> - `hxltmdexml` _(or `.github/hxltm/hxltmdexml.py`)_ (*)
>
> <sub>(*): If necessary, a local customized fork of the reference HXLTM tools
  can be stored near where the data is processed. The suggested places are
  .github/hxltm/(file).py. This can both be useful for testing proposes or
  immediate hotfixes under urgency response where you as implementer cannot
  wait.</sub>

#### `args`
Arguments passed for the program defined by [bin](#bin) parameter.

> _Parameter examples_:
> - `--help`
> - `-v`
> - `--sheet 7` (_Select sheet from a Excel workbook (1 is first sheet)_)

#### `infile`
The input file for the program defined by [bin](#bin) parameter
<sup>[Note on non use of pipelines](#note-on-non-use-of-pipelines)</sup>.
Default `"fontem.ext"`.

> _Parameter examples_:
> - `fontem.hxl.csv`
> - `fontem.tbx`

#### `outfile`
The output file for the program defined by [bin](#bin) parameter
<sup>[Note on non use of pipelines](#note-on-non-use-of-pipelines)</sup>.
Default `"objectivum.ext"`.

> _Parameter examples_:
> - `objectivum.tbx`
> - `objecricum.hxl.csv`

### Environment variables
- See <https://docs.github.com/en/actions/learn-github-actions/environment-variables>.

#### Reusable defaults
The way GitHub Actions steps works, environment variables can be both passed
at the entire job level or at specific tasks. One implication of
[action.yml](action.yml) and [entrypoint.sh](entrypoint.sh) is that the use of
environment variables at job level can be used to create default values for
potentially repetitive values, like [working_languages](#working_languages).

> _TODO: test this potential implication and document it._

### Syntactic sugar inputs
This section shows some [syntactic sugar](https://en.wikipedia.org/wiki/Syntactic_sugar)
(or intentional _syntactic saccharins_) for what could be done using other ways,
often with [args](#args) parameter. Some of these only use English for what
hxltm cli tools use Latin.

#### `help`

<s>A syntax sugar to evoke [bin](#bin) program with --help and exit without
raising error. Default `false`.</s>

Just copy and paste the following.

```yaml
      - name: "hxltmcli --help"
        uses: fititnt/hxltm-action@v0.4.0
        with:
          bin: "hxltmcli"
          args: "--help"

      - name: "hxltmdexml --help"
        uses: fititnt/hxltm-action@v0.4.0
        with:
          bin: "hxltmdexml"
          args: "--help"
```

<details><summary>Extra: HXLStandard cli tools</summary>

Since `libhxl-python` is a requeriment of hxltm, you can reuse this action to
pre-process **already HXLated** datasets (if not HXLated yet, use `hxltag`
and manually map.)

```yaml
      # Bonus: HXLStandard cli tools ___________________________________________
      # @see https://github.com/HXLStandard/libhxl-python/wiki/Command-line-tools
      - name: "hxlspec --help"
        uses: fititnt/hxltm-action@v0.4.0
        with:
          bin: "hxlspec"
          args: "--help"

      - name: "hxltag --help"
        uses: fititnt/hxltm-action@v0.4.0
        with:
          bin: "hxltag"
          args: "--help"

      - name: "hxldedup --help"
        uses: fititnt/hxltm-action@v0.4.0
        with:
          bin: "hxldedup"
          args: "--help"

      ### Full list (as 2021-11-07)
      # compgen -c | grep hxl
      # hxlreplace
      # hxlexplode
      # hxlselect
      # hxladd
      # hxlspec
      # hxlcount
      # hxltag
      # hxlcut
      # hxlsort
      # hxlexpand
      # hxlmerge
      # hxldedup
      # hxlfill
      # hxlrename
      # hxlclean
      # hxlappend
      # hxlimplode
      # hxlvalidate
      # hxlhash
```
</details>

<!--
> _TODO: this option is drafted, but not fully implemented/tested for
  production usage. Please use raw version [args](#args) parameter._

A syntax sugar to evoke [bin](#bin) program with --help and exit without
raising error. Default `false`.

**Parameter examples**:
- `true`
- `false`
-->


#### `working_languages`
- Syntactic sugar for HXLTM: `--agendum-linguam`)
- Concept:
  - ['Working language' on Wikipedia](https://en.wikipedia.org/wiki/Working_language)
  - More context here: <https://github.com/fititnt/hxltm-action/issues/3#issuecomment-962601744>

List of one or more working languages
<sup>[Note on language options](#note-on-language-options)</sup>.
Use new lines or `,` as separator.

> _Parameter examples_:
> - _TODO: add example parameters for IATE and UN working languages here_

#### `non_working_languages`

Opposite of [working_languages](#working_languages)
<sup>[Note on language options](#note-on-language-options)</sup>.

#### `auxiliary_languages`
- Syntactic sugar for HXLTM: `--auxilium-linguam`)
- Concept:
  - ['Auxiliary language' on Wikipedia](https://en.wikipedia.org/wiki/Auxiliary_language)
  - More context here: <https://github.com/fititnt/hxltm-action/issues/3#issuecomment-962601744>

List of one or more auxiliary languages (order ir important)
<sup>[Note on language options](#note-on-language-options)</sup>.
Use new lines or `,` as separator.

> _Parameter examples_:
> - _TODO: add example parameters for IATE and UN working languages here_

#### `source_language`
- Syntactic sugar for HXLTM: `--fontem-linguam`)
- Concept:
  - ['Translation / Source and target languages' on Wikipedia](https://en.wikipedia.org/wiki/Translation#Source_and_target_languages)
  - More context here: <https://github.com/fititnt/hxltm-action/issues/3#issuecomment-962601744>

Source language
<sup>[Note on language options](#note-on-language-options)</sup>.
Single item.

#### `target_language`
- Syntactic sugar for HXLTM: `--objectivum-linguam`)
- Concept:
  - ['Translation / Source and target languages' on Wikipedia](https://en.wikipedia.org/wiki/Translation#Source_and_target_languages)
  - More context here: <https://github.com/fititnt/hxltm-action/issues/3#issuecomment-962601744>

Target language
<sup>[Note on language options](#note-on-language-options)</sup>.
Single item.

#### `export_ad_hoc_template`
- Syntactic sugar for HXLTM: `--objectivum-formulam`)

Export custom template (HXLTM Ad Hoc Fōrmulam).
Path to a single file on local disk.

> _Parameter examples_:
> - `data/README.🗣️.md`

#### `export_data_exchange_standard`
- Syntactic sugar for HXLTM: `--objectivum-<VALUE>`)

Export to data standard documented on the HXLTM ontologia.

> _Parameter examples_:
> - `TMX`
> - `XLIFF`

<!--
- #### `verbose`
<s>A syntax sugar to evoke [bin](#bin) program binary with -v. Default `false`.</s>


Just copy and paste the following.

```yaml
      - name: "hxltmcli --venandum-insectum-est"
        uses: fititnt/hxltm-action@v0.4.0
        with:
          bin: "hxltmcli"
          args: "--venandum-insectum-est"

      - name: "hxltmdexml --venandum-insectum-est"
        uses: fititnt/hxltm-action@v0.4.0
        with:
          bin: "hxltmdexml"
          args: "--venandum-insectum-est"
```
-->

#### `dump_abstract_syntax_tree`
- Syntactic sugar for HXLTM: `--expertum-HXLTM-ASA <VALUE>`
- Concept:
  - ['abstract syntax tree (AST)' on Wikipedia](https://en.wikipedia.org/wiki/Abstract_syntax_tree)

Specify a file to dump the _HXLTM Abstractum Syntaxim Arborem_
<sup>[[Note on HXLTM-ASA](#note-on-hxltm-asa)]</sup>.

> _Parameter examples_:
> - `.asa.hxltm.yml`
> - `.asa.hxltm.json`

<!--
- #### `dump_abstract_syntax_tree_verbose`
> _TODO: this option is drafted, but not fully implemented/tested for
  production usage. Please use raw version [args](#args) parameter._

Specify a file to dump the HXLTM
[abstract syntax tree (AST)](https://en.wikipedia.org/wiki/Abstract_syntax_tree)
with VERY verbose mode.

Sames as [args](#args) with `--expertum-HXLTM-ASA-verbosum --expertum-HXLTM-ASA {parameter}`.

**Examples**:
- `.asa.hxltm.yml`
- `.asa.hxltm.json`
-->

### Outputs

#### `resultatum`

> TODO: explain better the outputs.

### Annotations

#### Note on non use of pipelines
- See [`infile`](#infile), [`outfile`](#outfile)

Piping from stdin and stout, available as an efficient way by
underlining cli tools, is not available. If you're working with gigabytes
size datasets that would exist on GitHub Actions free disk, consider
using actions-python and install all dependencies manually.

#### Note on language options
- See [`working_languages`](#working_languages),
  [`non_working_languages`](#non_working_languages),
  [`auxiliary_languages`](#auxiliary_languages),
  [`source_language`](#source_language), [`target_language`](#target_language)

The main reason for the hxltm-action documentation on these options to be more
conceptual is both because the HXLTM reference implementation tooling allows
users specifying them and explose their value for who document custom standards
on your ontologia even when original data exchange standards don't use it.

> TODO: give even more context

#### Note on HXLTM-ASA
- See [`working_languages`](#working_languages),
  [`non_working_languages`](#non_working_languages),
  [`auxiliary_languages`](#auxiliary_languages),
  [`source_language`](#source_language), [`target_language`](#target_language),
  [`dump_abstract_syntax_tree`](#dump_abstract_syntax_tree)

- See <https://hdp.etica.ai/hxltm/archivum/#HXLTM-ASA>

> TODO: explain what is special about the way the reference implementation of
  HXLTM use HXLTM-ASA.

## To do

- Even if the `@v0.*.*` already are usable (but recommended to users to specify
  exact version), eventually release a `@v1.0.0` fo uses can use the convention
  of GitHub actions of define `@v1` / `@v2` / `@v3` (...) as their version.
- Potential new Action Translate Toolkit
  - Do https://github.com/translate/translate have a GitHub Action? If not, we
    may be interested, since they can be used to create PO files and
    some other bilingual formats.

## License

[![Public Domain](https://i.creativecommons.org/p/zero/1.0/88x31.png)](UNLICENSE)

To the extent possible under law, [Emerson Rocha](https://github.com/fititnt)
and [non anonymous collaborators](https://github.com/fititnt/hxltm-action/graphs/contributors)
have waived all copyright and related or neighboring rights to this work to
[Public Domain](UNLICENSE).

Optionally, the [BSD Zero Clause License](https://spdx.org/licenses/0BSD.html)
is also one explicit alternative to the Unlicense as an older license approved
by the OSI:

`SPDX-License-Identifier: Unlicense OR 0BSD`
