# ------------------------------------------------------------
# HomeAssistant - Install Add-on 'Node-RED'
# ------------------------------------------------------------
#
# Install "Node-RED" Home Assistant Add-On
#

# 1. Search the Home Assistant "Add-On Store" for "Node-RED" and install it


# ------------------------------------------------------------
#
# Install Dark Theme for Node-RED  (Node-RED Contrib Theme Collection)
#

# 1. Install HomeAssistant Add-on "Terminal & SSH"

# 2. Open terminal into HomeAssistant backend

# 3. Install Node.JS && NPM
apk add --update nodejs; apk add --update npm;

# 4. Verify Node & NPM are installed and working as-intended
command -v node; node --version; command -v npm; npm --version;

# 5. Locate Node-RED's NPM configuration directory:
find "/" -type 'f' -iname "*node-red*" 2>/dev/null;

# 6. Install the community themes package into Node-RED's NPM configuration directory:
cd "/config/node-red"; npm install "@node-red-contrib-themes/theme-collection";

# 7. View the Node "settings.js" file's current contents
cat "/config/node-red/settings.js" | grep -v '^\(\(      //\)\|\(    //\)\|\(  //\)\|\($\)\|\( \*\)\|\(\/\*\)\)';

# 8. Set theme: "<theme-name>" in the editorTheme object in your settings.js
vi "/config/node-red/settings.js";
# ...
# editorTheme: {
#    projects: {
#      enabled: false,
#    },
#    theme: "dark",
# },
# ...
#
# Save and quit via ":wq" + Enter

# 9. Restart the "Node-RED" Add-on, then open it and verify that the dark theme is working as-intended

# 10. Additional themes are listed on the NPM package's GitHub page @ https://github.com/node-red-contrib-themes/theme-collection#install-with-npm

#
# Good themes (as-of 2022-11-26):
#
#  ⭐⭐⭐   midnight-red
#  ⭐⭐     zenburn
#  ⭐⭐     dark
#  ⭐       oled
#  ⭐       monokai
#
#

# Copy and paste into "/config/node-red/settings.js" (under "editorTheme")

    theme: "midnight-red",
    // theme: "zenburn",
    // theme: "dark",
    // theme: "oled",
    // theme: "monokai",


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.home-assistant.io  |  "Home Assistant Community Add-on: Node-RED - Home Assistant OS - Home Assistant Community"  |  https://community.home-assistant.io/t/home-assistant-community-add-on-node-red/55023
#
#   github.com  |  "GitHub - node-red-contrib-themes/theme-collection: A collection of themes for Node-RED"  |  https://github.com/node-red-contrib-themes/theme-collection#install-with-npm
#
#   www.juanmtech.com  |  "How to get started with Node-RED and Home Assistant | JuanMTech"  |  https://www.juanmtech.com/get-started-with-node-red-and-home-assistant/
#
# ------------------------------------------------------------