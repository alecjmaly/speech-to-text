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