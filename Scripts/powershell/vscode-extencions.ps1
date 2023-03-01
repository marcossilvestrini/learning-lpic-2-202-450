code --list-extensions > vs_code_extensions_list.txt
get-content vs_code_extensions_list.txt | % { code --install-extension $_ }