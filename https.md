Enabling HTTPS in a Spring Boot application ensures that the data transmitted between the client and server is encrypted, enhancing the security of your application.

1. Save the password of the Private Key in the Secret Manager.

    ```bash
    secret-tool store --label="ssl.my-app-01.lan.homelab" password "ssl.my-app-01.lan.homelab"
    ```

1. Confirm the password was correctly saved.
    ```bash
    secret-tool lookup password "ssl.my-app-01.lan.homelab"
    ```

1. Add the Environmente variable in the `~/.bashrc` file.

    To avoid conflicts with other applications, name the environment variable uniquely, e.g: `KEY_STORE_SSL_PASSWORD_MY_APP_01`.
    ```bash
    nano ~/.bashrc
    export KEY_STORE_SSL_PASSWORD_MY_APP_01=$(secret-tool lookup password "ssl.my-app-01.lan.homelab")
    ```

1. Reload your bash to load the new environment variable.
    ```bash
    source ~/.bashrc
    ```

[Go Back](README.md)
