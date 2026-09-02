copy ..\TaurusTLS\Packages\d12\TaurusTLS_RTForIndy290.dproj .
copy ..\TaurusTLS\Packages\d12\TaurusTLS_RTForIndy290.dpk .
powershell -Command "(Get-Content 'TaurusTLS_RTForIndy290.dpk') -replace '..\\..\\Source\\', '..\\TaurusTLS\\Source\\' | Set-Content 'TaurusTLS_RTForIndy290.dpk'"
docinsight build
del TaurusTLS_RTForIndy290.dpk
del TaurusTLS_RTForIndy290.dproj