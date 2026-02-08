# 🌐 Shecan DNS Manager

A simple and elegant bash script to manage [Shecan](https://shecan.ir) DNS settings on Linux systems using NetworkManager.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Bash](https://img.shields.io/badge/bash-5.0%2B-green.svg)
![Platform](https://img.shields.io/badge/platform-Linux-lightgrey.svg)

## ✨ Features

- 🔄 **Auto-detection** of active network connection
- 🎯 **Interactive prompts** for easy configuration
- ⚡ **Progress spinners** for visual feedback
- 🆓 Support for both **Free** and **Pro** Shecan plans
- 🔧 Easy DNS configuration with a single command
- 🔌 Quick enable/disable functionality
- 📡 Automatic DDNS update for Pro users

## 📋 Prerequisites

- Linux system with NetworkManager
- `nmcli` command-line tool (usually pre-installed)
- `curl` for DDNS updates (Pro plan)
- Bash 4.0 or higher

## 🚀 Installation

1. Clone this repository:

```bash
git clone https://github.com/alireza-aliabadi/shecan.git
cd shecan
```

2. Make the script executable:

```bash
chmod +x shecan.sh
```

3. (Optional) Create a symlink for easy access:

```bash
sudo ln -s "$(pwd)/shecan.sh" /usr/local/bin/shecan
```

## 📖 Usage

Run the script:

```bash
./shecan.sh
```

Or if you created a symlink:

```bash
shecan
```

### Interactive Prompts

The script will guide you through the following steps:

1. **Choose action**: `apply` or `disable`
   - `apply`: Configure Shecan DNS on your network
   - `disable`: Remove Shecan DNS and restore default settings

2. **Select plan** (only when applying):
   - `free`: Use Shecan free DNS servers
   - `pro`: Use Shecan Pro DNS servers

3. **Enter IP update link** (only for Pro plan):
   - Provide your DDNS update URL from Shecan panel
   - Leave empty to skip automatic IP update

### Example Session

```
$ ./shecan.sh
Which action do you wanna run? [apply|disable]: apply
Detected active connection: WiFi-Home
What's your Shecan plan? [free|pro]: pro
Enter your IP update link: https://ddns.shecan.ir/update?password=YOUR_PASSWORD
⠋ Configuring DNS...
⠙ Setting auto-dns...
⠹ Reconnecting network...
⠸ Waiting for network stabilization...
⠼ Updating Shecan DDNS...
✅ Shecan applied successfully!
```

## 🔧 How It Works

The script performs the following operations:

### Apply Mode

1. Detects your active network connection automatically
2. Configures DNS servers based on your plan:
   - **Free**: `178.22.122.100`, `185.51.200.2`
   - **Pro**: `178.22.122.101`, `185.51.200.1`
3. Disables automatic DNS to prevent overrides
4. Reconnects the network to apply changes
5. Updates DDNS (Pro plan only, if link provided)

### Disable Mode

1. Removes custom DNS settings
2. Re-enables automatic DNS
3. Reconnects the network to restore defaults

## 🎨 Features Breakdown

### Auto-Connection Detection

The script automatically detects your active network connection using `nmcli`, so you don't need to manually specify it.

### Progress Spinners

Beautiful animated spinners provide real-time feedback for each operation:

- Configuring DNS
- Setting auto-dns
- Reconnecting network
- Waiting for stabilization
- Updating DDNS

### Error Handling

- Validates user input
- Checks for active network connections
- Provides clear error messages

## 🛡️ About Shecan

[Shecan](https://shecan.ir) is a DNS service that helps users bypass internet restrictions and access blocked websites. It offers both free and premium plans.

### DNS Servers

| Plan | Primary DNS    | Secondary DNS |
| ---- | -------------- | ------------- |
| Free | 178.22.122.100 | 185.51.200.2  |
| Pro  | 178.22.122.101 | 185.51.200.1  |

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Disclaimer

This script modifies your network DNS settings. Use at your own risk. Always ensure you understand what the script does before running it.

## 🙏 Acknowledgments

- [Shecan](https://shecan.ir) for providing DNS services
- NetworkManager team for the excellent `nmcli` tool

## 📧 Contact

If you have any questions or suggestions, feel free to open an issue or contact me.

---

**Made with ❤️ for easier DNS management**
