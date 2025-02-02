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
