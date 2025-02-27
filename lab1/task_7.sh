grep -E -o "[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" etc > emails.lst
echo "Файл emails.lst создан."
