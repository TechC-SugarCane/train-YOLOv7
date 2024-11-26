# winget install --id GnuWin32.UnZip

param(
    [string]$SugarcaneUrl,
    [string]$PineappleUrl
)

$dataset_dir = "datasets"

function Download-Dataset {
    param (
        [string]$name,
        [string]$url
    )

    $download_dataset_dir = "$dataset_dir\$name"
    if (Test-Path -Path $download_dataset_dir) {
        Write-Host "$name dataset already exists."
        $response = Read-Host "Do you want to remove it? (y/n)"
        if ($response -eq 'y' -or $response -eq 'Y') {
            Remove-Item -Recurse -Force -Path $download_dataset_dir
        } else {
            exit 0
        }
    }

    New-Item -ItemType Directory -Path $download_dataset_dir | Out-Null
    Write-Host "Downloading $name dataset..."
    Invoke-WebRequest -Uri $url -OutFile "roboflow.zip"
    Expand-Archive -Path "roboflow.zip" -DestinationPath $download_dataset_dir
    Remove-Item -Path "roboflow.zip"

    # data.yamlを書き換える
    (Get-Content "$download_dataset_dir\data.yaml") -replace "\.\.\/", "$dataset_dir/$name/" | Set-Content "$download_dataset_dir\data.yaml"

    Write-Host "$name dataset downloaded."
}

# Download sugarcane dataset
Download-Dataset -name "sugarcane" -url $SugarcaneUrl

# Download pineapple dataset
Download-Dataset -name "pineapple" -url $PineappleUrl
