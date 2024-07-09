#!/bin/bash

# 日付部分が指定されていない場合はエラーメッセージを表示して終了
if [ -z "$1" ]; then
    echo "Usage: $0 <date-part>"
    echo "Example: $0 20240705"
    exit 1
fi

TARGET_DATE="$1"
MP4_DIR="mp4"
OUTPUT_HTML="$TARGET_DATE.html"

# HTMLのヘッダー部分
cat <<EOL > $OUTPUT_HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://matcha.mizu.sh/matcha.css">
    <title>Video List for $TARGET_DATE</title>
</head>
<body>
<h1>Videos for $TARGET_DATE</h1>
EOL

# 指定した日付部分を持つMP4ファイルを検索してHTMLに追加
for file in $MP4_DIR/*$TARGET_DATE*.mp4; do
    if [ -e "$file" ]; then
        echo "<video controls>" >> $OUTPUT_HTML
        echo "  <source src=\"$file\" type=\"video/mp4\">" >> $OUTPUT_HTML
        echo "  Your browser does not support the video tag." >> $OUTPUT_HTML
        echo "</video><br>" >> $OUTPUT_HTML
    fi
done

# HTMLのフッター部分
cat <<EOL >> $OUTPUT_HTML
</body>
</html>
EOL

echo "HTML file $OUTPUT_HTML has been generated."
