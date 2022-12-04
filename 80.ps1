echo "
" ; 
$di = "C:\js" ; if (!($didi = Read-Host "    Start web-server at localhost [Type path or Enter for $di] ")){ $didi = $di } ; 
$po = "1212" ; if (!($popo = Read-Host "    Start web-server at localhost [Type port or Enter for $po] ")) { $popo = $po } ; 
cd $didi;
Write-Host -NoNewLine '
		-- Press any key to open browser...

';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Start-Process 'C:\Program Files\Mozilla Firefox\firefox.exe' -argumentlist "-url localhost:$popo"; 
cd $didi;
python -m http.server $popo