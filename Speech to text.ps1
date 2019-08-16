
# key obtainable from:
# https://console.cloud.google.com/apis/credentials?project=test-project-200421

## AUDIO
# real: 20180927-200116
$recording="C:\users\alecm\Desktop\output.mp4"
$fileContent = Get-Content $recording -Encoding UTF8
$fileContentBytes = [System.Text.Encoding]::UTF8.GetBytes($fileContent)
$fileContentEncoded = [System.Convert]::ToBase64String($fileContentBytes)

$fileContentEncoded






$uri = "https://speech.googleapis.com/v1/speech:recognize"

$key = "AIz.....U12g"


$header = @{
    "Authorization" = "Bearer $key"
    "Content-Type" = "application/json"
}


$body = '{
    "config" : { 
        "encoding" : "FLAC",
        "sampleRateHertz" : 16000,
        "languageCode" : "en-US",
     },
     "audio" : {
        "content" : "' + $fileContentEncoded + '"
     }

}'

$body



try {
    $resp = Invoke-RestMethod -Method Post -Uri "https://speech.googleapis.com/v1/speech:recognize?key=$key" -Body $body -ContentType "application/json"
    $resp
} catch {
    $err = $_
    write-host $err
}



$fileContentEncoded | set-content ("c:\output.b64")




