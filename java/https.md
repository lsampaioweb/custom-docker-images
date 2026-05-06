Enabling HTTPS in a Spring Boot application ensures that traffic between client and server is encrypted.

1. Store the keystore password in your secret manager.

   ```bash
   secret-tool store --label="ssl.my-app-01.local" password "ssl.my-app-01.local"
   ```

2. Confirm the secret was saved correctly.

   ```bash
   secret-tool lookup password "ssl.my-app-01.local"
   ```

3. Add an environment variable in your shell profile (for example, `~/.bashrc`).

   Use an app-specific variable name to avoid collisions.

   ```bash
   nano ~/.bashrc
   export KEY_STORE_SSL_PASSWORD_MY_APP_01=$(secret-tool lookup password "ssl.my-app-01.local")
   ```

4. Reload your shell profile.

   ```bash
   source ~/.bashrc
   ```

[Go Back](README.md)
