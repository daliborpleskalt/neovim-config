#!/bin/bash
# Neovim Lua Configuration Syntax Checker

echo "🔍 Checking Neovim Lua configuration syntax..."
echo ""

# Function to check a single file using Neovim
check_file() {
    local file="$1"
    local filename=$(basename "$file")

    if [[ ! -f "$file" ]]; then
        echo "  $filename: ⚠️  FILE NOT FOUND"
        return
    fi

    # Use Neovim to check syntax by trying to load the file
    if nvim --headless -c "lua dofile('$file')" -c "qa!" 2>/dev/null; then
        echo "  $filename: ✅ OK"
    else
        echo "  $filename: ❌ SYNTAX ERROR"
        echo "    Error details:"
        nvim --headless -c "lua dofile('$file')" -c "qa!" 2>&1 | grep -E "(Error|error)" | head -3 | sed 's/^/    /'
    fi
}

# Check core configuration files
echo "📁 Core Configuration Files:"
check_file ~/.config/nvim/init.lua
check_file ~/.config/nvim/lua/config/options.lua  
check_file ~/.config/nvim/lua/config/keymaps.lua
check_file ~/.config/nvim/lua/config/lazy.lua
check_file ~/.config/nvim/lua/config/security.lua

echo ""
echo "📁 Plugin Configuration Files:"
for file in ~/.config/nvim/lua/plugins/*.lua; do
    if [[ -f "$file" ]]; then
        check_file "$file"
    fi
done

echo ""
echo "🚀 Alternative: Test with Neovim directly"
echo "   Run: nvim --headless -c 'lua print("Config loaded successfully!")' -c 'qa!'"
echo ""
echo "🔧 If you see errors, the specific line numbers will help you fix them"
