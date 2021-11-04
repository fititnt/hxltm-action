# hxltm-action
**[non-production-ready] GitHub Action for HXLM (Humanitarian Exchange Language Terminologium Multilinguam)**

<!--
- https://github.com/nektos/act
- https://github.com/actions/hello-world-docker-action
- https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action
- https://docs.github.com/en/actions/learn-github-actions/workflow-commands-for-github-actions

cp -r /workspace/git/fititnt/hxltm-action /home/fititnt/Downloads/hxltm-action-backup
cd /home/fititnt/Downloads/hxltm-action-backup
docker run --rm -it $(docker build -q .)

-->

## Inputs

## `who-to-greet`

**Required** The name of the person to greet. Default `"World"`.

## Outputs

## `time`

The time we greeted you.

## Example usage

```yaml
uses: actions/hello-world-docker-action@v1
with:
  who-to-greet: 'Mona the Octocat'
```

## License

[![Public Domain](https://i.creativecommons.org/p/zero/1.0/88x31.png)](UNLICENSE)

To the extent possible under law, [Emerson Rocha](https://github.com/fititnt)
has waived all copyright and related or neighboring rights to this work to
[Public Domain](UNLICENSE).

Optionally, you can choose to use the [BSD Zero Clause License](https://spdx.org/licenses/0BSD.html)
instead of Public Domain unlicense. But if your project already have some
license you could choose the same.