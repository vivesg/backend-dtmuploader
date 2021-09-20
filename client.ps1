Param(
    [string]$caseid,
    [string]$pass,
    [string]$file
)

$filelocation = $file
$filename = ((Get-Item $filelocation)).Name
$sizeoffile = ((Get-Item $filelocation)).length

$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Mobile Safari/537.36 Edg/93.0.961.52"
$session.Cookies.Add((New-Object System.Net.Cookie("SMCsiteLang", "en-US", "/", ".support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("SMCsiteDir", "ltr", "/", ".support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("EXPID", "bad3a5f8-5b94-4e85-acc6-05ab3a33c998", "/", "support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("MicrosoftApplicationsTelemetryDeviceId", "94ffb0ee-c66c-455b-b2af-13d6afd0c917", "/", "support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("smcpartner", "smc", "/", "support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("MC1", "GUID=8c5785b45dd64e76abc96c69ae77fd42&HASH=8c57&LV=202109&V=4&LU=1631928610369", "/", ".microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("MSFPC", "GUID=ebca01620af045668033a89106e8add2&HASH=ebca&LV=202109&V=4&LU=1631928610179", "/", "support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("MSCC", "NR", "/", ".microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("MS-CV", "lS//JQNy40GFav75.0", "/", ".microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("smc_expid", "smc-survey-feat-1|smc-survey-elg-1|vafx-canary-1|vafx-entry-point-2|com-getsupport-1|filterexposuretest|ce-aatest-1|smc-clicktale|sps-premier-msaas-1|vafx-snt-1|sps-ppx-office-1|sps-ppx-nonoffice-1|sps-bcsurvey-1|sps-oasproducts-1|sps-surface-power-1|sps-devices-s2sauth-1|tasmigrationmseg|sps-sc-1|vafx-enginev2-1|sps-details-1|amc-suspend-1|sps-devices-psd2-1|sps-bc-psd2|sps-xbox-power-1|sps-awa-fix-1|vafx-proxybot-1|sps-css-vnext-1|cogs-launchdeeplink-2|multitenanttasmigration_103|vafx-mts-french-azure-1|vafx-mts-german-1|vafx-mts-hungarian-1|vafx-mts-czech-1|vafx-mts-turkish-1|vafx-mts-korean-1|vafx-mts-polish-1|vafx-mts-dutch-1|vafx-mts-italian-1|vafx-mts-russian-1|vafx-mts-danish-1|vafx-mts-norwegian-1|vafx-mts-arabic-1|vafx-mts-swedish-1|vafx-mts-portuguese-1|sps-singlestackuhf-1|amc-quicksearch-1|vafx-darkmode-1", "/", ".support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("MS0", "692d1be7ca2a499f85531e56779a1f49", "/", ".microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("smc_expt", "2021-09-18T21:38:48.4379751Z", "/", ".support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("ai_session", "YLpss2DKP/NoSObq2muJ/p|1631999117674|1632001145159", "/", "support.microsoft.com")))
$verification = Invoke-WebRequest -UseBasicParsing -Uri "https://support.microsoft.com/api/aftoken" `
    -WebSession $session `
    -Headers @{
    "sec-ch-ua"          = "`"Microsoft Edge`";v=`"93`", `" Not;A Brand`";v=`"99`", `"Chromium`";v=`"93`""
    "Accept"             = "application/json, text/plain, */*"
    "Caller-Name"        = "Angular"
    "MS-CV"              = "iAkirL0pakmPzWqj.13"
    "sec-ch-ua-mobile"   = "?1"
    "sec-ch-ua-platform" = "`"Android`""
    "Sec-Fetch-Site"     = "same-origin"
    "Sec-Fetch-Mode"     = "cors"
    "Sec-Fetch-Dest"     = "empty"
    "Accept-Encoding"    = "gzip, deflate, br"
    "Accept-Language"    = "en-US,en;q=0.9"
}

$apicall = $null
$uri = "https://dtmuploader.azurewebsites.net/cases?caseid=" + $caseid + "&pass=" + $pass
$resp = try { 
    $apicall = Invoke-WebRequest -UseBasicParsing -Uri $uri
}
catch { $_.Exception.Response }
if ($resp.IsSuccessStatusCode -eq $false) {
    Write-Host "Failed to get data wrong password or wrong case number or case info not loaded "
    exit
}
if($null -eq $apicall){
    Write-Host('Failed to get data wrong password or wrong case number or case info not loaded ')
    exit
}

$apicall = $apicall.Content | ConvertFrom-Json
$apicall = $apicall.data
$wid = $apicall.wid
$to = $apicall.workspace
$mybody = @"
{"workspaceToken":"$to","email":""}
"@

$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Mobile Safari/537.36 Edg/93.0.961.52"
$session.Cookies.Add((New-Object System.Net.Cookie("SMCsiteLang", "en-US", "/", ".support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("SMCsiteDir", "ltr", "/", ".support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("EXPID", "bad3a5f8-5b94-4e85-acc6-05ab3a33c998", "/", "support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("MicrosoftApplicationsTelemetryDeviceId", "94ffb0ee-c66c-455b-b2af-13d6afd0c917", "/", "support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("smcpartner", "smc", "/", "support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("MC1", "GUID=8c5785b45dd64e76abc96c69ae77fd42&HASH=8c57&LV=202109&V=4&LU=1631928610369", "/", ".microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("MSFPC", "GUID=ebca01620af045668033a89106e8add2&HASH=ebca&LV=202109&V=4&LU=1631928610179", "/", "support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("MSCC", "NR", "/", ".microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("MS-CV", "lS//JQNy40GFav75.0", "/", ".microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("smc_expid", "smc-survey-feat-1|smc-survey-elg-1|vafx-canary-1|vafx-entry-point-2|com-getsupport-1|filterexposuretest|ce-aatest-1|smc-clicktale|sps-premier-msaas-1|vafx-snt-1|sps-ppx-office-1|sps-ppx-nonoffice-1|sps-bcsurvey-1|sps-oasproducts-1|sps-surface-power-1|sps-devices-s2sauth-1|tasmigrationmseg|sps-sc-1|vafx-enginev2-1|sps-details-1|amc-suspend-1|sps-devices-psd2-1|sps-bc-psd2|sps-xbox-power-1|sps-awa-fix-1|vafx-proxybot-1|sps-css-vnext-1|cogs-launchdeeplink-2|multitenanttasmigration_103|vafx-mts-french-azure-1|vafx-mts-german-1|vafx-mts-hungarian-1|vafx-mts-czech-1|vafx-mts-turkish-1|vafx-mts-korean-1|vafx-mts-polish-1|vafx-mts-dutch-1|vafx-mts-italian-1|vafx-mts-russian-1|vafx-mts-danish-1|vafx-mts-norwegian-1|vafx-mts-arabic-1|vafx-mts-swedish-1|vafx-mts-portuguese-1|sps-singlestackuhf-1|amc-quicksearch-1|vafx-darkmode-1", "/", ".support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("MS0", "692d1be7ca2a499f85531e56779a1f49", "/", ".microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("ai_session", "YLpss2DKP/NoSObq2muJ/p|1631999117674|1632001145159", "/", "support.microsoft.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("smc_expt", "2021-09-18T21:38:49.6560985Z", "/", ".support.microsoft.com")))


$tok = 0
$resp = try { 
  
    $tok = Invoke-WebRequest -UseBasicParsing -Uri "https://support.microsoft.com/api/workspaces/AccessTokens?iecbust=1632001145454" `
        -Method "POST" `
        -WebSession $session `
        -Headers @{
        "sec-ch-ua"              = "`"Microsoft Edge`";v=`"93`", `" Not;A Brand`";v=`"99`", `"Chromium`";v=`"93`""
        "sec-ch-ua-mobile"       = "?1"
        "Accept"                 = "application/json, text/plain, */*"
        "Caller-Name"            = "Angular"
        "MS-CV"                  = "iAkirL0pakmPzWqj.14"
        "x-request-verification" = "sNZovdIM0yVXGgYjAqUm7Vfzq2PBsZbcJtbEvOqY0_rYN6u_d_uhUXEJ15VRl2SahlZlRva0uYiYvML61v5wFvhNvuarZDLjHd8pdpuKeuY1:Wf0r_5A8P1dWN4DkhR62poT0s4TE5cVTqhJFI9md8pLdRLDJSQmqFsRA97BwbkxTV7XlmZAiAIrt6htvzivRzisskL7JcnZiEwCT71GGtbs1"
        "sec-ch-ua-platform"     = "`"Android`""
        "Origin"                 = "https://support.microsoft.com"
        "Sec-Fetch-Site"         = "same-origin"
        "Sec-Fetch-Mode"         = "cors"
        "Sec-Fetch-Dest"         = "empty"
       
        "Accept-Encoding"        = "gzip, deflate, br"
        "Accept-Language"        = "en-US,en;q=0.9"
    } `
        -ContentType "application/json" `
        -Body $mybody 
}
catch { $_.Exception.Response }
if ($resp.IsSuccessStatusCode -eq $false) {
    Write-Host "Error getting token failed to upload data"
    exit
}


$tok = $tok.Content | ConvertFrom-Json
$verification = $verification.Content | ConvertFrom-Json

$uri = "https://api.dtmnebula.microsoft.com/api/v1/workspaces/" + $wid + "/folders/external/files/metadata?filename=" + $filename 
$path = "/api/v1/workspaces/$wid/folders/external/files/metadata?filename=" + $filename 


$path = "/api/v1/workspaces/" + $wid + "/folders/external/files?filename=" + $filename
$myheader = @{
    "method"                 = "PUT"
    "authority"              = "api.dtmnebula.microsoft.com"
    "scheme"                 = "https"
    "path"                   = $path
    "sec-ch-ua"              = "`"Microsoft Edge`";v=`"93`", `" Not;A Brand`";v=`"99`", `"Chromium`";v=`"93`""
    "x-request-verification" = $verification 
    "authorization"          = "Bearer " + $tok.accessToken
    "accept"                 = "application/json, text/plain, */*"
    "caller-name"            = "Angular"
    "sec-ch-ua-mobile"       = "?1"
    "overwrite"              = "false"
    "ms-cv"                  = "ER/dxbVIik+guho/.15"
    "partnerid"              = "9E544B52-8471-4B9A-86C2-25768630A8A1"
    "sec-ch-ua-platform"     = "`"Android`""
    "origin"                 = "https://support.microsoft.com"
    "sec-fetch-site"         = "same-site"
    "sec-fetch-mode"         = "cors"
    "sec-fetch-dest"         = "empty"
    "referer"                = "https://support.microsoft.com/"
    "accept-encoding"        = "gzip, deflate, br"
    "accept-language"        = "en-US,en;q=0.9"
}

$uri = "https://api.dtmnebula.microsoft.com/api/v1/workspaces/" + $wid + "/folders/external/files/metadata?filename=" + $filename
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$chunks = [int][Math]::Ceiling(([int]$sizeoffile) / 134217728)
$body = @"
{"chunkSize":134217728,"contentType":"text/xml","fileSize":$sizeoffile,"numberOfChunks":$chunks}
"@


$session.UserAgent = "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Mobile Safari/537.36 Edg/93.0.961.52"

 

$resp = try { 
    $allocate = Invoke-WebRequest -UseBasicParsing -Uri $uri `
        -Method "PUT" `
        -WebSession $session `
        -Headers $myheader `
        -ContentType "application/json" `
        -Body $body
}
catch { $_.Exception.Response } 
if ($resp.IsSuccessStatusCode -eq $false) {
    Write-Host "An error ocurred uploading the data "
    exit
}

$uri = "https://api.dtmnebula.microsoft.com/api/v1/workspaces/" + $wid + "/folders/external/files?filename=" + $filename

$header = @{
    "method"                 = "PATCH"
    "authority"              = "api.dtmnebula.microsoft.com"
    "scheme"                 = "https"
    "path"                   = $path
    "sec-ch-ua"              = "`"Microsoft Edge`";v=`"93`", `" Not;A Brand`";v=`"99`", `"Chromium`";v=`"93`""
    "x-request-verification" = $verification 
    "authorization"          = "Bearer " + $tok.accessToken
    "accept"                 = "application/json, text/plain, */*"
    "caller-name"            = "Angular"
    "sec-ch-ua-mobile"       = "?1"
    "ms-cv"                  = "ER/dxbVIik+guho/.17"
    "chunkindex"             = "0"
    "partnerid"              = "9E544B52-8471-4B9A-86C2-25768630A8A1"
    "sec-ch-ua-platform"     = "`"Android`""
    "origin"                 = "https://support.microsoft.com"
    "sec-fetch-site"         = "same-site"
    "sec-fetch-mode"         = "cors"
    "sec-fetch-dest"         = "empty"
    "referer"                = "https://support.microsoft.com/"
    "accept-encoding"        = "gzip, deflate, br"
    "accept-language"        = "en-US,en;q=0.9"
}


$resp = try { 
    Invoke-RestMethod -Uri $uri -Method Patch -InFile $filelocation -Headers $header 
}
catch { $_.Exception.Response }

if ($resp.IsSuccessStatusCode -ne $false) {
    Write-Host "Success we succesfully uploaded the data "
}