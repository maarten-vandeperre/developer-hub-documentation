---
layout: default
title: Github Token(s) Generation
---

# Github Token(s) Generation

In order to work with Developer Hub and GitHub integrations, you will need to extract a personal access token (i.e., PAT) and an application, via which 
you can integrate with GitHub.
Official GitHub documentation to get these tokens can be found over here:
* Create git app: 
  * [https://docs.github.com/en/apps/creating-github-apps/registering-a-github-app/registering-a-github-app](https://docs.github.com/en/apps/creating-github-apps/registering-a-github-app/registering-a-github-app)
  * [https://backstage.io/docs/integrations/github/github-apps/](https://backstage.io/docs/integrations/github/github-apps/)
  * **!!!important:** In case you want to enable GitHub authentication, you will need to add the base url of Developer Hub as the callback URL.
* Create personal access token: 
  * [https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)

# Token scopes
When creating a personal access token on GitHub, you must select scopes to define the level of access for the token.
The scopes required vary depending on your use of the integration, but these are the ones I added:

* Reading software components:
  * repo 
* Reading organization data:
  * read:org
  * read:user
  * user:email
* Publishing software templates:    
  * repo
  * workflow (if templates include GitHub workflows)