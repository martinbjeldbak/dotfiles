oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_modern.omp.json" | Invoke-Expression

function streaml() {
    param(
        [string] $streamer
    )

    Start-Process -FilePath "C:\Program Files\Mozilla Firefox\firefox.exe" "--new-window https://www.twitch.tv/popout/$streamer/chat?popout="

    Start-Process -FilePath "streamlink.exe" "twitch.tv/$streamer best"
}