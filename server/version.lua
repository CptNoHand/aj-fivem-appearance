local label = 
[[ 
  //
  || 
  ||  
  ||      __ _                                                                                
  ||     / _(_)                                                                               
  ||    | |_ ___   _____ _ __ ___ ______ __ _ _ __  _ __   ___  __ _ _ __ __ _ _ __   ___ ___ 
  ||    |  _| \ \ / / _ \ '_ ` _ \______/ _` | '_ \| '_ \ / _ \/ _` | '__/ _` | '_ \ / __/ _ \
  ||    | | | |\ V /  __/ | | | | |    | (_| | |_) | |_) |  __/ (_| | | | (_| | | | | (_|  __/
  ||    |_| |_| \_/ \___|_| |_| |_|     \__,_| .__/| .__/ \___|\__,_|_|  \__,_|_| |_|\___\___|
  ||                                         | |   | |                                        
  ||                                         |_|   |_|                                        
  ||    ^3Fixed and converted by ihyajb#9723^0                                     
  ||]]
  
Citizen.CreateThread(function()
    if Config.VersionCheck then
        local CurrentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
        if not CurrentVersion then
            print('^1Resource Version Check Failed!^7')
        end

        function VersionCheckHTTPRequest()
            PerformHttpRequest('https://raw.githubusercontent.com/ihyajb/versions/master/appearance.json', VersionCheck, 'GET')
        end

        function VersionCheck(err, response, headers)
            Citizen.Wait(3000)
            if err == 200 then
                local Data = json.decode(response)
                if CurrentVersion ~= Data.NewestVersion then
                    print( label )			
                    print('  ||    ^1Resource is outdated!^0')
                    print('  ||    Current version: ^2' .. Data.NewestVersion .. '^7')
                    print('  ||    Your version: ^1' .. CurrentVersion .. '^7')
                    print('  ||    Please download the lastest version from ^5' .. Data.DownloadLocation .. '^7')
                    if Data.Changes ~= '' then
                        print('  ||    \n  ||    ^5Changes: ^7' .. Data.Changes .. "\n^0  \\\\\n")
                    end
                else
                    print( label )			
                    print('  ||    ^2Resource is up to date!\n^0  ||\n  \\\\\n')
                end
            else
                print( label )			
                print('  ||    ^1There was an error getting the latest version information\n^0  ||\n  \\\\\n')
            end
            
            SetTimeout(60000000, VersionCheckHTTPRequest)
        end

        VersionCheckHTTPRequest()
    end
end)