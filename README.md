# Speech to Text
This project will convert an audio file .mp4 to text on a Windows computer.
Google Documentation
    - [Recognize](https://cloud.google.com/sdk/gcloud/reference/ml/speech/recognize)
    - [Recognize Long Running](https://cloud.google.com/sdk/gcloud/reference/ml/speech/recognize-long-running)

#### Steps
1) Convert .mp4 (or other audio file) to mono channel FLAC (.flac) using [VLC Media Player](https://www.videolan.org/vlc/index.html)
2) Upload output file to [Google Cloud Storage](https://console.cloud.google.com/storage/browser?project=test-project-200421&folder&organizationId)
3) Using [Google Cloud SDK Shell](https://cloud.google.com/sdk/docs/quickstart-windows)

Login if needed 
``` 
gcloud auth login
```
Run speach command and output to .json file to analyze
```
gcloud ml speech recognize-long-running gs://alec_test/newRecording.flac --language-code=en-US > "%UserProfile%\Desktop\output.json
```
4) Use PowerShell to extract text from the JSON output
```
## set variables
$input_file = "$($env:USERPROFILE)/Desktop/output.json" 
$output_file = "$($env:USERPROFILE)/Desktop/transcript.csv" 

# remove file if it exists
if (Test-Path -Path $output_file) {
    Remove-Item -Path $output_file
}

# get Google Cloud output
$json = Get-Content $input_file | ConvertFrom-Json 

# extract text
foreach ($item in $json.results) {
    $obj = New-Object PSObject -Property @{
        'confidence'=$item.alternatives.confidence;
        'transcript'=$item.alternatives.transcript 
    }
    $obj| Export-Csv -Path $output_file -NoTypeInformation -Append
}
```
5) From .csv output, use a program such as Excel to evaluate each line and it's translation confidence. You may use the Excel function TEXTJOIN in modern versions of excel to join all the text together into a single block and move to your favorite text editor.
```
TEXTJOIN
```

# Notes
- If needed, Google API creds can be found here [Google Cloud Console](https://console.cloud.google.com/apis/credentials)
- Maybe one day I'll automate this process, if I ever have to do it enough...

