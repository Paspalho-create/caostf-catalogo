# Sincroniza o catalogo publicado com a fonte (..\catalogo) e publica no GitHub Pages.
# Uso:  powershell -ExecutionPolicy Bypass -File .\atualizar.ps1
$ErrorActionPreference = "Stop"
$src = Join-Path (Split-Path $PSScriptRoot -Parent) "catalogo"
$dst = $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)

# favicon inline (sem requisicao externa; evita 404 de /favicon.ico)
$icon = "<link rel=`"icon`" href=`"data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0,0,32,32'%3E%3Crect%20width='32'%20height='32'%20rx='7'%20fill='%23d99a4e'/%3E%3Ctext%20x='16'%20y='23'%20font-family='Arial'%20font-size='20'%20font-weight='700'%20text-anchor='middle'%20fill='%2314161a'%3EC%3C/text%3E%3C/svg%3E`">"

$htmls = Get-ChildItem (Join-Path $src "catalogo-*.html")
foreach ($h in $htmls) {
  $txt = [IO.File]::ReadAllText($h.FullName, $utf8)
  if ($txt -notmatch 'rel="icon"') { $txt = ([regex]'</title>').Replace($txt, ('</title>' + $icon), 1) }
  [IO.File]::WriteAllText((Join-Path $dst $h.Name), $txt, $utf8)
}
$hub = Join-Path $dst "catalogo-moveis.html"
[IO.File]::WriteAllText((Join-Path $dst "index.html"), [IO.File]::ReadAllText($hub, $utf8), $utf8)

Write-Host "Copiado: $($htmls.Name -join ', ') + index.html"
if ((git -C $dst status --porcelain)) {
  git -C $dst add -A
  git -C $dst commit -m "catalogo: sincroniza com a fonte e republica" | Out-Null
  git -C $dst push origin main
  Write-Host "Publicado. GitHub Pages atualiza em ~1 min."
} else {
  Write-Host "Nada mudou; nada a publicar."
}
