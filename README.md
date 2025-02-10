# Subose
SubRecon is an automated subdomain reconnaissance tool designed for ethical hackers, penetration testers, and bug bounty hunters. This tool helps identify active subdomains, extract IP addresses, check server status, and perform reverse IP lookups in a fast and efficient way.


# 🕵️‍♂️ SubRecon - Advanced Bug Bounty Subdomain Scanner  

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)  
[![Made with Ruby](https://img.shields.io/badge/Made%20with-Ruby-red.svg)](https://www.ruby-lang.org/en/)  
[![Ethical Hacking Tool](https://img.shields.io/badge/Ethical%20Hacking-Bug%20Bounty-orange)](https://github.com/iBlameHannibal/)  

SubRecon is an advanced **subdomain enumeration** and **IP discovery** tool built for **ethical bug bounty hunters**. It scans a given website, identifies **subdomains**, checks their **status**, and saves results in a clean report file.  

⚠️ **DISCLAIMER**: This tool is for educational and ethical hacking purposes only. Unauthorized use against websites you don’t own or have permission to test is **illegal** and may result in severe legal consequences. The author is not responsible for any misuse of this tool.  

---

## 🎯 **Features**  
✅ Extracts the main domain and resolves its IP  
✅ Performs **subdomain enumeration** from a predefined list  
✅ Checks if subdomains are **alive or down**  
✅ Supports **reverse IP lookup**  
✅ Saves results in a structured **TXT file**  
✅ Color-coded **CLI output** for better readability  
✅ Fully **automated input validation**  

---

## 🚀 **Installation**  
Ensure you have **Ruby** installed on your system.  

### **1️⃣ Clone the Repository**  
```bash
git clone https://github.com/iBlameHannibal/SubRecon.git
cd SubRecon
ruby subose.rb
