---
layout: default
title: Enable GitHub Organization
---

# Enable GitHub Organization
In order to not share personal access tokens of private accounts, it's better to work
with GitHub organizations. We'll create an organization and use it to get our repo scanning working later on.

## Step 1 - Create GitHub organization
Go to your organizations  

<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/your_organizations.png" class="large">  

and create a new organization  

<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/create_github_organization.png" class="large">  

I will go with a free organization for now, which I name [Developer-Hub-Demo-Organization](https://github.com/Developer-Hub-Demo-Organization)

## Step 2 - Create personal access token for organization
1. Go to organizations, and click on the settings button for the organization you want to configure.
2. Go to personal access tokens in the left submenu  
   <img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/organization_pat.png" class="large">  
3. I've created a token with the following standards:
   * Allow access via fine-grained personal access tokens
   * Do not require administrator approval
   * Allow access via personal access tokens (classic)
   * Click enroll

## Step 3 - Create GitHub app for orgnization
1. Go to GitHub apps  
<img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/go_to_github_apps.png" class="large">  
2. Click "new GitHub app"
3. I named mine "Dev Hub App - Maarten"
4. You can fill whatever you want as homepage URL. I went for my [LinkedIn profile](https://www.linkedin.com/in/maarten-vandeperre-8780743b/)
5. Callback URL is not needed if you do not want to authenticate with GitHub
6. Webhook active can be unchecked
7. Add permissions as described [over here](https://backstage.io/docs/integrations/github/github-apps/#app-permissions). At the time of writing, it is:
   * **Reading software components:**
     * Contents: Read-only 
     * Commit statuses: Read-only 
   * **Reading organization data:**
     * Members: Read-only 
   * **Publishing software templates:**
     * Administration: Read & write (for creating repositories)
     * Contents: Read & write 
     * Metadata: Read-only
     * Pull requests: Read & write 
     * Issues: Read & write 
     * Workflows: Read & write (if templates include GitHub workflows)
     * Variables: Read & write (if templates include GitHub Action Repository Variables)
     * Secrets: Read & write (if templates include GitHub Action Repository Secrets)
     * Environments: Read & write (if templates include GitHub Environments)
8. Click create GitHub app
9. Take App ID and Client ID as you will need them later on.
10. Create and save a client secret.
11. Click "save changes"
12. Generate and save the private key.

## Step 4 - Install the GitHub app
1. Open the app
2. Go to Install App submenu item  
   <img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/install_github_app.png" class="large">
3. Click "install"
4. I selected "all repositories"
5. Click "install"
6. App should have the status "Installed x minutes ago" now.
   <img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/installed_app.png" class="large">
7. Get the installation ID from the URL.
   <img src="https://raw.githubusercontent.com/maarten-vandeperre/developer-hub-documentation/main/images/app_installation_id.png" class="large">

## Step 5 - Get the personal access token for the GitHub app
1. Install [github-app-installation-token](https://www.npmjs.com/package/github-app-installation-token)
2. Run the command
3. Store the token, which should look like ghs_................................izI3

