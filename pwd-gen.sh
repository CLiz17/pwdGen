#!/bin/bash

generate_password() {
    length=16
    use_uppercase=$1
    use_lowercase=$2
    use_digits=$3
    use_special_chars=$4

    characters=""
    if [ "$use_uppercase" = "y" ]; then
        characters+="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    fi
    if [ "$use_lowercase" = "y" ]; then
        characters+="abcdefghijklmnopqrstuvwxyz"
    fi
    if [ "$use_digits" = "y" ]; then
        characters+="0123456789"
    fi
    if [ "$use_special_chars" = "y" ]; then
        characters+="+-_!@#$%^&*()=<>?{}[]"
    fi

    if [ -z "$characters" ]; then
        echo "You must select at least one character type."
        return
    fi

    password=$(cat /dev/urandom | tr -dc "$characters" | head -c "$length")
    echo "$password"
}

main() {
    echo "Password Generator"
    read -p "Include uppercase letters? (y/n): " use_uppercase
    read -p "Include lowercase letters? (y/n): " use_lowercase
    read -p "Include digits? (y/n): " use_digits
    read -p "Include special characters? (y/n): " use_special_chars

    password=$(generate_password "$use_uppercase" "$use_lowercase" "$use_digits" "$use_special_chars")

    if [ -n "$password" ]; then
        echo "Generated Password: $password"
        read -p "Enter a filename to save the password: " filename
        echo "$password" > "$filename"
        echo "Password saved to $filename"
    fi
}

main