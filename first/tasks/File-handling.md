# How to deal with files

## Options:
- File as an input
- File as output
- Ability to download and upload files

## File locations
- Application - workspace global
- Instance - persist for 1 instance
- Temp - local container

## Example code
```
$localPath = $ark.DownloadInstanceFile('foo')
my-command -InputPath $localPath -OutputPath $newPath
$ark.UploadInstanceFile('out-file', $newPath)
```