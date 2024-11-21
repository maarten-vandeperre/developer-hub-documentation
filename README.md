# Developer Hub Documentation

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

The content of this repository is available as GitHub Pages Site [here](https://maarten-vandeperre.github.io/developer-hub-documentation/)

## Mission

This is a demo implementation from scratch including all the steps down, to help out developers or platform engineers who
want to start with Red Hat Developer Hub (or just to do as a workshop).

So feel free to check it out if you are struggling with it. Don't bother with the grammatical aspect, it just wrote it down to have it written down :stuck_out_tongue:

It contains both the documented steps and the sample yaml code. Besides the S3 storage, all required files, code, configs, ... are contained in this GitHub repository.

## Getting Involved

**Want to contribute?** Great! We try to make it easy, and all contributions, even
the smaller ones, are more than welcome. This includes bug reports, fixes, documentation, examples...
But first, read our [Contribution Guide](./CONTRIBUTING.md).

## Running Site Locally

This site uses GitHub pages to render the content, which is based on [Jekyll](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll).
It is easy to [test locally](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll) this site following the next instructions:

1. Install Jekyll on your machine following the [official documentation](https://jekyllrb.com/docs/installation/)
2. Access to the `docs` folder: `cd docs`
2. Install the bundles executing: `bundle install`
3. Run the local server executing: `bundle exec jekyll serve`

The site will be accessible locally at [http://127.0.0.1:4000](http://127.0.0.1:4000)
