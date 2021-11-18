# dotfiles

This configuration is mainly used in combination with GitHub Codespaces.
In order to setup a test containers run:

```sh
./run_test_container.sh
```

This will run a shell into a ubuntu container and mount the dotfiles directory.
From the shell you can run:

```sh
cd dotfiles
./install
```
