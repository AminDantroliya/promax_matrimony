
@echo off
title Decrypt Environment File

echo ==========================================
echo |     ENV FILE DECRYPTION AND ENCRYPTION |
echo ==========================================
echo.

echo For the GPG password, please contact the Amin Dantroliya.
echo.

ENCRYPT_COMMAND-1.> : & "C:\Program Files\Git\usr\bin\gpg.exe" --no-symkey-cache --yes --symmetric --cipher-algo AES256 --output .env.gpg .env
ENCRYPT_COMMAND-2.> : & "C:\Program Files\Git\usr\bin\gpg.exe" --no-symkey-cache --yes --symmetric --cipher-algo AES256 --output .env.dev.gpg .env.dev
ENCRYPT_COMMAND-3.> : & "C:\Program Files\Git\usr\bin\gpg.exe" --no-symkey-cache --yes --symmetric --cipher-algo AES256 --output .env.prod.gpg .env.prod

DECRYPT_COMMAND-1.> : & "C:\Program Files\Git\usr\bin\gpg.exe" --no-symkey-cache --output .env --decrypt .env.gpg
DECRYPT_COMMAND-2.> : & "C:\Program Files\Git\usr\bin\gpg.exe" --no-symkey-cache --output .env.dev --decrypt .env.dev.gpg
DECRYPT_COMMAND-3.> : & "C:\Program Files\Git\usr\bin\gpg.exe" --no-symkey-cache --output .env.prod --decrypt .env.prod.gpg

echo.
echo SUCCESS: .env file created successfully!
pause
