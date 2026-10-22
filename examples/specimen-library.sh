#!/bin/sh
# Build the guide's specimen media library: five small files,
# all generated, all invented. Requires ffmpeg on PATH.
# Usage: sh specimen-library.sh [target-dir]   (default ./media)
set -eu
M="${1:-media}"
mkdir -p "$M/Movies" "$M/Music/Harbour Lights" "$M/Series/North Pier/Season 01"

# Two "films": test patterns with a tone, a title tag, a year tag.
ffmpeg -f lavfi -i testsrc2=duration=6:size=1280x720:rate=30 \
       -f lavfi -i sine=frequency=440:duration=6 -shortest \
       -c:v libx264 -pix_fmt yuv420p -c:a aac \
       -metadata title="The Clockwork Lighthouse" -metadata date=2021 \
       "$M/Movies/The Clockwork Lighthouse (2021).mp4"

ffmpeg -f lavfi -i smptebars=duration=5:size=640x360:rate=25 \
       -f lavfi -i sine=frequency=330:duration=5 -shortest \
       -c:v libx264 -pix_fmt yuv420p -c:a aac \
       -metadata title="A Field Guide to Clouds" -metadata date=2019 \
       "$M/Movies/A Field Guide to Clouds (2019).mp4"

# One "album": two sine-tone tracks, fully tagged inside the file.
ffmpeg -f lavfi -i sine=frequency=523:duration=4 -c:a flac \
       -metadata title="First Light" -metadata artist="The Paper Boats" \
       -metadata album="Harbour Lights" -metadata track=1 -metadata date=2018 \
       "$M/Music/Harbour Lights/01 - First Light.flac"

ffmpeg -f lavfi -i sine=frequency=392:duration=4 -c:a flac \
       -metadata title="Low Tide" -metadata artist="The Paper Boats" \
       -metadata album="Harbour Lights" -metadata track=2 -metadata date=2018 \
       "$M/Music/Harbour Lights/02 - Low Tide.flac"

# Two "episodes": the two filename shapes chapter 5 compares.
ffmpeg -f lavfi -i testsrc=duration=4:size=854x480:rate=30 \
       -f lavfi -i sine=frequency=262:duration=4 -shortest \
       -c:v libx264 -pix_fmt yuv420p -c:a aac \
       "$M/Series/North Pier/Season 01/North Pier S01E01 - Foghorn.mp4"

ffmpeg -f lavfi -i testsrc=duration=4:size=854x480:rate=30 \
       -f lavfi -i sine=frequency=294:duration=4 -shortest \
       -c:v libx264 -pix_fmt yuv420p -c:a aac \
       "$M/Series/North Pier/Season 01/North Pier - S01E02 - Low Water.mp4"

echo "Specimen library built under $M"
