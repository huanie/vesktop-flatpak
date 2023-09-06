#!/bin/bash
FLATPAK_ID=${FLATPAK_ID:-"dev.vencord.Vesktop"}

FLAGS='--enable-gpu-rasterization --enable-zero-copy --enable-gpu-compositing --enable-native-gpu-memory-buffers --enable-oop-rasterization --enable-features=UseSkiaRenderer,WaylandWindowDecorations'

WAYLAND_SOCKET=${WAYLAND_DISPLAY:-"wayland-0"}

if [[ -e "$XDG_RUNTIME_DIR/${WAYLAND_SOCKET}" ]]
then
    FLAGS="$FLAGS --ozone-platform-hint=auto"
fi

if [[ $XDG_SESSION_TYPE == "wayland" ]] && [ -c /dev/nvidia0 ]
then
    FLAGS="$FLAGS --use-gl=desktop"
fi

env TMPDIR=$XDG_CACHE_HOME zypak-wrapper /app/vesktop/vencorddesktop $FLAGS "$@"
