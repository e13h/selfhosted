Command to sync iTunes purchases

```
rsync -avh --progress \                                          
  ~/Music/Music/Media.localized/Music/ \
  xwing:~/appdata/apps/beets/ingest/
```
