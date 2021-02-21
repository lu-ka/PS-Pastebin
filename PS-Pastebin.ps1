<# 
.SYNOPSIS Powershell Pastebin API by github.com/lu-ka

.DESCRIPTION This script posts a paste to Pastebin. (currently only with an Pastebin account, slight modification for posting as guest needed)

.NOTES For possible options visit https://pastebin.com/doc_api.

.EXAMPLE .\PS-Pastebin.ps1 -k "mydevkey" -u "myusername" -p "mypassword" -msg "Hello World!"

.LINK https://pastebin.com/doc_api

.PARAMETER k Pastebin developer key (required, example "mydevkey")
.PARAMETER u Pastebin username (required, example "myusername")
.PARAMETER p Pastebin password (required, example "mypassword")
.PARAMETER msg code to paste (required, example "Hello World!")
.PARAMETER v paste visibility (optional, example "2")
.PARAMETER t paste name/title (optional, example "My first API paste")
.PARAMETER d paste expire date (optional, example "10M")
.PARAMETER f paste format (optional, example "php")
#>

param (

    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$k = 'mydevkey',

    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$u = 'myusername',

    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$p = 'mypassword',

    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$msg = 'Hello World!',

    [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
    $v = $null,

    [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
    [string]$t = $null,

    [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
    [string]$d = $null,

    [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
    [string]$f = $null
)

function PastebinPost{

    # body for login request
    $body_login = @{
        api_dev_key = $k
        api_user_name = $u
        api_user_password = $p
    }

    # login request to Pastebin for temporary API key
    $api_user_key = Invoke-RestMethod -Method Post -Uri "https://pastebin.com/api/api_login.php" -Body $body_login

    # if $api_user_key is empty there was probably an authentication error
    if ($null -eq $api_user_key) {
        Write-Host -ForegroundColor Red "AUTHENTICATION ERROR"
        Write-Host -ForegroundColor Red "Please check network connectivity, username, password or developer key"
        Write-Host ""
        exit
    } else {
        # body for post request
        $body_post = @{
        api_option = "paste"
        api_user_key = $api_user_key
        api_paste_private = $v
        api_dev_key = $k
        api_paste_code = $msg
        api_paste_name = $t
        api_paste_expire_date = $d
        api_paste_format = $f
    }
        # post request to Pastebin
        Invoke-RestMethod -Method Post -Uri "https://pastebin.com/api/api_post.php" -Body $body_post
    }
}

PastebinPost