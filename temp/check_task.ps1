#!/usr/bin/env pwsh
$headers = @{
    'Authorization' = 'gk_live_50b51f9fc7f786b6.3e79574f29cac9089de96cf172228a45237bc145c5318030'
    'X-Client-ID' = 'cli_a1b2c3d4e5f6789012345678abcdef90'
    'Content-Type' = 'application/json'
}
$body = '{"task_id":"69f2d23012142620e5a8bcfc"}'
$resp = Invoke-RestMethod -Uri 'https://openapi.biji.com/open/api/v1/resource/note/task/progress' -Method POST -Headers $headers -Body $body
$resp | ConvertTo-Json -Depth 5
