echo ""; echo ""; echo "   > Starting server from: ----> [$PWD]" ; $po = "1212" ; if (!($popo = Read-Host "   > Type port or Enter for: --> [$po]")) { $popo = $po } ; 
Write-Host -NoNewLine '
        -- Press [any key] to open browser... 
' ; 
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); Start-Process 'C:\Program Files\Mozilla Firefox\firefox.exe' -argumentlist "-url localhost:$popo"; python -m http.server $popo