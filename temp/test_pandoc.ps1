$pandoc = "C:\Users\高原\AppData\Local\Microsoft\WinGet\Packages\JohnMacFarlane.Pandoc_Microsoft.Winget.Source_8wekyb3d8bbwe\pandoc-3.9.0.2\pandoc.exe"
$src = "C:\Users\高原\Desktop\Get笔记API文档.docx"
$dst = "C:\Users\高原\.stepclaw\workspace-main-2\temp\test-pandoc.md"
& $pandoc $src -o $dst
Write-Host "Done: $dst"
