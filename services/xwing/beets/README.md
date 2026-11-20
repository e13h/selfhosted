Reassign an album to a different musicbrainz ID after it's been imported

```
beet import -L -S be35101b-be24-4f91-9da8-24e1d01ad5a4 --from-scratch --set navidrome_library=kids album:aladdin
```

Set `navidrome_library`

```
beet modify --move -a navidrome_library=kids album:aladdin
```
