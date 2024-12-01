# Contribution Guide

Welcome!
First off, thanks for taking the time to contribute!

## What to contribute

* Fixing bug/issues :bug:
* Adding new features/enhancements :sparkles: :star:
* Adding/Updating commands, blocks, texts, ... :pencil2:
* Whatever you want to add with some value for this project :tada:

## Code of Conduct

This project is governed by our [Code of Conduct](./CODE_OF_CONDUCT.md). All participants are expected to
uphold this code. Violations of the code can be reported by contacting us in by [Communication Channels](./CONTACT.md).

## How to contribute

Fork the repo, add or change markdown files, and create a pull request. You can make these changes
via the git web interface, the command line, or a git client of your choice.

Once you create a pull request, we will review and provide feedback, but it might take me some time to comment, review,
or merge it.

### Content Structure

The whole content of the site is under the `docs` folder and uses Markdown as content format. The site is automatically
deployed by GitHub pages after any change in the `main` branch.

Images are stored in the `images` folder inside of the `assets` folder. Don't save any image outside of that folder, and
follows the same structure of the content to identify easily which image is used by which content.

### Before you contribute

To contribute, use Pull Requests, from your own **fork**.

Also, make sure you have set up your Git authorship correctly:

```shell
git config --global user.name "Your Full Name"
git config --global user.email your.email@example.com
```

We use this information to acknowledge your contributions in release announcements.

### Pull Request Process

To integrate changes into the stable branches of the product (main, development) must be done by a
pull request process:

* Create a new branch
* Push commits to the branch.
* Consider whether documentation or tests need to be added or updated as part of the change.
* Verify all tests have passed successfully.
* Open a PR against the target branch of the repository.
	* If the PR is still a work in progress, and so is not ready to be merged, but needs to be pushed to
	facilitate review, then add `[WIP]` in the title. Optionally add the labels `work-in-progress` and `do-not-merge`.
	* Consider identifying committers who have worked on the code being changed.
* Add comments with information about the PR.
* During the Review Process you could add more commits in the PR.
* The PR will be approved when:
	* CI pipeline is successful.
	* Test Coverage is at least the same or higher.
	* A committer reviewed and verified it successfully.
* Committers have the quality vote to approve or reject the PR.
* If your PR is rejected, we will give an explanation for the reasoning and close it.

### Code reviews

All submissions, including submissions by project members, need to be reviewed before being merged.

* Other reviewers, including committers, may comment on the changes and suggest modifications. Changes can
be added by simply pushing more commits to the same branch.
* Please add a comment and "@" the reviewer in the PR if you have addressed reviewers' comments.
* Any conversation must comply with the [Code of Conduct](./CODE_OF_CONDUCT.md) of the community. The outcome
may be a rejection of the entire change.
* Reviewers will typically include the acronym “LGTM” in their approval comment. This is a
convention defined to approve PR before the “approve” it.
* Sometimes, other changes will be merged which conflict with your PR's changes. The PR cannot
be merged until the conflict is resolved.
* Try to be responsive to the discussion rather than let days pass between replies.

## Gathering Feedback

As a community, we strive to provide kind and constructive feedback on your PR.

If a pull request doesn't meet the "must be" guidelines, we may ask that the pull request be updated
before it's merged. If a pull request doesn't meet the "should be" guidelines,
we may merge the pull request and add an issue for future improvements.

Again, thank you so much for your interest and support!

Happy contributing!
