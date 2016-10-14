$HOST = $Env:TARGET

If ($Env:TARGET -Match 'gnu') {
    if ($Env:TARGET -Match 'x86_64') {
        $Env:PATH += ';C:\msys64\mingw64\bin'
    } else {
        $Env:PATH += ';C:\msys64\mingw32\bin'
    }
} ElseIf ($Env:TARGET -Match 'i586') {
    $HOST = i686-pc-windows-msvc
}

[Net.ServicePointManager]::SecurityProtocol = 'Ssl3, Tls, Tls12'
Start-FileDownload 'https://win.rustup.rs' 'rustup-init.exe'

.\rustup-init --default-host $HOST --default-toolchain $Env:RUST_VERSION -y

$Env:PATH = 'C:\Users\appveyor\.cargo\bin;' + $Env:PATH

If ($Env:TARGET -ne $HOST) {
    rustup target add $Env:TARGET
}

rustc -Vv

cargo -V
