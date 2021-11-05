# hxltm-action
**[non-production-ready] GitHub Action for HXLM (Humanitarian Exchange Language Terminologium Multilinguam)**

While this GitHub action can be used for the fantastic command line tools
shipped with libhxl-python (because is a dependency of hxltm, and, anyway,
you may need to do advanced preprocessing) the documented features here target
the HXLTM, which is a documented specialization of HXL attributes to deal
with import/export linguistic content for other data formats.
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

# Using act
act

-->

## Inputs
### `bin`
The executable to run.

Examples:
- hxltmcli
- hxltmdexml

### `infile`
The input file for the bin command

Note: piping from stdin and stout, available as an efficient way by underlining cli tools, is not available. If you're working with gigabytes size datasets that would exist on GitHub Actions free disk, consider using actions-python and install all dependencies manually.

Examples:
- fontem.hxl.csv
- fontem.tbx

### `outfile`
The output file for the bin command

Note: piping from stdin and stout, available as an efficient way by underlining cli tools, is not available. If you're working with gigabytes size datasets that would exist on GitHub Actions free disk, consider using actions-python and install all dependencies manually.

Examples:
- objectivum.tbx
- objecricum.hxl.csv

### `help`
A syntax sugar to evoke `bin` binary with --help and exit without raising error.

### `verbose`
A syntax sugar to evoke `bin` binary with -v.

### `hxltm-asa-archivum`
A syntax sugar to evoke `bin` binary with `--hxltm-asa-archivum`.

Examples:
- .asa.hxltm.yml
- .asa.hxltm.json

## `crudum-non-securum`

Low level raw command to pass to dockerized container.

Equivalent to GitHub Actions `run`. So, please follow
[Security hardening for GitHub Actions](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions) by not using use as part of this command
variables that are prone to script injection attack.

## Outputs

## `time`

The time we greeted you.

## Example usage

```yaml
- uses: actions/hxltm-action@v0.1.0
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