param( )

          # use this function to invoke the scripts locally with a PAT token
          function getAuthToken($user, $accessToken) {
            $userString = "{0}:{1}" -f $user, $accessToken
            $base64String = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($userString))
            return "Basic {0}" -f $base64String
          }
          
          function getOAuthToken() {
            return "Bearer {0}" -f $env:SYSTEM_ACCESSTOKEN
          }
          
          function getServerUrl() {
            return [string]::Format("https://{0}{1}", $env:SYSTEM_TEAMFOUNDATIONCOLLECTIONURI, $env:SYSTEM_TEAMPROJECTID)
          }
          
          function InvokeRestApi($relativeUri, $authHeader) {
             $baseUrl = getServerUrl
             $url = [Uri]::EscapeUriString((getServerUrl) + $relativeUri + "?api-version=5.0")
             Write-Host "Querying:" $url
             return Invoke-WebRequest $url -Headers @{Authorization=($authHeader)} | ConvertFrom-Json
          }
          
          $auth = getAuthToken
          
          $url =  "/release/deployments?definitionId=" + $env:RELEASE_DEFINITIONID
          $url += "&definitionEnvironmentId=" + $env:RELEASE_DEFINITIONENVIRONMENTID
          $url += "&deploymentStatus=succeeded"
          $url += "&queryOrder=descending"
          
          $json = InvokeRestApi $url $auth
          
          $lastRelease = $json.value[0]
          Write-Host "Last release:" $lastRelease