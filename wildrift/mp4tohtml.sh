#!/bin/bash

# HTMLファイルのヘッダー部分
cat <<EOT > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://matcha.mizu.sh/matcha.css">
    <title>MP4 Videos</title>
</head>
<body>
    <h1>MP4 Videos</h1>
EOT

# MP4ファイルをループしてvideoタグに書き込む
for file in mp4/*.mp4; do
    echo "    <video controls>" >> index.html
    echo "        <source src=\"$file\" type=\"video/mp4\">" >> index.html
    echo "        Your browser does not support the video tag." >> index.html
    echo "    </video>" >> index.html
    echo "    <br>" >> index.html
done

# HTMLファイルのフッター部分
cat <<EOT >> index.html
</body>
</html>
EOT
