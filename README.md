# Actions

## Overview
In this project, I am going to be adding some GitHub Actions needed for continuous integration and deployment, in the context of PCI Studio projects.


## sync-develop

This action help to automatically synchronize the develop branch, once is merge and squash with main.  

### Usage:

```yaml
  - name:
    uses: pcistudio/actions/sync-develop@v1
    with:
        main-branch: main
        develop-branch: develop
        ssh-key: ${{ secrets.SSH_KEY }}
        user-email: "release-bot"
        user-name: "release-bot@email.com"
```

### Inputs Parameters

| Name | Description | Default        | Required |
|------|-------------|----------------|----------|
| main-branch | The branch that you want to merge and squash with the develop branch | current branch | false    |
| develop-branch | The branch, that you want to synchronize after the merge and squash build happen | develop | true     |
| ssh-key | SSH key used to fetch the repository | | true     |
| user-name | The name of the user that will be used to commit the changes | release-bot | false    |
| user-email | The email of the user that will be used to commit the changes | | true     |


## ssh-gen

This action help to automatically.
1. Generate the ssh keys
2. Store the private key in a `secret` 
3. Store the public is set in the `Deploy keys` of the repository.

### Usage:

```yaml

  - name: Configure SSH Key
    uses: pcistudio/actions/ssh-gen@v1
    with:
      ssh-key-name: "SSH_PRIVATE_KEY"
      user-email: ${{ vars.RELEASE_EMAIL }}
      personal-token: PAT_TOKEN
```

### Inputs Parameters

| Name | Description                                                        | Default                           | Required |
|------|--------------------------------------------------------------------|-----------------------------------|----------|
| ssh-key-name | The name of the secret that will have the ssh key                  | `SSH_PRIVATE_KEY`                                  | false    |
| user-email | The email of the user that will be used to generate the ssh key    |                                   | true     |
| token | The token use to store the key in the secrets. Needs to be a PAT   |                                   | true     |
| repo | The repository were you want to create the secret with the SSH KEY | current repo `${github.repository}` | false    |


## ssh-setup
This action help to automatically set up the ssh key in the runner.

### Usage:

```yaml
    - name: Setup SSH
      uses: pcistudio/actions/ssh-setup@v1
      with:
        ssh-key: ${{ secrets.SSH_PRIVATE_KEY }}
```


## release

This action automates the release of Java artifacts with Maven, publishing them to Maven Central while also releasing them on GitHub.

### Usage:

```yaml
  - name: Release
    uses: pcistudio/actions/release@v1
    with:
      ssh-key: ${{ secrets.SSH_PRIVATE_KEY_RELEASE }}
      ssh-key-name: "SSH_PRIVATE_KEY_RELEASE"
      user-email: "release-bot"
      user-name: "email@gail.com"
      token: "${{ secrets.personal_access_token }}"
      maven-central-username: "${{ secrets.maven_central_username }}"
      maven-central-password: "${{ secrets.maven_central_password }}"
      gpg-passphrase: "${{ secrets.gpg_passphrase }}"
      gpg-private-key: "${{ secrets.gpg_private_key }}"
      server-id: "${{ secrets.server_id }}"
      gh-token: "${{ secrets.GH_TOKEN }}"
```
