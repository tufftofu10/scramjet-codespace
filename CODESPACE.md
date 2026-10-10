# Your Scramjet Codespace

Open this repository's Codespace and then open port **4141** from the **Ports** panel. Keep the port **Private**. GitHub sign-in protects both Scramjet and Wisp.

Wisp runs inside the Codespace. Websites opened inside Scramjet use the Codespace's internet connection. Your normal browser tabs still use your usual connection.

Setup runs once when creating a Codespace. Scramjet starts automatically when the Codespace starts again. The first build takes several minutes.

To start manually: `bash .devcontainer/start.sh`.

To view startup errors: `tail -n 80 /tmp/scramjet.log`.

Stop the Codespace from https://github.com/codespaces when finished; reopen it there for your next session. There is no added session timer or daily session limit. GitHub's own idle timeout, account quota and billing still apply.

The Wisp URL is automatically set to this Codespace's HTTPS forwarded address using `/wisp/`. If old browser settings override it, use **Reset** in Scramjet Settings. Wisp only allows public internet destinations.
