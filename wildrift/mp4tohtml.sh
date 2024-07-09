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
    <style>
        .video-container {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <h1>MP4 Videos</h1>
EOT

# MP4ファイルをループしてvideoタグに書き込む（data-src属性を使用）
for file in mp4/*.mp4; do
    echo "    <div class=\"video-container\">" >> index.html
    echo "        <video controls preload=\"none\" data-src=\"$file\">" >> index.html
    echo "            <source type=\"video/mp4\">" >> index.html
    echo "            Your browser does not support the video tag." >> index.html
    echo "        </video>" >> index.html
    echo "    </div>" >> index.html
done

# HTMLファイルのフッター部分とJavaScript
cat <<EOT >> index.html
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const videos = document.querySelectorAll("video[data-src]");
            const options = {
                root: null,
                rootMargin: "0px",
                threshold: 0.25
            };

            const videoObserver = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const video = entry.target;
                        video.src = video.getAttribute("data-src");
                        video.removeAttribute("data-src");
                        observer.unobserve(video);
                    }
                });
            }, options);

            videos.forEach(video => {
                videoObserver.observe(video);
            });
        });
    </script>
</body>
</html>
EOT
